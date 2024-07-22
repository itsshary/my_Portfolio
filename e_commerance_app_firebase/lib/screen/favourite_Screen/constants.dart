import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utilies {
  void fluttertoast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

showLoderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Builder(builder: (context) {
      return SizedBox(
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              color: Colors.red,
            ),
            const SizedBox(
              height: 18.0,
            ),
            Container(
              margin: const EdgeInsets.only(left: 7.0),
              child: const Text('Loading.....'),
            )
          ],
        ),
      );
    }),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

bool loginValidation(String email, String password) {
  if (email.isEmpty && password.isEmpty) {
    Utilies().fluttertoast("Both field are empty");
    return false;
  } else if (email.isEmpty) {
    Utilies().fluttertoast("Email is empty");
    return false;
  } else if (email.isEmpty) {
    Utilies().fluttertoast("Password is empty");
    return false;
  } else
    // ignore: curly_braces_in_flow_control_structures
    return false;
}

bool signingValidation(String name, String email, String password) {
  if (email.isEmpty && password.isEmpty && name.isEmpty) {
    Utilies().fluttertoast("All fields are empty");
    return false;
  } else if (name.isEmpty) {
    Utilies().fluttertoast("Name is empty");
    return false;
  } else if (email.isEmpty) {
    Utilies().fluttertoast("Email is empty");
    return false;
  } else if (email.isEmpty) {
    Utilies().fluttertoast("Password is empty");
    return false;
  } else
    // ignore: curly_braces_in_flow_control_structures
    return false;
}
