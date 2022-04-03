import 'package:Seedfund/sme_routing.dart';
import 'package:Seedfund/views/sme-auth/register.dart';
import 'package:Seedfund/views/sme-views/sme_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Seedfund/investor_routing.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SMELogin extends StatefulWidget {
  const SMELogin({Key? key}) : super(key: key);

  @override
  State<SMELogin> createState() => _SMELoginState();
}

class _SMELoginState extends State<SMELogin> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool _hiddenPass = true;

  // Firebase Authentication
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 40,
            ),
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
                    "Welcome back to your SME account on Seedfund",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    "Enter your email address and password below",
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Color(0xFF5a5a5a),
                    ),
                  ),
                  Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            const SizedBox(
                              height: 20,
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
                                  labelText: "Enter your password",
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
                                        color: const Color(0xFF2AB271),
                                        textColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 20.0),
                                        child: const Text(
                                          "Login",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0),
                                        ),
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            loginUser(emailController.text,
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
                                        builder: (context) =>
                                            const SMERegister()));
                              },
                              textColor: const Color(0xFF2AB271),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 20.0),
                              child: const Text(
                                "Don't have an account? Register here",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                              ),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loginUser(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((result) => {
                isLoading = false,
                Fluttertoast.showToast(msg: "Login Successful!"),
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => SMEPageRouting(uid: result.user!.uid),
                  ),
                ),
              });
    }
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
    passwordController.dispose();
  }
}
