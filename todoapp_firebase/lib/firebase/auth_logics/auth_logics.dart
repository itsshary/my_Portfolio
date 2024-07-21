import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp_firebase/utils/routes/routes_name.dart';
import 'package:todoapp_firebase/utils/utilis.dart';

class AuthLogics {
  final auth = FirebaseAuth.instance;
  static AuthLogics instance = AuthLogics();

  Future<void> loginFun(
      String email, String password, BuildContext context) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((val) {
        Navigator.pushReplacementNamed(context, Routesname.displayTodo);
        ToastMsg.toastMessage('Login Successfully');
      });
    } catch (e) {
      ToastMsg.toastMessage('Login Successfully');
    }
  }

  //signupfunction

  Future<void> signup(
      String email, String password, BuildContext context) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Navigator.pushReplacementNamed(context, Routesname.displayTodo);
        ToastMsg.toastMessage('Login Successfully');
      });
    } catch (e) {
      ToastMsg.toastMessage(e.toString());
    }
  }

  //logout function

  void logout(BuildContext context) {
    auth.signOut().then((val) {
      Navigator.pushReplacementNamed(
        context,
        Routesname.login,
      );
    });
  }
}
