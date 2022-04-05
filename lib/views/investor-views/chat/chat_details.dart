// // ignore_for_file: prefer_const_constructors

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_chat_bubble/bubble_type.dart';
// import 'package:flutter_chat_bubble/chat_bubble.dart';
// import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class ChatDetail extends StatefulWidget {
//   final String? friendUid;
//   final String? friendName;
//   const ChatDetail({Key? key, this.friendUid, this.friendName})
//       : super(key: key);

//   @override
//   State<ChatDetail> createState() => _ChatDetailState(friendUid, friendName);
// }

// class _ChatDetailState extends State<ChatDetail> {
//   CollectionReference chats = FirebaseFirestore.instance.collection("chats");
//   final String? friendUid;
//   final String? friendName;
//   final currentUser = FirebaseAuth.instance.currentUser!.uid;
//   var chatDocId;
//   TextEditingController messageController = TextEditingController();

//   _ChatDetailState(this.friendUid, this.friendName);
//   @override
//   void initState() {
//     super.initState();
//     chats
//         .where('investor_users',
//             isEqualTo: {friendUid: null, currentUser: null})
//         .limit(1)
//         .get()
//         .then((QuerySnapshot querySnapshot) async {
//           if (querySnapshot.docs.isNotEmpty) {
//             chatDocId = querySnapshot.docs.single.id;
//           } else {
//             await chats.add({
//               'users': {
//                 currentUser: null,
//                 friendUid: null,
//               }
//             }).then((res) {
//               chatDocId = res;
//             }).then((value) => {chatDocId = value});
//           }
//         })
//         .catchError((err) {
//           Fluttertoast.showToast(msg: "Oopsie, there's been an issue");
//         });
//   }

//   void sendMessage(String message) {
//     if (message == '') ;
//     chats.doc(chatDocId).collection("messages").add({
//       'messageCreatedOn': FieldValue.serverTimestamp(),
//       'uid': currentUser,
//       'friendName': friendName,
//       'message': message
//     }).then((value) {
//       messageController.text = "";
//     });
//   }

//   bool isSender(String friend) {
//     return friend == currentUser;
//   }

//   Alignment getAlignment(friend) {
//     if (friend == currentUser) {
//       return Alignment.topRight;
//     }
//     return Alignment.topLeft;
//   }

// ignore_for_file: prefer_const_constructors

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseFirestore.instance
//           .collection("chats")
//           .doc(chatDocId)
//           .collection('messages')
//           .orderBy('createdOn', descending: true)
//           .snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text("There's an error here");
//         }
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const CircularProgressIndicator();
//         }
//         if (snapshot.hasData) {
//           var data;
//           return Scaffold(
// appBar: AppBar(
//   elevation: 0,
//   backgroundColor: Colors.white,
//   iconTheme: IconThemeData(color: Colors.black),
//   title: Text(
//     friendName.toString(),
//     style: TextStyle(color: Colors.black, fontSize: 16.0),
//   ),
//   centerTitle: true,
// ),
//             body: SafeArea(
//               child: Column(
//                 children: [
//                   Expanded(
//                       child: ListView(
//                     reverse: true,
//                     children: snapshot.data!.docs.map(
//                       (DocumentSnapshot document) {
//                         data = document.data()!;
//                         print(document.toString());
//                         print(data['message']);
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                           child: ChatBubble(
//                             clipper: ChatBubbleClipper6(
//                               nipSize: 0,
//                               radius: 0,
//                               type: isSender(data['uid'].toString())
//                                   ? BubbleType.sendBubble
//                                   : BubbleType.receiverBubble,
//                             ),
//                             alignment: getAlignment(data['uid'].toString()),
//                             margin: EdgeInsets.only(top: 20),
//                             backGroundColor: isSender(data['uid'].toString())
//                                 ? Color(0xFF2AB271)
//                                 : Color.fromARGB(255, 152, 152, 236),
//                             child: Container(
//                               constraints: BoxConstraints(
//                                 maxWidth:
//                                     MediaQuery.of(context).size.width * 0.7,
//                               ),
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     children: [
//                                       Text(data['message'],
//                                           style: TextStyle(
//                                               color: isSender(
//                                                       data['uid'].toString())
//                                                   ? Colors.white
//                                                   : Colors.black),
//                                           maxLines: 100,
//                                           overflow: TextOverflow.ellipsis)
//                                     ],
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       Text(
//                                         data['createdOn'] == null
//                                             ? DateTime.now().toString()
//                                             : data['createdOn']
//                                                 .toDate()
//                                                 .toString(),
//                                         style: TextStyle(
//                                             fontSize: 10,
//                                             color:
//                                                 isSender(data['uid'].toString())
//                                                     ? Colors.white
//                                                     : Colors.black),
//                                       )
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ).toList(),
//                   )),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       Expanded(
//                         child: TextField(
//                           controller: messageController,
//                         ),
//                       ),
//                       MaterialButton(
//                           child: Icon(Icons.send),
//                           onPressed: () {
//                             sendMessage(messageController.text);
//                           }),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         } else {
//           throw Error;
//         }
//       },
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChatDetails extends StatefulWidget {
  final friendUid;
  final friendName;

  ChatDetails({Key? key, this.friendUid, this.friendName}) : super(key: key);

  @override
  _ChatDetailsState createState() => _ChatDetailsState(friendUid, friendName);
}

class _ChatDetailsState extends State<ChatDetails> {
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  final friendUid;
  final friendName;
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;
  var chatDocId;
  var _textController = new TextEditingController();
  _ChatDetailsState(this.friendUid, this.friendName);
  @override
  void initState() {
    super.initState();
    checkUser();
  }

  void checkUser() async {
    await chats
        .where('users', isEqualTo: {friendUid: null, currentUserId: null})
        .limit(1)
        .get()
        .then(
          (QuerySnapshot querySnapshot) async {
            if (querySnapshot.docs.isNotEmpty) {
              setState(() {
                chatDocId = querySnapshot.docs.single.id;
              });

              print(chatDocId);
            } else {
              await chats.add({
                'users': {currentUserId: null, friendUid: null},
                'names': {
                  currentUserId: FirebaseAuth.instance.currentUser?.displayName,
                  friendUid: friendName
                }
              }).then((value) => {chatDocId = value});
            }
          },
        )
        .catchError((error) {
          Fluttertoast.showToast(msg: "There is an error");
        });
  }

  void sendMessage(String msg) {
    if (msg == '') return;
    chats.doc(chatDocId).collection('messages').add({
      'createdOn': FieldValue.serverTimestamp(),
      'uid': currentUserId,
      'friendName': friendName,
      'msg': msg
    }).then((value) {
      _textController.text = '';
    });
  }

  bool isSender(String friend) {
    return friend == currentUserId;
  }

  Alignment getAlignment(friend) {
    if (friend == currentUserId) {
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
          .orderBy('createdOn', descending: true)
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
                friendName,
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
                                        Text(data['msg'],
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
                                          data['createdOn'] == null
                                              ? DateTime.now().toString()
                                              : data['createdOn']
                                                  .toDate()
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: isSender(
                                                      data['uid'].toString())
                                                  ? Colors.white
                                                  : Colors.white),
                                        )
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
                            controller: _textController,
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
                          onPressed: () => sendMessage(_textController.text))
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
