import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextnode) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextnode);
  }

  static void toastMessage(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void flushBarErrorMessage(String message, BuildContext context) {
    Flushbar(
      message: message,
      backgroundColor: Colors.red,
      messageColor: Colors.black,
      forwardAnimationCurve: Curves.decelerate,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      duration: const Duration(seconds: 3),
      reverseAnimationCurve: Curves.easeOutCirc,
      borderRadius: BorderRadius.circular(20.0),
      positionOffset: 20.0,
      icon: const Icon(
        Icons.error,
        size: 20,
      ),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  //snackbar for show message
  static showSnackbar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.amber,
        content: Text("provide message parameters")));
  }
}
