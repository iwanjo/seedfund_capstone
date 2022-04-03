import 'package:Seedfund/model/sme_user.dart';
import 'package:Seedfund/views/sme-auth/login.dart';
import 'package:Seedfund/views/sme-auth/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SMEHome extends StatefulWidget {
  final String? uid;
  const SMEHome({Key? key, this.uid}) : super(key: key);

  @override
  State<SMEHome> createState() => _SMEHomeState();
}

class _SMEHomeState extends State<SMEHome> {
  User? user = FirebaseAuth.instance.currentUser;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        backgroundColor: const Color(0xFFFFFFFF),
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection("sme_users")
                    .doc(currentUserLoginUser!.uid)
                    .get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text("sth went wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                    return Text('${data['fullname']}');
                  } else {
                    throw Error;
                  }
                },
              ),
              accountEmail: FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection("sme_users")
                    .doc(currentUserLoginUser!.uid)
                    .get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Oops, something went wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                    return Text('${data['email']}');
                  } else {
                    throw Error;
                  }
                },
              ),
              currentAccountPicture: CircleAvatar(
                  backgroundColor: const Color(0xFF2AB271),
                  child: FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection("sme_users")
                        .doc(currentUserLoginUser!.uid)
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
                            str.split(" ").map((l) => l[0]).take(2).join());
                      } else {
                        throw Error;
                      }
                    },
                  )),
            ),
            ListTile(
              leading: IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () => authUser.signOut().then((res) {
                  Fluttertoast.showToast(msg: "Signed out successfully");
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const SMELogin()),
                      (Route<dynamic> route) => false);
                }),
              ),
              title: const Text(
                "Sign out",
              ),
              onTap: () {
                FirebaseAuth auth = FirebaseAuth.instance;
                auth.signOut().then((res) {
                  Fluttertoast.showToast(msg: "Signed out successfully");

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const SMELogin()),
                      (Route<dynamic> route) => false);
                });
              },
            ),
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
