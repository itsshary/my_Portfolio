import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerance_app_firebase/models/fluttertoast/toastmessage.dart';
import 'package:e_commerance_app_firebase/models/usermodel.dart';
import 'package:e_commerance_app_firebase/provider/app_Provider.dart';
import 'package:e_commerance_app_firebase/screen/Custom_Bottom_bar/custom_bottom_bar.dart';
import 'package:e_commerance_app_firebase/screen/favourite_Screen/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
 
import 'package:provider/provider.dart';

class FirebaseAuthHelper {
  static FirebaseAuthHelper instance = FirebaseAuthHelper();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Stream<User?> get getautchange => _auth.authStateChanges();

  Future login(String email, String password, context) async {
    Provider.of<AppProvider>(context, listen: false).setLoading(true);
    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      Provider.of<AppProvider>(context, listen: false).setLoading(false);
      Utilies().toast('Login Successfully');
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const CustomBottomBar()));
    }).onError((error, stackTrace) {
      Provider.of<AppProvider>(context, listen: false).setLoading(true);
      Utilies().toast(error.toString());
    });

    // try {
    //   showLoderDialog(context);
    //   await _auth.signInWithEmailAndPassword(email: email, password: password);
    //   Navigator.of(context).pop();
    //   return true;
    // } on FirebaseException catch (e) {
    //   Navigator.of(context).pop();
    //   Utilies().fluttertoast(e.toString());
    //   return false;
    // }
  }

  //signupfunctio

  Future<bool> SignUp(
      String name, String email, String password, BuildContext context) async {
    try {
      showLoderDialog(context);
      UserCredential? userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      NewUserModel newUserModel = NewUserModel(
          image: null, id: userCredential.user!.uid, name: name, email: email);

      _firebaseFirestore
          .collection("users")
          .doc(newUserModel.id)
          .set(newUserModel.tojson());
      return true;
    } on FirebaseException catch (e) {
      Utilies().fluttertoast(e.toString());
      return false;
    }
  }

  Future<String> SignUptest(
      String name, String email, String password, BuildContext context) async {
    try {
      UserCredential? userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      NewUserModel newUserModel = NewUserModel(
          image: null, id: userCredential.user!.uid, name: name, email: email);

      _firebaseFirestore
          .collection("users")
          .doc(newUserModel.id)
          .set(newUserModel.tojson());
      return "success";
    } on FirebaseException catch (e) {
      Utilies().fluttertoast(e.toString());
      return "faild";
    }
  }

  Future<String> changePassword(String password, BuildContext context) async {
    try {
      showLoderDialog(context);
      _auth.currentUser!.updatePassword(password);
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context).pop();

      return "success";
    } on FirebaseException catch (e) {
      
      return "faild";
    }
  }
}
