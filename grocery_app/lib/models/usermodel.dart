class UserModel {
  String? image;
  String? id;
  String? name;
  String? email;
  String? address;

  UserModel({
    required this.image,
    required this.id,
    required this.name,
    required this.email,
    required this.address,
  });

  factory UserModel.fromjson(Map<String, dynamic> json) => UserModel(
      image: json["image"],
      id: json["id"],
      name: json["name"],
      email: json["email"],
      address: json["address"]);

  Map<String, dynamic> tojson() => {
        "image": image,
        "id": id,
        "name": name,
        "email": email,
        "address": address
      };

  UserModel copyWith({
    String? name,
    String? image,
    String? address,
  }) =>
      UserModel(
          image: image ?? this.image,
          id: id,
          name: name ?? this.name,
          email: email,
          address: address ?? this.address);
}
