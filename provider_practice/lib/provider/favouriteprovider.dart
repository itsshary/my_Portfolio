import 'package:flutter/material.dart';

class FavouriteProvider with ChangeNotifier {
  List<int> _array = [];

  List<int> get array => _array;
  void additem(int value) {
    _array.add(value);
    notifyListeners();
  }

  void removeitem(int value) {
    _array.remove(value);
    notifyListeners();
  }
}
