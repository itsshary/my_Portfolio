import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_app/resources/appcolors/appcolors.dart';

class Utilies {
  void toast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 10,
        backgroundColor: AppColors.primary,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
