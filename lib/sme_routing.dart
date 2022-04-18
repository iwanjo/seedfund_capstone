import 'package:Seedfund/views/sme-views/sme_chat.dart';
import 'package:Seedfund/views/sme-views/sme_discover.dart';
import 'package:Seedfund/views/sme-views/sme_home.dart';
import 'package:Seedfund/views/sme-views/sme_profile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class SMEPageRouting extends StatefulWidget {
  final String? uid;
  const SMEPageRouting({Key? key, this.uid}) : super(key: key);

  @override
  State<SMEPageRouting> createState() => _SMEPageRoutingState();
}

class _SMEPageRoutingState extends State<SMEPageRouting> {
  int _selectedIndex = 0;
  final loggedInUser = FirebaseAuth.instance.currentUser;
  late final List<Widget> _widgetOptions = <Widget>[
    SMEHome(
      uid: loggedInUser!.uid,
    ),
    SMEDiscover(
      uid: loggedInUser!.uid,
    ),
    SMEChat(
      uid: loggedInUser!.uid,
    ),
    SMEProfile(
      uid: loggedInUser!.uid,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: SalomonBottomBar(
          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.home),
              title: const Text(
                "Home",
                style: TextStyle(
                    fontSize: 14.0, fontFamily: "GT-Walsheim-Regular"),
              ),
              selectedColor: const Color(0xFF2AB271),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.category),
              title: const Text(
                "Discover",
                style: TextStyle(
                    fontSize: 14.0, fontFamily: "GT-Walsheim-Regular"),
              ),
              selectedColor: const Color(0xFF2AB271),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.message),
              title: const Text(
                "Chats",
                style: TextStyle(
                    fontSize: 14.0, fontFamily: "GT-Walsheim-Regular"),
              ),
              selectedColor: const Color(0xFF2AB271),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.person),
              title: const Text(
                "Profile",
                style: TextStyle(
                    fontSize: 14.0, fontFamily: "GT-Walsheim-Regular"),
              ),
              selectedColor: const Color(0xFF2AB271),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
    );
  }
}
