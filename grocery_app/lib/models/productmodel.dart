import 'dart:convert';

ProductModel productmodellfromjson(String str) =>
    ProductModel.fromjson(json.decode(str));
// ignore: non_constant_identifier_names
String ProductModeltoJson(ProductModel data) => json.encode(data.tojson());

class ProductModel {
  ProductModel({
    required this.imageurl,
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    this.quantity,
  });
  String? imageurl;
  String? id;
  String? name;
  String? description;
  String? price;
  String? category;
  int? quantity;

  factory ProductModel.fromjson(Map<String, dynamic> json) => ProductModel(
      imageurl: json["imageurl"],
      id: json["id"],
      name: json["name"],
      price: json["price"].toString(),
      description: json['description'],
      category: json['category'],
      quantity: json[" quantity"]);
  Map<String, dynamic> tojson() => {
        "imageurl": imageurl,
        "id": id,
        "name": name,
        "price": price,
        "description": description,
        "category": category,
        // "description": description,

        " quantity": quantity,
      };
  @override
  ProductModel copyWith({
    int? quantity,
  }) =>
      ProductModel(
        imageurl: imageurl,
        id: id,
        category: category,
        description: description,
        name: name,
        price: price,
        quantity: quantity ?? this.quantity,
      );
}
