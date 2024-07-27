import 'dart:async';

import 'package:blog_app_firebase/utils/routes/routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void islogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      Timer(
        const Duration(seconds: 5),
        () => Navigator.pushReplacementNamed(context, Routesname.homescreen),
      );
    } else {
      Timer(
        const Duration(seconds: 5),
        () => Navigator.pushReplacementNamed(context, Routesname.login),
      );
    }
  }
}
