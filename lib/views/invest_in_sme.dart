// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, unnecessary_this

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';

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
  TextEditingController investmentAmountController = TextEditingController();
  final currentUserName = FutureBuilder<DocumentSnapshot>(
    future: FirebaseFirestore.instance
        .collection("investor_users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get(),
    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
      if (snapshot.hasError) {
        return const Text("sth went wrong");
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

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    filled: true,
                    labelText: "Enter amount in KSH",
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
                    "Total (KSH)",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "KSH " + investmentAmountController.text,
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
                          "Your card information is fully encrypted",
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
              Text("Pay with Card Below"),
              SizedBox(
                height: 12,
              ),
              CreditCardForm(
                cardNumber: cardNumber,
                obscureCvv: true,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                onCreditCardModelChange: onCreditCardModelChange,
                themeColor: Colors.blue,
                formKey: _formKey,
                cardNumberDecoration: InputDecoration(
                  fillColor: Color(0xFFF0F0F0),
                  filled: true,
                  labelText: 'Number',
                  hintText: 'XXXX XXXX XXXX XXXX',
                  hintStyle: const TextStyle(
                      color: Color(0xFF979797),
                      fontFamily: 'GT-Walsheim-Regular'),
                  labelStyle: const TextStyle(
                      color: Color(0xFF979797),
                      fontFamily: 'GT-Walsheim-Regular'),
                  enabledBorder: InputBorder.none,
                ),
                expiryDateDecoration: InputDecoration(
                  fillColor: Color(0xFFF0F0F0),
                  filled: true,
                  hintStyle: const TextStyle(
                      color: Color(0xFF979797),
                      fontFamily: 'GT-Walsheim-Regular'),
                  labelStyle: const TextStyle(
                      color: Color(0xFF979797),
                      fontFamily: 'GT-Walsheim-Regular'),
                  focusedBorder: border,
                  enabledBorder: border,
                  labelText: 'Expired Date',
                  hintText: 'XX/XX',
                ),
                cvvCodeDecoration: InputDecoration(
                  fillColor: Color(0xFFF0F0F0),
                  filled: true,
                  hintStyle: const TextStyle(
                      color: Color(0xFF979797),
                      fontFamily: 'GT-Walsheim-Regular'),
                  labelStyle: const TextStyle(
                      color: Color(0xFF979797),
                      fontFamily: 'GT-Walsheim-Regular'),
                  focusedBorder: border,
                  enabledBorder: border,
                  labelText: 'CVV',
                  hintText: 'XXX',
                ),
                cardHolderDecoration: InputDecoration(
                  fillColor: Color(0xFFF0F0F0),
                  filled: true,
                  hintStyle: const TextStyle(
                      color: Color(0xFF979797),
                      fontFamily: 'GT-Walsheim-Regular'),
                  labelStyle: const TextStyle(
                      color: Color(0xFF979797),
                      fontFamily: 'GT-Walsheim-Regular'),
                  focusedBorder: border,
                  enabledBorder: border,
                  labelText: 'Card Holder',
                ),
              ),
              SizedBox(
                height: 12,
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
                  "Confirm Investment",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  @override
  void dispose() {
    super.dispose();
    investmentAmountController.dispose();
  }
}
