import 'package:Seedfund/model/user_model.dart';
import 'package:Seedfund/views/investor-views/investor_chat.dart';
import 'package:Seedfund/views/investor-views/investor_discover.dart';
import 'package:Seedfund/views/investor-views/investor_home.dart';
import 'package:Seedfund/views/investor-views/investor_profile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class InvestorPageRouting extends StatefulWidget {
  final String? uid;
  const InvestorPageRouting({Key? key, this.uid}) : super(key: key);

  @override
  State<InvestorPageRouting> createState() => _InvestorPageRoutingState();
}

class _InvestorPageRoutingState extends State<InvestorPageRouting> {
  int _selectedIndex = 0;
  final loggedInUser = FirebaseAuth.instance.currentUser;
  late final List<Widget> _widgetOptions = <Widget>[
    InvestorHome(
      uid: loggedInUser!.uid,
    ),
    InvestorDiscover(
      uid: loggedInUser!.uid,
    ),
    InvestorChat(
      uid: loggedInUser!.uid,
    ),
    InvestorProfile(
      uid: loggedInUser!.uid,
    ),
  ];
  User? user = FirebaseAuth.instance.currentUser;
  UserModel userModel = UserModel();

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
                "Chat",
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
