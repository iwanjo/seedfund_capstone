// ignore_for_file: prefer_const_constructors

import 'package:Seedfund/views/investor-views/chat/chat_details.dart';
import 'package:Seedfund/views/investor-views/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InvestorChat extends StatefulWidget {
  final String? uid;
  const InvestorChat({Key? key, this.uid}) : super(key: key);

  @override
  State<InvestorChat> createState() => _InvestorChatState();
}

class _InvestorChatState extends State<InvestorChat> {
  var currentUser = FirebaseAuth.instance.currentUser;
  FirebaseAuth authUser = FirebaseAuth.instance;
  var currentUserUid = FirebaseAuth.instance.currentUser!.uid;

  void userChatScreen(BuildContext context, String name, String uid) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => ChatDetails(
              receiverName: name,
              otherUserUid: uid,
            )),
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
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Chats",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("investor_users")
                    .where('uid', isNotEqualTo: currentUserUid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text("There is an error");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasData) {
                    return ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        final str = '${data['fullname']}';
                        return ListTile(
                          onTap: () {
                            userChatScreen(
                                context, data['fullname'], data['uid']);
                          },
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundColor: const Color(0xFF2AB271),
                            child: Text(
                                str.split(" ").map((l) => l[0]).take(2).join(),
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                          title: Text(data['fullname']),
                          subtitle: Text(data['email']),
                        );
                      }).toList(),
                    );
                  } else {
                    return Text("error");
                  }
                },
              ),
            ),
          ],
        ),
      ),
      drawer: NavigationDrawer(uid: currentUserUid),
    );
  }
}
