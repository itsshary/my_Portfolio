import 'package:flutter/material.dart';

class Countexample with ChangeNotifier {
  int _count = 1;
  int get count => _count;
  void functionad() {
    _count++;
    notifyListeners();
  }
}
