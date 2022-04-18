// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace
import 'dart:convert';
import 'package:Seedfund/views/sme-views/sme_chat_details.dart';
import 'package:Seedfund/views/sme-views/sme_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:web3dart/web3dart.dart';

class SMEChat extends StatefulWidget {
  final String? uid;
  const SMEChat({Key? key, this.uid}) : super(key: key);

  @override
  State<SMEChat> createState() => _SMEChatState();
}

class _SMEChatState extends State<SMEChat> with TickerProviderStateMixin {
  int balance = 0, totalDeposits = 0, installmentAmount = 3;
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseAuth authUser = FirebaseAuth.instance;
  var currentUserUid = FirebaseAuth.instance.currentUser!.uid;

  Client? httpClient;
  Web3Client? ethClient;
  final String? _rpcUrl = "http://192.168.1.75:7545";

  @override
  void initState() {
    initialSetup();
    super.initState();
  }

  Future<void> initialSetup() async {
    httpClient = Client();
    ethClient = Web3Client(_rpcUrl!, httpClient!);
    await getCredentials();
    await getDeployedContract();
    await getContractFunctions();
  }

  String? _privateKey =
      "f317b9f2b1a9476471982753ec07442e56a957fad6b5efe07994ccf39aa7567c";
  Credentials? credentials;
  EthereumAddress? myAddress;

  Future<void> getCredentials() async {
    credentials = await EthPrivateKey.fromHex(_privateKey!);
    myAddress = await credentials!.extractAddress();
  }

  String? abi;
  EthereumAddress? contractAddress;

  Future<void> getDeployedContract() async {
    String abiString = await rootBundle.loadString("src/abis/Investment.json");
    var abiJson = jsonDecode(abiString);
    abi = jsonDecode(abiJson['abi']);

    contractAddress =
        EthereumAddress.fromHex(abiJson['networks']['5777']['address']);
  }

  DeployedContract? contract;

  ContractFunction? getBalanceAmount;
  ContractFunction? getDepositAmount;
  ContractFunction? addDepositAmount;
  ContractFunction? withdrawBalance;

  Future<void> getContractFunctions() async {
    contract = DeployedContract(
        ContractAbi.fromJson(abi!, "Investment"), contractAddress!);
    getBalanceAmount = contract!.function('getBalanceAmount');
    getDepositAmount = contract!.function('getDepositAmount');
    addDepositAmount = contract!.function('addDepositAmount');
    withdrawBalance = contract!.function('withdrawBalance');
  }

  Future<List<dynamic>> readContract(
    ContractFunction functionName,
    List<dynamic> functionArgs,
  ) async {
    var queryResult = await ethClient!.call(
        contract: contract!, function: functionName, params: functionArgs);

    return queryResult;
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabBarController = TabController(length: 2, vsync: this);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Image.asset(
          "assets/seedfund-logomark.png",
          fit: BoxFit.contain,
          height: 28,
          width: 28,
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.more_vert_rounded),
              tooltip: 'See more',
              onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Chats",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("investor_users")
                    .where('uid', isNotEqualTo: currentUserUid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text("There is an error");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasData) {
                    return ListView(
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        final str = '${data['fullname']}';
                        return ListTile(
                          onTap: () {
                            userChatScreen(
                                context, data['fullname'], data['uid']);
                          },
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundColor: const Color(0xFF2AB271),
                            child: Text(
                                str.split(" ").map((l) => l[0]).take(2).join(),
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                          title: Text(data['fullname']),
                          subtitle: Text(data['email']),
                        );
                      }).toList(),
                    );
                  } else {
                    return Text("error");
                  }
                },
              ),
            ),
          ],
        ),
      ),
      drawer: SMEDrawer(
        uid: user!.uid,
      ),
    );
  }

  void userChatScreen(BuildContext context, String name, String uid) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => SMEChatDetails(
              receiverName: name,
              otherUserUid: uid,
            )),
      ),
    );
  }
}
