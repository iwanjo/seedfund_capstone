import 'package:Seedfund/investor_routing.dart';
import 'package:Seedfund/views/onboarding-views/onboarding_one.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:splashscreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SeedfundSplashScreen(),
      title: "Seedfund",
      theme: ThemeData(
        fontFamily: 'GT-Walsheim-Regular',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class SeedfundSplashScreen extends StatelessWidget {
  const SeedfundSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? result = FirebaseAuth.instance.currentUser;
    return SplashScreen(
      title: const Text(
        "Welcome to Seedfund",
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      image: Image.asset(
        "assets/seedfund-logomark.png",
        fit: BoxFit.contain,
      ),
      loaderColor: const Color(0xFF2AB271),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: const TextStyle(),
      loadingText: const Text("Loading..."),
      loadingTextPadding: const EdgeInsets.all(0),
      useLoader: true,
      navigateAfterSeconds:
          result != null ? const InvestorPageRouting() : const OnboardingOne(),
      seconds: 4,
    );
  }
}
