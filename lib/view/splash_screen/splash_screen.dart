import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_project/view/login%20and%20registration/login.dart';

import '../../controller/firebase_helper/firebase_helper.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkUserLoginStatus();
  }

  Future<void> checkUserLoginStatus() async {
    // Simulate a delay, e.g., checking user authentication status
    await Future.delayed(Duration(seconds: 2));

    // Check if the user is already logged in
    if (FirebaseHelper().user != null) {
      // User is logged in, navigate to the home screen
      Get.offAll(() => HomeScreen());
    } else {
      // User is not logged in, navigate to the login screen
      Get.offAll(() => LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/logo/app_icon.png",
              height: 200,
              width: 200,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              "E n t e Y a t r a",
              style: GoogleFonts.waitingForTheSunrise(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.green),
            ),
          )
        ],
      ),
    );
  }
}
