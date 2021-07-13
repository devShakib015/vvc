import 'dart:convert';

class UserName {
  String userName;
  UserName({
    required this.userName,
  });

  UserName copyWith({
    String? userName,
  }) {
    return UserName(
      userName: userName ?? this.userName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
    };
  }

  factory UserName.fromMap(Map<String, dynamic> map) {
    return UserName(
      userName: map['userName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserName.fromJson(String source) =>
      UserName.fromMap(json.decode(source));
}
