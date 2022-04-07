// ignore_for_file: prefer_const_constructors, duplicate_import, unused_import, unused_local_variable, avoid_print, await_only_futures

import 'dart:io';
import 'dart:io' as io;

import 'package:Seedfund/views/sme-views/success_funding_project.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class CreateFundingProject extends StatefulWidget {
  final String? uid;
  const CreateFundingProject({Key? key, this.uid}) : super(key: key);

  @override
  State<CreateFundingProject> createState() => _CreateFundingProjectState();
}

class _CreateFundingProjectState extends State<CreateFundingProject> {
  TextEditingController fundingProjectNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();

  File? image;
  FirebaseStorage storage = FirebaseStorage.instance;

  Future pickUserCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) {
        return;
      }
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      return Text("Failed to pick image: $e");
    }
  }

  Future pickGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      return Text("Failed to pick image: $e");
    }
  }

  Future uploadLogoImageToFirebase(BuildContext context) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('logos')
        .child('/$fileName');

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': fileName});

    firebase_storage.UploadTask uploadTask;
    uploadTask = ref.putFile(io.File(image!.path), metadata);

    uploadTask.then((TaskSnapshot taskSnapshot) {
      taskSnapshot.ref
          .getDownloadURL()
          .then((imageUrl) => {captureData(imageUrl)});
    });

    firebase_storage.UploadTask task = await Future.value(uploadTask);
    Future.value(uploadTask)
        .then((value) => {print("Upload file path ${value.ref.fullPath}")})
        .onError((error, stackTrace) =>
            {print("Upload file path error ${error.toString()} ")});
  }

  captureData(String imageUrl) {
    FirebaseFirestore.instance.collection("fundingProjects").add({
      'projectName': fundingProjectNameController.text,
      'projectDescription': descriptionController.text,
      'amount': amountController.text,
      'deadline': deadlineController.text,
      'logoUrl': imageUrl,
    });
  }

  var currentUserLoginUser = FirebaseAuth.instance.currentUser;
  Future getUser() async {
    var currentUserLoginUser = await FirebaseAuth.instance.currentUser;
    var firebaseUser = await FirebaseFirestore.instance
        .collection("sme_users")
        .doc(currentUserLoginUser!.uid);
  }

  showOptions() {
    return showModalBottomSheet(
        context: context,
        builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.image),
                  title: Text("Gallery"),
                  onTap: pickGallery,
                ),
                ListTile(
                  leading: Icon(Icons.camera),
                  title: Text("Camera"),
                  onTap: pickUserCamera,
                ),
              ],
            ));
  }

  runAll() {
    uploadLogoImageToFirebase(context);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SuccessFundingProject()));
  }

  FirebaseAuth authUser = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Create Funding Project",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              image != null
                  ? Image.file(
                      image!,
                      width: 200,
                      height: 100,
                    )
                  : Container(
                      width: 80,
                      height: 80,
                      color: Color(0xFFF0F0F0),
                      child: Center(
                        child: TextButton(
                          child: Text("Upload Cover Image for Project"),
                          onPressed: showOptions,
                        ),
                      ),
                    ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    filled: true,
                    labelText: "Enter your business funding project name",
                    labelStyle: TextStyle(fontSize: 12.0),
                    fillColor: Color(0xFFF0F0F0),
                    // border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                  controller: fundingProjectNameController,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.name,
                  validator: (String? stringValue) {
                    if (stringValue != null && stringValue.isEmpty) {
                      Fluttertoast.showToast(msg: "Enter project name");
                      return "Your project name is a required field, please enter it here";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    filled: true,
                    labelText: "Enter your project or business description",
                    labelStyle: TextStyle(fontSize: 12.0),
                    fillColor: Color(0xFFF0F0F0),
                    // border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                  controller: descriptionController,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.name,
                  validator: (String? stringValue) {
                    if (stringValue != null && stringValue.isEmpty) {
                      Fluttertoast.showToast(msg: "Enter project description");
                      return "Your project description is a required field, please enter it here";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    filled: true,
                    labelText: "How much do you want to raise?",
                    labelStyle: TextStyle(fontSize: 12.0),
                    fillColor: Color(0xFFF0F0F0),
                    // border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  validator: (String? stringValue) {
                    if (stringValue != null && stringValue.isEmpty) {
                      Fluttertoast.showToast(msg: "Enter funding amount");
                      return "Your funding amount is a required field, please enter it here";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    filled: true,
                    labelText:
                        "How many days is your funding project going to last?",
                    labelStyle: TextStyle(fontSize: 12.0),
                    fillColor: Color(0xFFF0F0F0),
                    // border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                  controller: deadlineController,
                  keyboardType: TextInputType.number,
                  validator: (String? stringValue) {
                    if (stringValue != null && stringValue.isEmpty) {
                      Fluttertoast.showToast(msg: "Enter project deadline");
                      return "Your project deadline is a required field, please enter it here";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () {
                  runAll();
                },
                color: const Color(0xFF2AB271),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 20.0),
                child: const Text(
                  "Create Funding Project",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    fundingProjectNameController.dispose();
    descriptionController.dispose();
    amountController.dispose();
    deadlineController.dispose();
  }
}
