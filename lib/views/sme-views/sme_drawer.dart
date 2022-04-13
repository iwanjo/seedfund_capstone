import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../sme-auth/login.dart';

class SMEDrawer extends StatefulWidget {
  final String? uid;
  const SMEDrawer({Key? key, this.uid}) : super(key: key);

  @override
  State<SMEDrawer> createState() => _SMEDrawerState();
}

class _SMEDrawerState extends State<SMEDrawer> {
  FirebaseAuth authUser = FirebaseAuth.instance;
  var currentUser = FirebaseAuth.instance.currentUser;
  var currentUserLoginUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFFFFFFF),
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF2AB271)),
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
                backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
                        str.split(" ").map((l) => l[0]).take(2).join(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2AB271)),
                      );
                    } else {
                      throw Error;
                    }
                  },
                )),
          ),
          ListTile(
            leading: IconButton(
              icon: const Icon(Icons.share_outlined),
              onPressed: () {},
            ),
            title: const Text(
              "Recommend Seedfund",
            ),
            onTap: () {},
          ),
          ListTile(
            leading: IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () {},
            ),
            title: const Text(
              "Settings",
            ),
            onTap: () {},
          ),
          ListTile(
            leading: IconButton(
              icon: const Icon(Icons.help_center_outlined),
              onPressed: () {},
            ),
            title: const Text(
              "Help and FAQs",
            ),
            onTap: () {},
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
    );
  }
}
