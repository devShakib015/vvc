import 'dart:convert';

class UserModel {
  String id;
  String userName;
  String? name;
  String email;
  String? profilePicUrl;
  UserModel({
    required this.id,
    required this.userName,
    this.name,
    required this.email,
    this.profilePicUrl,
  });

  UserModel copyWith({
    String? id,
    String? userName,
    String? name,
    String? email,
    String? profilePicUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      name: name ?? this.name,
      email: email ?? this.email,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userName': userName,
      'name': name,
      'email': email,
      'profilePicUrl': profilePicUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      userName: map['userName'],
      name: map['name'],
      email: map['email'],
      profilePicUrl: map['profilePicUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
