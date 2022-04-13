// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:Seedfund/views/sme-views/sme_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:outline_search_bar/outline_search_bar.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class SMEDiscover extends StatefulWidget {
  final String? uid;

  const SMEDiscover({Key? key, this.uid}) : super(key: key);

  @override
  State<SMEDiscover> createState() => _SMEDiscoverState();
}

class _SMEDiscoverState extends State<SMEDiscover>
    with TickerProviderStateMixin {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    TabController _tabBarController = TabController(length: 8, vsync: this);

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
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: <Widget>[
                OutlineSearchBar(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  textStyle: TextStyle(fontSize: 14.0),
                  borderRadius: BorderRadius.circular(35),
                  hintText: "Search",
                  backgroundColor: Color(0xFFF0F0F0),
                  borderColor: Color(0xFFF0F0F0),
                  searchButtonIconColor: Color(0xFF2AB271),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Discover SMEs Around You",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 35.0,
                  child: TabBar(
                    controller: _tabBarController,
                    isScrollable: true,
                    labelColor: Colors.white,

                    unselectedLabelColor: Colors.grey,
                    indicator: RectangularIndicator(
                      color: Color(0xFF00B1FF),
                      topLeftRadius: 100,
                      topRightRadius: 100,
                      bottomLeftRadius: 100,
                      bottomRightRadius: 100,
                      paintingStyle: PaintingStyle.fill,
                    ),
                    // ignore: prefer_const_literals_to_create_immutables
                    tabs: [
                      Tab(
                        text: "All",
                      ),
                      Tab(
                        text: "Agriculture",
                      ),
                      Tab(
                        text: "Energy",
                      ),
                      Tab(
                        text: "Entertainment",
                      ),
                      Tab(
                        text: "Finance",
                      ),
                      Tab(
                        text: "Technology",
                      ),
                      Tab(
                        text: "Tourism",
                      ),
                      Tab(
                        text: "Transport",
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1500,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                  child: TabBarView(
                    controller: _tabBarController,
                    children: [
                      allBusinessView(),
                      allBusinessView(),
                      allBusinessView(),
                      allBusinessView(),
                      allBusinessView(),
                      allBusinessView(),
                      allBusinessView(),
                      allBusinessView(),
                    ],
                  ),
                ),
              ],
            ),
          )),
      drawer: SMEDrawer(uid: user!.uid),
    );
  }

  allBusinessView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
      child: Column(
        children: <Widget>[
          Card(
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            child: InkWell(
              onTap: () {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    // alignment: Alignment.bottomLeft,
                    children: <Widget>[
                      Ink.image(
                        height: 160,
                        image: AssetImage("assets/discover-kenya.png"),
                        fit: BoxFit.fitWidth,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 8.0,
                            ),
                            child: Text(
                              "Discover Kenya",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 10.0,
                        ),
                        child: Text(
                            "Discover Kenya allows creative agencies and photographers to share visual content of Kenya and create communities"),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: <Widget>[
                          const SizedBox(width: 10),
                          Icon(Icons.monetization_on),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.0,
                              vertical: 6.0,
                            ),
                            child: (Text(
                              "KSH 100,000",
                              style: TextStyle(fontSize: 12.0),
                            )),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.calendar_today),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.0,
                              vertical: 6.0,
                            ),
                            child: (Text(
                              "20 Days",
                              style: TextStyle(fontSize: 12.0),
                            )),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            child: InkWell(
              onTap: () {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    // alignment: Alignment.bottomLeft,
                    children: <Widget>[
                      Ink.image(
                        height: 160,
                        image: AssetImage("assets/recycling.jpeg"),
                        fit: BoxFit.fitWidth,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 8.0,
                            ),
                            child: Text(
                              "Circular Venture",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 10.0,
                        ),
                        child: Text(
                            "We recycle plastic bottles and turn them into quality shirts and other clothing materials."),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: <Widget>[
                          const SizedBox(width: 10),
                          Icon(Icons.monetization_on),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.0,
                              vertical: 6.0,
                            ),
                            child: (Text(
                              "300,000/500,000 KSH Collected",
                              style: TextStyle(fontSize: 12.0),
                            )),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.people),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.0,
                              vertical: 6.0,
                            ),
                            child: (Text(
                              "554 Investors",
                              style: TextStyle(fontSize: 12.0),
                            )),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
