import 'package:flutter/material.dart';
import 'package:quiz_app/screens/show_option_screen.dart';

class AppController {
  static AppController instance = AppController();

//navigate to another screen
  void navigateToQuiz(String topic, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizScreen(topic: topic),
      ),
    );
  }
}
