import 'dart:async';

import 'package:barber_app_with_admin_panel/utils/routes/routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void islogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      Timer(
        const Duration(seconds: 2),
        () => Navigator.pushReplacementNamed(context, Routesname.home),
      );
    } else {
      Timer(
        const Duration(seconds: 2),
        () => Navigator.pushReplacementNamed(context, Routesname.login),
      );
    }
  }
}
