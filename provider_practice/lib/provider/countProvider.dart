import 'package:flutter/material.dart';

class Providercount with ChangeNotifier {
  double _value = 1.0;
  double get value => _value;
  void doublefun(double val) {
    _value = val;
    notifyListeners();
  }
}
