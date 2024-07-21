import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp_firebase/utils/routes/routes_name.dart';

class SplashServices {
  void islogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      Timer(
        const Duration(seconds: 5),
        () => Navigator.pushReplacementNamed(context, Routesname.displayTodo),
      );
    } else {
      Timer(
        const Duration(seconds: 5),
        () => Navigator.pushReplacementNamed(context, Routesname.login),
      );
    }
  }
}
