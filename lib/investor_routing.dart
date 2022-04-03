import 'package:Seedfund/model/user_model.dart';
import 'package:Seedfund/views/investor-auth/investor_registration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InvestorPageRouting extends StatefulWidget {
  final String? uid;
  const InvestorPageRouting({Key? key, this.uid}) : super(key: key);

  @override
  State<InvestorPageRouting> createState() => _InvestorPageRoutingState();
}

class _InvestorPageRoutingState extends State<InvestorPageRouting> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel userModel = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("investor_users")
        .doc(user!.uid)
        .get()
        .then((value) {
      // ignore: unnecessary_this
      this.userModel = UserModel.fromMap(value.data());
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
                          builder: (context) => const InvestorRegistration()),
                      (Route<dynamic> route) => false);
                });
              },
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[Text("${userModel.fullname}")],
        ),
      ),
    );
  }
}
