import 'package:flutter/material.dart';
import 'package:grocery_app/firebase/firebasefirestore_helper.dart';
import 'package:grocery_app/models/productmodel.dart';
import 'package:grocery_app/models/usermodel.dart';

class AppProvider with ChangeNotifier {
  List<ProductModel> _cartProductList = [];
  List<ProductModel> _BuyProductList = [];

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
