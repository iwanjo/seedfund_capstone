import 'package:flutter/material.dart';

class SMEProfile extends StatefulWidget {
  final String? uid;

  const SMEProfile({Key? key, this.uid}) : super(key: key);

  @override
  State<SMEProfile> createState() => _SMEProfileState();
}

class _SMEProfileState extends State<SMEProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
