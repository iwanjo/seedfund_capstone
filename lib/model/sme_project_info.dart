// ignore_for_file: prefer_const_constructors, unnecessary_this, prefer_typing_uninitialized_variables

import 'package:Seedfund/views/invest_in_sme.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class SMEProjectInfo extends StatefulWidget {
  final coverImg;
  final projectTitle;
  final projectDescription;
  final amount;
  final deadline;
  const SMEProjectInfo(
      {Key? key,
      this.coverImg,
      this.projectTitle,
      this.projectDescription,
      this.amount,
      this.deadline})
      : super(key: key);

  @override
  State<SMEProjectInfo> createState() => _SMEProjectInfoState();
}

class _SMEProjectInfoState extends State<SMEProjectInfo> {
  @override
  Widget build(BuildContext context) {
    String projectName = this.widget.projectTitle;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Invest in " + projectName,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          IconButton(
              onPressed: () {
                Share.share(
                    "Here is an up and coming SME soon to become Kenya's next unicorm. It is " +
                        this.widget.projectTitle +
                        ". They are seeking a funding amount of KSH " +
                        this.widget.amount +
                        ". The great thing about Seedfund is that it promotes equity crowdfunding, meaning, the money we put in will grant us equity in the company. ");
              },
              icon: Icon(Icons.share)),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Image.network(
                this.widget.coverImg,
                fit: BoxFit.fitWidth,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                this.widget.projectTitle,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Funding Project Description",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                this.widget.projectDescription,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Funding Goal Amount",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "KSH " + this.widget.amount,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Funding Project Deadline",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                this.widget.deadline + " Days",
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InvestInSMEProject(
                        projectTitle: projectName,
                        amount: this.widget.amount,
                      ),
                    ),
                  );
                },
                color: const Color(0xFF2AB271),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 20.0),
                child: const Text(
                  "Invest in Project",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
