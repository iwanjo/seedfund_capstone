// ignore_for_file: prefer_const_constructors, unnecessary_this

import 'package:flutter/material.dart';

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
        title: Text("Invest in " + projectName),
        centerTitle: true,
        actions: [
          Icon(Icons.share),
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  this.widget.coverImg,
                  SizedBox(
                    width: 20,
                  ),
                  this.widget.projectTitle,
                ],
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
                height: 16,
              ),
              this.widget.projectDescription,
              Text(
                "Funding Goal Amount",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              this.widget.amount,
              Text(
                "Funding Project Deadline",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              this.widget.deadline,
              SizedBox(
                height: 16,
              ),
              MaterialButton(
                onPressed: () {},
                color: const Color(0xFF2AB271),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 20.0),
                child: const Text(
                  "Invest",
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
