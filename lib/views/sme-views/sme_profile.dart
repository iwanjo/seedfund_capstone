// ignore_for_file: prefer_const_constructors, await_only_futures, unused_local_variable

import 'package:Seedfund/views/sme-views/sme_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
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
        uid: currentUser!.uid,
      ),
    );
  }
}
