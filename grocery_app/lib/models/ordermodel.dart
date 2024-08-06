import 'package:grocery_app/models/productmodel.dart';

class OrderModel {
  OrderModel({
    required this.orderid,
    required this.payment,
    required this.totalPrice,
    required this.status,
    required this.products,
    required this.userId,
  });
  String? payment;
  String? status;
  double? totalPrice;
  String? userId;
  List<ProductModel>? products;
  String? orderid;

  factory OrderModel.fromjson(Map<String, dynamic> json) {
    List<dynamic> productMap = json["products"];
    List<ProductModel> productList =
        productMap.map((e) => ProductModel.fromjson(e)).toList();
    return OrderModel(
      orderid: json["orderid"],
      payment: json["payment"],
      userId: json["userId"],
      totalPrice: json["totalPrice"],
      status: json["status"],
      products: productList,
    );
  }
}
