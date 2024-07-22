import 'dart:convert';

ProductModel productmodellfromjson(String str) =>
    ProductModel.fromjson(json.decode(str));
String ProductModeltoJson(ProductModel data) => json.encode(data.tojson());

class ProductModel {
  ProductModel({
    required this.image,
    required this.id,
    required this.name,
    required this.price,
    // required this.description,
    required this.isfavourite,
    this.quantity,
  });
  String? image;
  String? id;
  String? name;
  String? price;
  // String? description;
  bool isfavourite;
  int? quantity;

  factory ProductModel.fromjson(Map<String, dynamic> json) => ProductModel(
      image: json["image"],
      id: json["id"],
      name: json["name"],
      price: json["price"].toString(),
      // description: json["descrption"],
      isfavourite: false,
      quantity: json[" quantity"]);
  Map<String, dynamic> tojson() => {
        "image": image,
        "id": id,
        "name": name,
        "price": price,
        // "description": description,
        "isfavourite": isfavourite,
        " quantity": quantity,
      };
  @override
  ProductModel copyWith({
    int? quantity,
  }) =>
      ProductModel(
        image: image,
        id: id,
        name: name,
        price: price,
        // description: description,
        isfavourite: isfavourite,
        quantity: quantity ?? this.quantity,
      );
}
