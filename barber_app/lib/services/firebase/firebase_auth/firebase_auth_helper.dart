import 'package:barber_app_with_admin_panel/model/usermodel.dart';
import 'package:barber_app_with_admin_panel/utils/routes/routes_name.dart';
import 'package:barber_app_with_admin_panel/utils/utilis.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FirebaseAuthHelper {
  static FirebaseAuthHelper instace = FirebaseAuthHelper();
  final _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;











  Future signUp(
      String image,String name, String email, String password, BuildContext context) async {
    try {
      UserCredential? userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel userModel = UserModel(
          image: image, id: userCredential.user!.uid, name: name, email: email);
      await _firestore
          .collection("users")
          .doc(userModel.id)
          .set(userModel.tojson());
      ToastMsg.toastMessage("SignUp Successfully");
      Navigator.pushReplacementNamed(context, Routesname.home);
      return "success";
    } catch (e) {
      if (e is FirebaseAuthException) {
        String errorMessage = firebaseExceptionMessage(e);
        ToastMsg.toastMessage(errorMessage.toString());
      } else {
        print('Unexpected error: $e');
      }
    }
  }

  Future loginFunction(
      String email, String password, BuildContext context) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      Navigator.pushReplacementNamed(context, Routesname.home);
      ToastMsg.toastMessage("Login SuccessFully");
    }).onError((error, stackTrace) {
      if (error is FirebaseAuthException) {
        String errorMessage = firebaseExceptionMessage(error);
        ToastMsg.toastMessage(errorMessage.toString());
      } else {
        if (kDebugMode) {
          print('Unexpected error: $error');
        }
      }
    });
  }

  Future<void> logoutfun() async {
    await _auth.signOut();
  }

//exceptions code of firebase

  String firebaseExceptionMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-credential':
        return 'Email and Password not Found';
      case 'user-not-found':
        return 'User not found.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'weak-password':
        return 'Password is too weak.';
      case 'email-already-in-use':
        return 'Email is already in use.';
      case 'too-many-requests':
        return 'Too many unsuccessful login attempts. Please try again later.';
      default:
        return 'An error occurred (${e.code}). Please try again.';
    }
  }
}
