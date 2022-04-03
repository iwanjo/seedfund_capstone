import 'package:Seedfund/model/sme_user.dart';
import 'package:Seedfund/views/sme-auth/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class SMEPageRouting extends StatefulWidget {
  final String? uid;
  const SMEPageRouting({Key? key, this.uid}) : super(key: key);

  @override
  State<SMEPageRouting> createState() => _SMEPageRoutingState();
}

class _SMEPageRoutingState extends State<SMEPageRouting> {
  User? user = FirebaseAuth.instance.currentUser;
  SMEUserModel userModel = SMEUserModel();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () => null,
              ),
              title: const Text(
                "Sign out",
              ),
              onTap: () {
                FirebaseAuth auth = FirebaseAuth.instance;
                auth.signOut().then((res) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SMERegister()),
                      (Route<dynamic> route) => false);
                });
              },
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text("${userModel.fullname}"),
            Text("${userModel.companyname}"),
            Text("${userModel.email}"),
          ],
        ),
      ),
    );
  }
}
