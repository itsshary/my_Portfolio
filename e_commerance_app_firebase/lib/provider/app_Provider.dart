import 'package:e_commerance_app_firebase/models/Bestproductmodel.dart';
import 'package:e_commerance_app_firebase/models/firebase_firestore.dart';
import 'package:e_commerance_app_firebase/models/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
 

class AppProvider with ChangeNotifier {
  List<ProductModel> _cartProductList = [];
  List<ProductModel> _BuyProductList = [];
  final _auth = FirebaseAuth.instance;

  NewUserModel? _newUserModel;

  NewUserModel get getuserinformation => _newUserModel!;
  void addCartProducts(ProductModel productModel) {
    _cartProductList.add(productModel);
    notifyListeners();
  }

  void removeCartProducts(ProductModel productModel) {
    _cartProductList.remove(productModel);
    notifyListeners();
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  List<ProductModel> get getCartProductList => _cartProductList;
//favouritecart
  List<ProductModel> _FavouriteProductList = [];
  void addFavouriteProducts(ProductModel productModel) {
    _FavouriteProductList.add(productModel);
    notifyListeners();
  }

  void removefavouriteProducts(ProductModel productModel) {
    _FavouriteProductList.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getfavouriteProductList => _FavouriteProductList;

  //user information
  void getuserinfoFirebase() async {
    _newUserModel = await FirebaseFirestoreHelper.instance.getUserInformation();
    notifyListeners();
  }

//update profile
  // void updateUserInfoFirebase(
  //     BuildContext context, NewUserModel newUserModel, File? file) async {
  //   if (file == null) {
  //     await FirebaseFirestore.instance
  //         .collection("users")
  //         .doc(newUserModel.id)
  //         .set(newUserModel.tojson());
  //   } else {
  //     String imageurl =
  //         await FirebasestorageHelper.instance.uploaduserimage(file);
  //     _newUserModel = newUserModel.copyWith(image: imageurl);
  //     await FirebaseFirestore.instance
  //         .collection("users")
  //         .doc(_newUserModel!.id)
  //         .set(_newUserModel!.tojson());
  //     notifyListeners();
  //   }
  // }

  void signoutset() async {
    await _auth.signOut();
  }

  double Totalprice() {
    double totalprice = 0.0;
    for (var element in _cartProductList) {
      double convertqty = double.parse(element.quantity.toString());
      double convertprice = double.parse(element.price.toString());
      totalprice += convertqty * convertprice;
    }
    return totalprice;
  }

  double TotalpriceButyproductList() {
    double totalprice = 0.0;
    for (var element in _BuyProductList) {
      double convertqty = double.parse(element.quantity.toString());
      double convertprice = double.parse(element.price.toString());
      totalprice += convertqty * convertprice;
    }
    return totalprice;
  }

  void updatequanttity(ProductModel productModel, int quantity) {
    int index = _cartProductList.indexOf(productModel);
    _cartProductList[index].quantity = quantity;
    notifyListeners();
  }

  void addBuyProduct(ProductModel model) {
    _BuyProductList.add(model);
    notifyListeners();
  }

  void addBuyProductCartList() {
    _BuyProductList.addAll(_cartProductList);
    notifyListeners();
  }

  void clearCart() {
    _cartProductList.clear();
    notifyListeners();
  }

  void clearBuyProduct() {
    _BuyProductList.clear();
    notifyListeners();
  }

  List<ProductModel> get getbuyproductlist => _BuyProductList;
}
