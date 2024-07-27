import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news_app/screen/home_screen/home_screen.dart';

class SplashServices {
  void splashscreen(context) {
    Timer(
      const Duration(seconds: 5),
      () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ));
      },
    );
  }
}
