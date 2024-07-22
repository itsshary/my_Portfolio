import 'dart:async';

import 'package:e_commerance_app_firebase/screen/Custom_Bottom_bar/custom_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

 

import '../login_screen.dart';

class SplashServices {
  void islogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      Timer(
        const Duration(seconds: 5),
        () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const CustomBottomBar(),
          ),
        ),
      );
    } else {
      Timer(
        const Duration(seconds: 5),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen())),
      );
    }
  }
}
