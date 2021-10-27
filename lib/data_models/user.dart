// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

UserResponse userResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  UserResponse({this.accessToken, this.user});

  String? accessToken;
  UserDatum? user;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
      accessToken: json["accessToken"],
      user: json["user"] != null ? UserDatum.fromJson(json["user"]) : null);

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "user": user?.toJson(),
      };
}

class UserDatum {
  UserDatum(
      {required this.id,
      this.status,
      this.role,
      this.createdAt,
      this.updatedAt,
      this.phone,
      this.name,
      this.dob,
      this.gender,
      this.avatar});

  String id;
  int? status;
  int? role;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? phone;
  String? name;
  String? avatar;
  DateTime? dob;
  int? gender;

  String get genderString {
    switch (gender) {
      case 1:
        return "Male";
      case 2:
        return "Female";
      case 3:
        return "Others";
      default:
        return "";
    }
  }

  int get age {
    return dob == null ? 0 : DateTime.now().difference(dob!).inDays ~/ 365;
  }

  factory UserDatum.fromJson(Map<String, dynamic> json) => UserDatum(
        id: json["_id"],
        status: json["status"] ?? 0,
        role: json["role"] ?? 0,
        avatar: json["avatar"],
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"]).toLocal()
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"]).toLocal()
            : null,
        phone: json["phone"] ?? '',
        name: json["name"] ?? '',
        gender: json["gender"] ?? 0,
        dob: json["dob"] != null ? DateTime.parse(json["dob"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "status": status,
        "role": role,
        "avatar": avatar,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "phone": phone,
        'name': name,
        "dob": dob?.toIso8601String(),
        "gender": gender,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDatum && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
