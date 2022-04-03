import 'package:flutter/material.dart';

class SMEDiscover extends StatefulWidget {
  final String? uid;

  const SMEDiscover({Key? key, this.uid}) : super(key: key);

  @override
  State<SMEDiscover> createState() => _SMEDiscoverState();
}

class _SMEDiscoverState extends State<SMEDiscover> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
