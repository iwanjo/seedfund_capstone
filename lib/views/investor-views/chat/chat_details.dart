// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors_in_immutables, no_logic_in_create_state, prefer_final_fields, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChatDetails extends StatefulWidget {
  final otherUserUid;
  final receiverName;

  ChatDetails({Key? key, this.otherUserUid, this.receiverName})
      : super(key: key);

  @override
  _ChatDetailsState createState() =>
      _ChatDetailsState(otherUserUid, receiverName);
}

class _ChatDetailsState extends State<ChatDetails> {
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  final otherUserUid;
  final receiverName;
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;
  var chatDocId;
  var messageController = TextEditingController();
  _ChatDetailsState(this.otherUserUid, this.receiverName);
  @override
  void initState() {
    super.initState();
    getUser();
  }

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
          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        );
      } else {
        throw Error;
      }
    },
  );

  void getUser() async {
    await chats
        .where('users', isEqualTo: {otherUserUid: null, currentUserId: null})
        .limit(1)
        .get()
        .then(
          (QuerySnapshot querySnapshot) async {
            if (querySnapshot.docs.isNotEmpty) {
              setState(() {
                chatDocId = querySnapshot.docs.single.id;
              });
            } else {
              await chats.add({
                'users': {currentUserId: null, otherUserUid: null},
                'names': {
                  currentUserId: FirebaseAuth.instance.currentUser?.displayName,
                  otherUserUid: receiverName
                }
              }).then((value) => {chatDocId = value});
            }
          },
        )
        .catchError((error) {
          Fluttertoast.showToast(msg: "There is an error");
        });
  }

  void sendMessage(String userMessage) {
    final messageTime = DateTime.now();

    if (userMessage == '') return;
    chats.doc(chatDocId).collection('messages').add({
      'messageSent': messageTime,
      'uid': currentUserId,
      'receiverName': receiverName,
      'userMessage': userMessage
    }).then((value) {
      messageController.text = '';
    });
  }

  bool isSender(String receiver) {
    return receiver == currentUserId;
  }

  Alignment getAlignment(receiver) {
    if (receiver == currentUserId) {
      return Alignment.topRight;
    }
    return Alignment.topLeft;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: chats
          .doc(chatDocId)
          .collection('messages')
          .orderBy('messageSent', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("There is an error"),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          var data;
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black),
              title: Text(
                receiverName,
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              centerTitle: true,
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      reverse: true,
                      children: snapshot.data!.docs.map(
                        (DocumentSnapshot document) {
                          data = document.data()!;

                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: ChatBubble(
                              clipper: ChatBubbleClipper6(
                                nipSize: 1,
                                radius: 12,
                                type: isSender(data['uid'].toString())
                                    ? BubbleType.sendBubble
                                    : BubbleType.receiverBubble,
                              ),
                              alignment: getAlignment(data['uid'].toString()),
                              margin: EdgeInsets.only(top: 20),
                              backGroundColor: isSender(data['uid'].toString())
                                  ? Color(0xFF2AB271)
                                  : Color(0xFF00B1FF),
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.7,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(data['userMessage'],
                                            style: TextStyle(
                                                color: isSender(
                                                        data['uid'].toString())
                                                    ? Colors.white
                                                    : Colors.white),
                                            maxLines: 100,
                                            overflow: TextOverflow.ellipsis)
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          data['messageSent'] == null
                                              ? DateTime.now().toString()
                                              : data['messageSent']
                                                  .toDate()
                                                  .toString()
                                                  .substring(11, 16),
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: isSender(
                                                      data['uid'].toString())
                                                  ? Colors.white
                                                  : Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, top: 24, bottom: 16),
                          child: TextField(
                            keyboardType: TextInputType.text,
                            controller: messageController,
                            decoration: const InputDecoration(
                              filled: true,
                              hintText: "Enter your message",
                              fillColor: Color(0xFFF0F0F0),
                              // border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      MaterialButton(
                          child: Icon(Icons.send),
                          onPressed: () => sendMessage(messageController.text))
                    ],
                  )
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
