import 'package:barber_app_with_admin_panel/model/bookmodel.dart';
import 'package:barber_app_with_admin_panel/model/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/firebase/firebase_helper/firebase_firestore_helper.dart';

class FirestoreViewModel extends ChangeNotifier {
  FirebaseFirestoreHelper firestoreservices = FirebaseFirestoreHelper();
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<BookModel> _bookmodeldata = [];

  UserModel? _userModel;
  UserModel? get getuserinformationvalue => _userModel!;
  List<BookModel> get bookmodeldata => _bookmodeldata;

  Future<UserModel?> getuserInformation() async {
    _userModel = await firestoreservices.getUserInformation();
    return _userModel;
  }

  // Future getUserOrderViewModel() async {
  //   _bookmodeldata = await firestoreservices.getUserOrder();
  //   notifyListeners();
  // }
}
