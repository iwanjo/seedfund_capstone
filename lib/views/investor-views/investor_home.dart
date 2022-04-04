// ignore_for_file: prefer_const_constructors
// ignore for file: prefer_const_literals_to_create_immutables

import 'package:Seedfund/views/investor-auth/investor_login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InvestorHome extends StatefulWidget {
  final String? uid;
  const InvestorHome({Key? key, this.uid}) : super(key: key);

  @override
  State<InvestorHome> createState() => _InvestorHomeState();
}

class _InvestorHomeState extends State<InvestorHome> {
  var currentUser = FirebaseAuth.instance.currentUser;
  Future getUser() async {
    var currentUser = await FirebaseAuth.instance.currentUser;
    var firebaseUser = await FirebaseFirestore.instance
        .collection("investor_users")
        .doc(currentUser!.uid);
  }

  FirebaseAuth authUser = FirebaseAuth.instance;

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
          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        );
      } else {
        throw Error;
      }
    },
  );

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
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  // ignore: prefer_const_literals_to_create_immutables
                  boxShadow: [
                    const BoxShadow(
                      color: Color(0xFFE6F9F0),
                    ),
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              "Welcome ",
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            currentUserName,
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "Invest in up and coming,",
                          style: TextStyle(fontSize: 14.0),
                          maxLines: 2,
                        ),
                        const Text(
                          "impactful SMEs in Kenya",
                          style: TextStyle(fontSize: 14.0),
                          maxLines: 2,
                        ),
                      ],
                    ),
                    Image.asset(
                      "assets/invest-pana.png",
                      fit: BoxFit.contain,
                      height: 150,
                      width: 150,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Latest Investment Opportunities",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(0),
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
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
                                  image:
                                      AssetImage("assets/foresight-cover.png"),
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
                                        "Foresight Agricultural Insights",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
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
                                      "Using agricultural drone technology to help determine subsistence crop quality and estimate yields in Limuru"),
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
                                        "1.21/2 ETH Collected",
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
                                        "1,021 Investors",
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
                  ),
                ),
              ),
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(0),
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
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
                                  image:
                                      AssetImage("assets/discover-kenya.png"),
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
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
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
                                        "0.45/2 ETH Collected",
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
                                        "844 Investors",
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
                  ),
                ),
              ),
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(0),
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
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
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
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
                                        "1/2 ETH Collected",
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
                  ),
                ),
              ),
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(0),
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
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
                                  image:
                                      AssetImage("assets/foresight-cover.png"),
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
                                        "Foresight Agricultural Insights",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
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
                                      "Using agricultural drone technology to help determine subsistence crop quality and estimate yields in Limuru"),
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
                                        "1.21/2 ETH Collected",
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
                                        "1,021 Investors",
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
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection("investor_users")
                    .doc(currentUser!.uid)
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
                    .collection("investor_users")
                    .doc(currentUser!.uid)
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
                      .collection("investor_users")
                      .doc(currentUser!.uid)
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
                      );
                    } else {
                      throw Error;
                    }
                  },
                ),
              ),
            ),
            ListTile(
              leading: IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () => authUser.signOut().then((res) {
                  Fluttertoast.showToast(msg: "Signed out successfully");
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InvestorLogin()),
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
                      MaterialPageRoute(
                          builder: (context) => const InvestorLogin()),
                      (Route<dynamic> route) => false);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
