import 'dart:convert';

//sir name catagory MODEL
UserModel userModelfromjson(String str) => UserModel.fromjson(json.decode(str));
String UsermodeltoJson(UserModel data) => json.encode(data.tojson());

class UserModel {
  UserModel({
    required this.image,
    required this.id,
    required this.name,
  });
  String? image;
  String? id;
  String? name;

  factory UserModel.fromjson(Map<String, dynamic> json) => UserModel(
        image: json["image"],
        id: json["id"],
        name: json["name"],
      );
  Map<String, dynamic> tojson() => {
        "image": image,
        "id": id,
        "name": name,
      };
}
