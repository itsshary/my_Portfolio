import 'dart:convert';

//sir name user model
NewUserModel userModelfromjson(String str) =>
    NewUserModel.fromjson(json.decode(str));
String UsermodeltoJson(NewUserModel data) => json.encode(data.tojson());

class NewUserModel {
  NewUserModel(
      {required this.image,
      required this.id,
      required this.name,
      required this.email});
  String? image;
  String? id;
  String? name;
  String email;

  factory NewUserModel.fromjson(Map<String, dynamic> json) => NewUserModel(
      image: json["image"],
      id: json["id"],
      name: json["name"],
      email: json["email"]);
  Map<String, dynamic> tojson() => {
        "image": image,
        "id": id,
        "name": name,
        "email": email,
      };
  @override
  NewUserModel copyWith({
    String? name,
    image,
  }) =>
      NewUserModel(image: image, id: id, name: name, email: email);
}
