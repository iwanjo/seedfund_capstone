// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, unnecessary_this, unused_local_variable

import 'package:Seedfund/secrets.dart';
import 'package:Seedfund/views/investor-views/success_investment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave/flutterwave.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InvestInSMEProject extends StatefulWidget {
  final projectTitle;
  final amount;

  const InvestInSMEProject({
    Key? key,
    this.projectTitle,
    this.amount,
  }) : super(key: key);

  @override
  State<InvestInSMEProject> createState() => _InvestInSMEProjectState();
}

class _InvestInSMEProjectState extends State<InvestInSMEProject> {
  CollectionReference investments =
      FirebaseFirestore.instance.collection("investments");
  var investDocId;
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;
  final _formKey = GlobalKey<FormState>();
  final String currency = FlutterwaveCurrency.RWF;
  TextEditingController investmentAmountController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
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
        return Text(
          '${data['fullname']}',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF979797),
          ),
        );
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
          "Invest in " + projectName,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            physics: BouncingScrollPhysics(),
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[
              SizedBox(
                height: 4,
              ),
              Text(
                "Investment Amount",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Your transaction will be processed immediately",
                style: TextStyle(fontSize: 15.0, color: Color(0xFF979797)),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 0.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      filled: true,
                      labelText: "Enter phone number",
                      labelStyle: TextStyle(fontSize: 14.0),
                      fillColor: Color(0xFFF0F0F0),
                      enabledBorder: InputBorder.none,
                    ),
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    validator: (String? stringValue) {
                      if (stringValue != null && stringValue.isEmpty) {
                        return "Your phone number is a required field, please enter it here";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    filled: true,
                    labelText: "Enter amount",
                    labelStyle: TextStyle(fontSize: 14.0),
                    fillColor: Color(0xFFF0F0F0),
                    // border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                  controller: investmentAmountController,
                  keyboardType: TextInputType.number,
                  validator: (String? stringValue) {
                    if (stringValue != null && stringValue.isEmpty) {
                      return "Your investment amount is a required field, please enter it here";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  Text(
                    "Total",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "" + investmentAmountController.text,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "You are investing as ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF979797),
                    ),
                  ),
                  currentUserName,
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Payment Information",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 8,
              ),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Image.asset(
                      "assets/credit-card.png",
                      fit: BoxFit.fill,
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Your information is fully encrypted",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF2AB271),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Pay with Flutterwave Below"),
              SizedBox(
                height: 12,
              ),
              SizedBox(
                height: 12,
              ),
              MaterialButton(
                onPressed: () {
                  sendInvestmentToFirebaseFirestore();
                  final fullname = FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("investor_users")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
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
                        return Text(
                          '${snapshot.data!['fullname']}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF979797),
                          ),
                        );
                      } else {
                        throw Error;
                      }
                    },
                  );
                  final phone = phoneController.text;
                  final email = FirebaseAuth.instance.currentUser!.email;
                  final investmentAmount = investmentAmountController.text;
                  if (_formKey.currentState!.validate()) {
                    makePaymentFlutterwave(context, fullname.toString(), email!,
                        investmentAmount, phone);
                  }
                },
                color: const Color(0xFF2AB271),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 20.0),
                child: const Text(
                  "Pay",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final _auth = FirebaseAuth.instance;

  sendInvestmentToFirebaseFirestore() {
    User? user = _auth.currentUser;
    investments.doc(currentUserId).collection("user-investments").add({
      "phoneNumber": phoneController.text,
      "investmentAmount": investmentAmountController.text,
      "company": this.widget.projectTitle,
      "uid": currentUserId,
    });
    Fluttertoast.showToast(msg: "Moving to Flutterwave Gateway");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SuccessfulInvestment(
          projectTitle: widget.projectTitle,
          amount: investmentAmountController.text,
        ),
      ),
    );
  }

  makePaymentFlutterwave(BuildContext context, String fullname, String email,
      String investmentAmount, String phone) async {
    try {
      Flutterwave flutterwave = Flutterwave.forUIPayment(
        context: context,
        publicKey: publicKey,
        encryptionKey: encryptionKey,
        currency: currency,
        amount: investmentAmount,
        email: email,
        fullName: "Ian Wanjohi",
        txRef: DateTime.now().toIso8601String(),
        isDebugMode: true,
        phoneNumber: phone,
        acceptMpesaPayment: true,
        acceptRwandaMoneyPayment: true,
      );

      final response = await flutterwave.initializeForUiPayments();
      if (response == null) {
        return Fluttertoast.showToast(msg: "Null Error Response");
      } else if (response.status == "Transaction successful") {
        sendInvestmentToFirebaseFirestore();
        print(response.data);
        return Fluttertoast.showToast(msg: "Successful Transaction");
      } else {
        print(response.message);
      }
    } catch (err) {
      print(err);
    }
  }

  @override
  void dispose() {
    super.dispose();
    investmentAmountController.dispose();
  }
}
