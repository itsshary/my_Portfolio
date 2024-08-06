import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_app/models/ordermodel.dart';
import 'package:grocery_app/models/productmodel.dart';
import 'package:grocery_app/models/usermodel.dart';
import 'package:grocery_app/utilis/toastmessage.dart';

class FirebasefirestoreHelper {
  static FirebasefirestoreHelper instance = FirebasefirestoreHelper();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  Future<List<ProductModel>> getProductsByCategory(String category) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection('products')
              .where('category', isEqualTo: category)
              .get();

      List<ProductModel> productList = querySnapshot.docs
          .map((e) => ProductModel.fromjson(e.data()))
          .toList();
      return productList;
    } catch (e) {
      return [];
    }
  }

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
      Utilies().toast("Order Recorder SuccessFully");
      return true;
    } catch (e) {
      Utilies().toast(e.toString());
      return false;
    }
  }

  Stream<UserModel?> getUserInformation() {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      return _firebaseFirestore
          .collection("users")
          .doc(currentUser.uid)
          .snapshots()
          .map((snapshot) {
        if (snapshot.exists && snapshot.data() != null) {
          return UserModel.fromjson(snapshot.data()!);
        } else {
          return null;
        }
      });
    } else {
      // Handle the case when the current user is null (not logged in)
      return Stream.value(null);
    }
  }

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
