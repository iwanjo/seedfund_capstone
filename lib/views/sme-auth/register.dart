import 'package:Seedfund/model/sme_user.dart';
import 'package:Seedfund/model/user_model.dart';
import 'package:Seedfund/sme_routing.dart';
import 'package:Seedfund/views/sme-auth/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Seedfund/investor_routing.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SMERegister extends StatefulWidget {
  const SMERegister({Key? key}) : super(key: key);

  @override
  State<SMERegister> createState() => _SMERegisterState();
}

class _SMERegisterState extends State<SMERegister> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  bool _hiddenPass = true;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      "assets/seedfund-logo-large.png",
                      fit: BoxFit.contain,
                      width: 120,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Create an SME Account on Seedfund",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    "Let's begin by adding your personal and business information",
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Color(0xFF5a5a5a),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 0.0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                filled: true,
                                labelText: "Enter your full name",
                                fillColor: Color(0xFFF0F0F0),
                                // border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                              ),
                              controller: fullNameController,
                              textCapitalization: TextCapitalization.words,
                              keyboardType: TextInputType.name,
                              validator: (String? stringValue) {
                                if (stringValue != null &&
                                    stringValue.isEmpty) {
                                  return "Your full name is a required field, please enter it here";
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 0.0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                filled: true,
                                labelText: "Enter your business name",
                                fillColor: Color(0xFFF0F0F0),
                                // border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                              ),
                              controller: companyNameController,
                              textCapitalization: TextCapitalization.words,
                              keyboardType: TextInputType.name,
                              validator: (String? stringValue) {
                                if (stringValue != null &&
                                    stringValue.isEmpty) {
                                  return "Your full name is a required field, please enter it here";
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 0.0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                filled: true,
                                labelText: "Enter your email address",
                                fillColor: Color(0xFFF0F0F0),
                                // border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                              ),
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (String? stringValue) {
                                if (stringValue != null &&
                                    stringValue.isEmpty) {
                                  return "Your email address is a required field, please enter it here";
                                } else if (stringValue != null &&
                                    !stringValue.contains('@')) {
                                  return "Please enter a valid email address with an @ symbol";
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 0.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                suffix: InkWell(
                                  onTap: _passwordVisible,
                                  child: const Icon(Icons.visibility),
                                ),
                                filled: true,
                                labelText: "Password (Minimum 8 Characters)",
                                fillColor: const Color(0xFFF0F0F0),
                                // border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                              ),
                              controller: passwordController,
                              obscureText: _hiddenPass,
                              validator: (String? stringValue) {
                                if (stringValue != null &&
                                    stringValue.length < 8) {
                                  return "Please enter a password at least 8 character long password";
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 0,
                            ),
                            child: isLoading
                                ? const CircularProgressIndicator()
                                : SizedBox(
                                    width: double.infinity,
                                    child: MaterialButton(
                                      color: Color(0xFF2AB271),
                                      textColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12.0, horizontal: 20.0),
                                      child: const Text(
                                        "Get Started",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0),
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          registerSMEUserToFirebase(
                                              emailController.text,
                                              passwordController.text);
                                        }
                                      },
                                    ),
                                  ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SMELogin()));
                            },
                            textColor: Color(0xFF2AB271),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 20.0),
                            child: const Text(
                              "Already have an account? Login here",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void registerSMEUserToFirebase(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((result) => {
                isLoading = false,
                postSMEDetailsToFirestore(),
              })
          .catchError((err) {
        Fluttertoast.showToast(msg: err!.message);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Sorry, there's an error"),
                content: Text(err.message),
                actions: [
                  TextButton(
                    child: const Text("Okay"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      });
    }
  }

  postSMEDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    SMEUserModel userModel = SMEUserModel();
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.fullname = fullNameController.text;
    userModel.companyname = companyNameController.text;

    await firebaseFirestore
        .collection("sme_users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(
        msg:
            "Welcome to Seedfund, your SME Account has been created successfully");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SMEPageRouting(
          uid: user.uid,
        ),
      ),
    );
  }

  void _passwordVisible() {
    setState(() {
      _hiddenPass = !_hiddenPass;
    });
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    fullNameController.dispose();
    companyNameController.dispose();
    passwordController.dispose();
  }
}
