// ignore_for_file: prefer_const_constructors, await_only_futures, unused_local_variable

import 'package:Seedfund/sme_routing.dart';
import 'package:Seedfund/views/investor-auth/investor_login.dart';
import 'package:Seedfund/views/sme-views/sme_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SMEProfile extends StatefulWidget {
  final String? uid;

  const SMEProfile({Key? key, this.uid}) : super(key: key);

  @override
  State<SMEProfile> createState() => _SMEProfileState();
}

class _SMEProfileState extends State<SMEProfile> {
  var currentUser = FirebaseAuth.instance.currentUser;
  Future getUser() async {
    var currentUser = await FirebaseAuth.instance.currentUser;
    var firebaseUser = await FirebaseFirestore.instance
        .collection("sme_users")
        .doc(currentUser!.uid);
  }

  User? user = FirebaseAuth.instance.currentUser;

  FirebaseAuth authUser = FirebaseAuth.instance;

  final currentUserName = FutureBuilder<DocumentSnapshot>(
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
          '${data['fullname']}',
          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
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
          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        );
      } else {
        throw Error;
      }
    },
  );

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
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: const Color(0xFF2AB271),
                  child: FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection("sme_users")
                        .doc(currentUser!.uid)
                        .get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text("Something went wrong");
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        final str = '${data['fullname']}';
                        return Text(
                          str.split(" ").map((l) => l[0]).take(2).join(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        );
                      } else {
                        throw Error;
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: currentUserName,
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: businessName,
              ),
              SizedBox(
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
                    var data;
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 600,
                            child: ListView(
                              children: snapshot.data!.docs.map(
                                (DocumentSnapshot document) {
                                  data = document.data()!;

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
                                    title: Text(
                                      data['projectName'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    subtitle: Text(
                                      "KSH " + data['amount'],
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    throw Error().toString();
                  } else {
                    return Text("data");
                  }
                },
              ),

              // FutureBuilder(
              //   future: FirebaseFirestore.instance
              //       .collection("fundingProjects")
              //       .get(),
              //   builder: (context,
              //       AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
              //           snapshot) {
              //     if (snapshot.hasError) {
              //       return Text("Sth went wrong");
              //     }

              // if (snapshot.data!.docs.isEmpty) {
              //   return Center(
              //     child: Column(
              //       // ignore: prefer_const_literals_to_create_immutables
              //       children: [
              //         Text(
              //           "You haven't created any funding projects yet",
              //         ),
              //         SizedBox(
              //           height: 24,
              //         ),
              //         MaterialButton(
              //           onPressed: () {
              //             Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                     builder: (context) => SMEPageRouting(
              //                           uid: user!.uid,
              //                         )));
              //           },
              //           color: const Color(0xFF2AB271),
              //           textColor: Colors.white,
              //           shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(10)),
              //           padding: const EdgeInsets.symmetric(
              //               vertical: 12.0, horizontal: 20.0),
              //           child: const Text(
              //             "Create Funding Project",
              //             style: TextStyle(
              //                 fontWeight: FontWeight.bold, fontSize: 15.0),
              //           ),
              //         ),
              //       ],
              //     ),
              //   );
              // }
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return CircularProgressIndicator();
              //     }

              //     if (snapshot.hasData) {
              //       var data;
              //       return SingleChildScrollView(
              //         child: Column(
              //           children: [
              //             SizedBox(
              //               height: 600,
              //               child: ListView(
              //                 children: snapshot.data!.docs.map(
              //                   (DocumentSnapshot document) {
              //                     data = document.data()!;

              //                     return ListTile(
              //                       onTap: () {},
              //                       leading: CircleAvatar(
              //                         radius: 40,
              //                         backgroundColor: Color(0xFFE6F9F0),
              //                         child: Icon(
              //                           Icons.library_books,
              //                           color: Color(0xFF2AB271),
              //                         ),
              //                       ),
              //                       title: Text(
              //                         data['projectName'],
              //                         style: TextStyle(
              //                           fontWeight: FontWeight.bold,
              //                           fontSize: 16.0,
              //                         ),
              //                       ),
              //                       subtitle: Text(
              //                         "KSH " + data['amount'],
              //                         style: TextStyle(fontSize: 14.0),
              //                       ),
              //                     );
              //                   },
              //                 ).toList(),
              //               ),
              //             ),
              //           ],
              //         ),
              //       );
              //     }
              //     throw Error().toString();
              //   },
              // ),
            ],
          ),
        ),
      ),
      drawer: SMEDrawer(
        uid: currentUser!.uid,
      ),
    );
  }
}
