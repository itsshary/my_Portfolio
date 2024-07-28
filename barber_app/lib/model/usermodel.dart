import 'dart:convert';

UserModel userModelfromjson(String str) => UserModel.fromjson(json.decode(str));
String usermodeltoJson(UserModel data) => json.encode(data.tojson());

class UserModel {
  UserModel(
      {required this.image,
      required this.id,
      required this.name,
      required this.email});
  String? image;
  String? id;
  String? name;
  String? email;

  factory UserModel.fromjson(Map<String, dynamic> json) => UserModel(
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
  // ignore: override_on_non_overriding_member
  UserModel copyWith({
    String? name,
    image,
  }) =>
      UserModel(image: image, id: id, name: name, email: email);
}
