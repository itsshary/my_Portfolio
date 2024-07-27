class UserModel {
  String? image;
  String? id;
  String? name;
  String email;
  List<String> followers; // List of user IDs who follow this user
  List<String> following; // List of user IDs this user follows

  UserModel({
    required this.image,
    required this.id,
    required this.name,
    required this.email,
    this.followers = const [],
    this.following = const [],
  });

  factory UserModel.fromjson(Map<String, dynamic> json) => UserModel(
        image: json["image"],
        id: json["id"],
        name: json["name"],
        email: json["email"],
        followers: List<String>.from(json["followers"] ?? []),
        following: List<String>.from(json["following"] ?? []),
      );

  Map<String, dynamic> tojson() => {
        "image": image,
        "id": id,
        "name": name,
        "email": email,
        "followers": followers,
        "following": following,
      };

  UserModel copyWith({
    String? name,
    String? image,
    List<String>? followers,
    List<String>? following,
  }) =>
      UserModel(
        image: image ?? this.image,
        id: id,
        name: name ?? this.name,
        email: email,
        followers: followers ?? this.followers,
        following: following ?? this.following,
      );
}
