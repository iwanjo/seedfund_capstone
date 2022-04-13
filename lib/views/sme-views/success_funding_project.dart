// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:Seedfund/sme_routing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SuccessFundingProject extends StatefulWidget {
  const SuccessFundingProject({Key? key}) : super(key: key);

  @override
  State<SuccessFundingProject> createState() => _SuccessFundingProjectState();
}

class _SuccessFundingProjectState extends State<SuccessFundingProject> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Success",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
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
                    Text(
                      "Congratulations",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Your funding request has been created successfully. It will take 1-3 minutes to go live.",
                      style: TextStyle(
                        color: Color(0xFF979797),
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      "assets/sme-congrats.png",
                      fit: BoxFit.contain,
                      // width: double.infinity,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 36,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SMEPageRouting(
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
