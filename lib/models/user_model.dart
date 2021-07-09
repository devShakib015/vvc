import 'dart:convert';

class UserModel {
  String id;
  String? name;
  String email;
  String? profilePicUrl;
  UserModel({
    required this.id,
    this.name,
    required this.email,
    this.profilePicUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profilePicUrl': profilePicUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      profilePicUrl: map['profilePicUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
