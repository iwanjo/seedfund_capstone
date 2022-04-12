// ignore_for_file: prefer_const_constructors, await_only_futures, unused_local_variable
// ignore for file: prefer_const_literals_to_create_immutables

import 'package:Seedfund/model/sme_project_info.dart';
import 'package:Seedfund/views/investor-auth/investor_login.dart';
import 'package:Seedfund/views/investor-views/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Seedfund/model/sme_view_model.dart';

class InvestorHome extends StatefulWidget {
  final String? uid;
  const InvestorHome({Key? key, this.uid}) : super(key: key);

  @override
  State<InvestorHome> createState() => _InvestorHomeState();
}

class _InvestorHomeState extends State<InvestorHome> {
  var currentUser = FirebaseAuth.instance.currentUser;
  Future getUser() async {
    var currentUser = await FirebaseAuth.instance.currentUser;
    var firebaseUser = await FirebaseFirestore.instance
        .collection("investor_users")
        .doc(currentUser!.uid);
  }

  FirebaseAuth authUser = FirebaseAuth.instance;

  final currentUserName = FutureBuilder<DocumentSnapshot>(
    future: FirebaseFirestore.instance
        .collection("investor_users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get(),
    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
      if (snapshot.hasError) {
        return const Text("sth went wrong");
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      }
      if (snapshot.connectionState == ConnectionState.done) {
        Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;
        return Text(
          '${data['fullname']}',
          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        );
      } else {
        throw Error;
      }
    },
  );
  smeCard(SMEView attribute) {
    return Center(
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SMEProjectInfo(
                          coverImg: attribute.logo,
                          projectTitle: attribute.projectName,
                          projectDescription: attribute.projectDescription,
                          amount: attribute.amount,
                          deadline: attribute.deadline,
                        )));
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Image.network(
                    attribute.logo,
                    fit: BoxFit.fitWidth,
                  ),
                  // Ink.image(
                  //   image: attribute.logo,
                  //   fit: BoxFit.fitWidth,
                  // ),
                ],
              ),
              const SizedBox(height: 8),
              Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 8.0,
                        ),
                        child: Text(
                          attribute.projectName,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    child: Text(
                      attribute.projectDescription,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.monetization_on),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.0,
                          vertical: 6.0,
                        ),
                        child: (Text(
                          "KSH " + attribute.amount,
                          style: TextStyle(fontSize: 12.0),
                        )),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.calendar_today),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.0,
                          vertical: 6.0,
                        ),
                        child: (Text(
                          attribute.deadline + " Days",
                          style: TextStyle(fontSize: 12.0),
                        )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Image.asset(
            "assets/seedfund-logomark.png",
            fit: BoxFit.contain,
            height: 28,
            width: 28,
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.more_vert_rounded),
                tooltip: 'See more',
                onPressed: () {}),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            height: 2000,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    // ignore: prefer_const_literals_to_create_immutables
                    boxShadow: [
                      const BoxShadow(
                        color: Color(0xFFE6F9F0),
                      ),
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                "Welcome ",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              currentUserName,
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text(
                            "Invest in up and coming,",
                            style: TextStyle(fontSize: 14.0),
                            maxLines: 2,
                          ),
                          const Text(
                            "impactful SMEs in Kenya",
                            style: TextStyle(fontSize: 14.0),
                            maxLines: 2,
                          ),
                        ],
                      ),
                      Image.asset(
                        "assets/invest-pana.png",
                        fit: BoxFit.contain,
                        height: 150,
                        width: 150,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Latest Investment Opportunities",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("fundingProjects")
                        .get(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> smeMap =
                                snapshot.data!.docs[index].data();

                            SMEView attribute = SMEView(
                                smeMap['logoUrl'],
                                smeMap['projectName'],
                                smeMap['projectDescription'],
                                smeMap['amount'],
                                smeMap['deadline']);
                            return smeCard(attribute);
                          },
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      if (snapshot.hasError) {
                        return Text("Error");
                      }
                      throw Error();
                    }),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        drawer: NavigationDrawer(
          uid: currentUser!.uid,
        ));
  }
}
