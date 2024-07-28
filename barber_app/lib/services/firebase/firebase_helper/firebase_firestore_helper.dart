import 'package:barber_app_with_admin_panel/model/bookmodel.dart';
import 'package:barber_app_with_admin_panel/model/usermodel.dart';
import 'package:barber_app_with_admin_panel/utils/utilis.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseFirestoreHelper {
  static FirebaseFirestoreHelper instace = FirebaseFirestoreHelper();
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ignore: body_might_complete_normally_nullable
  Future<UserModel?> getUserInformation() async {
    DocumentSnapshot<Map<String, dynamic>> value =
        await _firestore.collection("users").doc(_auth.currentUser!.uid).get();
    if (value.exists) {
      return UserModel.fromjson(value.data()!);
    }
  }

  // Future<List<BookModel>> getUserOrder() async {
  //   try {
  //     QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
  //         .collection('usersorders')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .collection('orders')
  //         .get();
  //     List<BookModel> orderList =
  //         querySnapshot.docs.map((e) => BookModel.fromjson(e.data())).toList();

  //     return orderList;
  //   } catch (e) {
  //     print(e.toString());
  //     return [];
  //   }
  // }

  Stream<List<BookModel>> getUserOrderStream() {
    try {
      Stream<QuerySnapshot<Map<String, dynamic>>> queryStream = _firestore
          .collection('usersorders')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('orders')
          .snapshots();

      Stream<List<BookModel>> orderStream = queryStream.map((querySnapshot) =>
          querySnapshot.docs.map((e) => BookModel.fromjson(e.data())).toList());

      return orderStream;
    } catch (e) {
      print(e.toString());
      // Return an empty stream on error
      return Stream.value([]);
    }
  }

  Future<void> saveBooking(DateTime date, TimeOfDay time, String service,
      BuildContext context) async {
    try {
      // Add booking to usersorders collection
      await _firestore
          .collection("usersorders")
          .doc(_auth.currentUser!.uid)
          .collection("orders")
          .add({
        "userId": _auth.currentUser!.uid,
        "date": date.toString(),
        "time": time.format(context),
        "service": service.toString(),
      });

      // Add booking to orders collection (for admins)
      await _firestore.collection("orders").add({
        "userId": _auth.currentUser!.uid,
        "date": date.toString(),
        "time": time.format(context),
        "service": service,
      });

      // You can return a success message or anything you need
      ToastMsg.toastMessage("Appotiment Set Successfully");
    } catch (e) {
      throw e; // Rethrow the error to handle it in the UI if necessary
    }
  }
}
