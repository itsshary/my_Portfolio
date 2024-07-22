import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerance_app_firebase/models/Bestproductmodel.dart';
import 'package:e_commerance_app_firebase/models/catagorymodel.dart';
import 'package:e_commerance_app_firebase/models/fluttertoast/toastmessage.dart';
import 'package:e_commerance_app_firebase/models/ordermodel/ordermodel.dart';
import 'package:e_commerance_app_firebase/models/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
 

class FirebaseFirestoreHelper {
  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<UserModel>> getCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("Catagories").get();
      List<UserModel> categoriesimage =
          querySnapshot.docs.map((e) => UserModel.fromjson(e.data())).toList();
      return categoriesimage;
    } catch (e) {
      Utilies().toast(e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getBestProduct() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collectionGroup("product").get();

      List<ProductModel> bestProductsList = querySnapshot.docs
          .map((e) => ProductModel.fromjson(e.data()))
          .toList();
      return bestProductsList;
    } catch (e) {
      Utilies().toast(e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getCataogryProduct(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection("Catagories")
              .doc(id)
              .collection('product')
              .get();
      List<ProductModel> bestProductsList = querySnapshot.docs
          .map((e) => ProductModel.fromjson(e.data()))
          .toList();
      return bestProductsList;
    } catch (e) {
      Utilies().toast(e.toString());
      return [];
    }
  }

  //  new function
  Future<NewUserModel?> getUserInformation() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      final DocumentSnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection("users")
              .doc(currentUser.uid)
              .get();

      // Check if querySnapshot.data() is not null before using it
      if (querySnapshot.exists && querySnapshot.data() != null) {
        return NewUserModel.fromjson(querySnapshot.data()!);
      } else {
        // Handle the case when data is missing or null
        // For example, you could return a default user object or display an error message.
        return null;
      }
    } else {
      // Handle the case when the current user is null (not logged in)
      // For example, you could return null or display a message to the user.
      return null;
    }
  }

  // Future<NewUserModel?> getUserInformation() async {
  //   DocumentSnapshot<Map<String, dynamic>> querySnapshot =
  //       await _firebaseFirestore
  //           .collection("users")
  //           .doc(FirebaseAuth.instance.currentUser!.uid.toString())
  //           .get();

  //   // Check if querySnapshot.data() is null before using it
  //   if (querySnapshot.data() != null) {
  //     return await NewUserModel.fromjson(querySnapshot.data()!);
  //   } else {
  //     return null; // Return null or handle the case when data is null
  //   }
  // }

  // Future<NewUserModel> getUserInformation() async {
  //   DocumentSnapshot<Map<String, dynamic>> querySnapshot =
  //       await _firebaseFirestore
  //           .collection("users")
  //           .doc(FirebaseAuth.instance.currentUser!.uid.toString())
  //           .get();

  //   return NewUserModel.fromjson(querySnapshot.data()!);
  // }

  Future<bool> uploadorderProductFirebase(
      List<ProductModel> list, String payment) async {
    try {
      double totalprice = 0.0;
      for (var element in list) {
        double convertqty = double.parse(element.quantity.toString());
        double convertprice = double.parse(element.price.toString());
        totalprice += convertqty * convertprice;
      }
      DocumentReference documentReference = _firebaseFirestore
          .collection("usersorders")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("orders")
          .doc();
      DocumentReference admin =
          _firebaseFirestore.collection("orders").doc(documentReference.id);
      String uid = FirebaseAuth.instance.currentUser!.uid;
      admin.set({
        "products": list.map((e) => e.tojson()),
        "status": "pending",
        "totalPrice": totalprice,
        "payment": payment,
        "userid": uid,
        "orderid": admin.id,
      });

      documentReference.set({
        "products": list.map((e) => e.tojson()),
        "status": "pending",
        "totalPrice": totalprice,
        "payment": payment,
        "userid": uid,
        "orderid": documentReference.id,
      });
      Utilies().toast(" Order  SuccessFully");
      return true;
    } catch (e) {
      Utilies().toast(e.toString());
      return false;
    }
  }

  //Get order  user flutter///

  // Future<List<OrderModel>> getuserorders() async {
  //   try {
  //     QuerySnapshot<Map<String, dynamic>> quarysnapshot =
  //         await _firebaseFirestore
  //             .collection("usersorders")
  //             .doc(FirebaseAuth.instance.currentUser!.uid)
  //             .collection("orders")
  //             .get();

  //     List<OrderModel> orderlist = quarysnapshot.docs
  //         .map((element) => OrderModel.fromjson(element.data()))
  //         .toList();
  //     return orderlist;
  //   } catch (e) {
  //     return [];
  //   }
  // }
  // Future<List<OrderModel>> getuserorders() async {
  //   try {
  //     QuerySnapshot<Map<String, dynamic>> quarysnapshot =
  //         await _firebaseFirestore
  //             .collection("usersorders")
  //             .doc(FirebaseAuth.instance.currentUser!.uid)
  //             .collection("orders")
  //             .get();

  //     if (quarysnapshot.size == 0) {
  //       print("No orders found for the user");
  //       return [];
  //     }

  //     List<OrderModel> orderlist = quarysnapshot.docs
  //         .map((element) => OrderModel.fromjson(element.data()))
  //         .toList();

  //     return orderlist;
  //   } catch (e) {
  //     print("Error fetching orders: $e");
  //     return [];
  //   }
  // }

  // Stream<List<OrderModel>> getuserordersStream(String userId) {
  //   return _firebaseFirestore
  //       .collection("usersorders")
  //       .doc(userId)
  //       .collection("orders")
  //       .snapshots()
  //       .map((querySnapshot) => querySnapshot.docs
  //           .map((doc) => OrderModel.fromjson(doc.data()))
  //           .toList());
  // }

  // Future<List<OrderModel>> getuserorders() async {
  //   try {
  //     QuerySnapshot<Map<String, dynamic>> quarysnapshot =
  //         await _firebaseFirestore.collection("orders").get();

  //     if (quarysnapshot.size == 0) {
  //       print("No orders found for the user");
  //       return [];
  //     }

  //     List<OrderModel> orderlist = quarysnapshot.docs
  //         .map((element) => OrderModel.fromjson(element.data()))
  //         .toList();

  //     return orderlist;
  //   } catch (e) {
  //     print("Error fetching orders: $e");
  //     return [];
  //   }
  // }

  void updatetokenfromfirebase() async {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      await _firebaseFirestore
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "notificationtokken": token,
      });
    }
  }

//getcacelorder
  Future<void> updateOrder(OrderModel orderModel, String status) async {
    await _firebaseFirestore
        .collection("usersorders")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("orders")
        .doc(orderModel.orderid)
        .update({
      "status": status,
    });
    await _firebaseFirestore
        .collection("orders")
        .doc(orderModel.orderid)
        .update({
      "status": status,
    });
  }

  //again new Get order screen code

  Future<List<OrderModel>> getUserOrder() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection('usersorders')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('orders')
              .get();
      List<OrderModel> orderList =
          querySnapshot.docs.map((e) => OrderModel.fromjson(e.data())).toList();

      return orderList;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
