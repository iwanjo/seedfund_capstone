// ignore_for_file: prefer_const_constructors

import 'package:Seedfund/investor_routing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SuccessfulInvestment extends StatefulWidget {
  final projectTitle;
  final amount;
  const SuccessfulInvestment({Key? key, this.projectTitle, this.amount})
      : super(key: key);

  @override
  State<SuccessfulInvestment> createState() => _SuccessfulInvestmentState();
}

class _SuccessfulInvestmentState extends State<SuccessfulInvestment> {
  User? user = FirebaseAuth.instance.currentUser;
  final currentUserName = FutureBuilder<DocumentSnapshot>(
    future: FirebaseFirestore.instance
        .collection("investor_users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get(),
    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
      if (snapshot.hasError) {
        return const Text("Oops, something went wrong");
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      }
      if (snapshot.connectionState == ConnectionState.done) {
        Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;
        return Text('${data['fullname']}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            textAlign: TextAlign.center);
      } else {
        throw Error;
      }
    },
  );

  @override
  Widget build(BuildContext context) {
    String projectName = this.widget.projectTitle;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Success",
          style: TextStyle(color: Colors.black, fontSize: 20.0),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              Center(
                child: Column(
                  children: [
                    Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Congratulations ",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              textAlign: TextAlign.center),
                          currentUserName,
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Great job breaking out of your comfort zone",
                      style: TextStyle(
                        color: Color(0xFF979797),
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 36,
                    ),
                    Image.asset(
                      "assets/congrats-investor.png",
                      fit: BoxFit.contain,
                      // width: double.infinity,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 36,
              ),
              Text(
                "Your investment of " +
                    "KSH " +
                    this.widget.amount +
                    " to " +
                    this.widget.projectTitle +
                    " has been confirmed.",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF979797),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 24,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InvestorPageRouting(
                                uid: user!.uid,
                              )));
                },
                color: const Color(0xFF2AB271),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 20.0),
                child: const Text(
                  "Return Home",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
