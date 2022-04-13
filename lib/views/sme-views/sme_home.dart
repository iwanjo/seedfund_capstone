// ignore_for_file: prefer_const_constructors, await_only_futures, unused_local_variable

import 'package:Seedfund/model/sme_user.dart';
import 'package:Seedfund/views/sme-views/create_funding.dart';
import 'package:Seedfund/views/sme-views/sme_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SMEHome extends StatefulWidget {
  final String? uid;
  const SMEHome({Key? key, this.uid}) : super(key: key);

  @override
  State<SMEHome> createState() => _SMEHomeState();
}

class _SMEHomeState extends State<SMEHome> {
  User? user = FirebaseAuth.instance.currentUser;
  var currentUser = FirebaseAuth.instance.currentUser;

  SMEUserModel userModel = SMEUserModel();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("sme_users")
        .doc(user!.uid)
        .get()
        .then((value) {
      // ignore: unnecessary_this
      this.userModel = SMEUserModel.fromMap(value.data());
      setState(() {});
    });
  }

  var currentUserLoginUser = FirebaseAuth.instance.currentUser;
  Future getUser() async {
    var currentUserLoginUser = await FirebaseAuth.instance.currentUser;
    var firebaseUser = await FirebaseFirestore.instance
        .collection("sme_users")
        .doc(currentUserLoginUser!.uid);
  }

  FirebaseAuth authUser = FirebaseAuth.instance;

  final currentUserName = FutureBuilder<DocumentSnapshot>(
    future: FirebaseFirestore.instance
        .collection("sme_users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get(),
    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
      if (snapshot.hasError) {
        return const Text("Something went wrong");
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

  final businessName = FutureBuilder<DocumentSnapshot>(
    future: FirebaseFirestore.instance
        .collection("sme_users")
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
          '${data['companyname']}',
          style: const TextStyle(fontSize: 13.0),
        );
      } else {
        throw Error;
      }
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => CreateFundingProject(
                      uid: user!.uid,
                    )),
              ),
            );
          },
          backgroundColor: Color(0xFF00B1FF),
          splashColor: Color(0xFF2AB271),
          child: Icon(Icons.add),
        ),
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
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              physics: BouncingScrollPhysics(),
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
                            "Create funding projects for",
                            style: TextStyle(fontSize: 13.0),
                            maxLines: 2,
                          ),
                          businessName,
                        ],
                      ),
                      Image.asset(
                        "assets/sme-home-pana.png",
                        fit: BoxFit.contain,
                        height: 150,
                        width: 150,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  "Funding Projects",
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 8.0),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("fundingProjects")
                        .where("uid", isEqualTo: currentUser!.uid)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text("Error noted");
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      if (snapshot.hasData) {
                        return ListView(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data()! as Map<String, dynamic>;
                            return ListTile(
                              onTap: () {},
                              leading: CircleAvatar(
                                radius: 40,
                                backgroundColor: Color(0xFFE6F9F0),
                                child: Icon(
                                  Icons.library_books,
                                  color: Color(0xFF2AB271),
                                ),
                              ),
                              title: Text(data['projectName']),
                              subtitle: Text("KSH " + data['amount']),
                            );
                          }).toList(),
                        );
                      } else {
                        throw Error().toString();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        drawer: SMEDrawer(
          uid: user!.uid,
        ));
  }
}
