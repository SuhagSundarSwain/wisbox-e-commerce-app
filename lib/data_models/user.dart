// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

UserDatum userFromJson(String str) => UserDatum.fromJson(json.decode(str));

String userToJson(UserDatum data) => json.encode(data.toJson());

class UserDatum {
  UserDatum({
    required this.uid,
    required this.email,
    required this.name,
    required this.type,
    this.createdAt,
  });

  String uid;
  String email;
  String name;
  int type;
  DateTime? createdAt;

  factory UserDatum.fromJson(Map<String, dynamic> json) => UserDatum(
        uid: json["uid"] ?? "",
        email: json["email"] ?? "",
        name: json["name"] ?? "",
        type: json["type"] ?? 1,
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "name": name,
        "type": type,
        "createdAt": createdAt?.toIso8601String(),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDatum &&
          runtimeType == other.runtimeType &&
          uid == other.uid;

  @override
  int get hashCode => uid.hashCode;
}
