import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
RestError restErrorResponseFromJson(String str) =>
    RestError.fromJson(json.decode(str));

String restErrorResponseToJson(RestError data) => json.encode(data.toJson());

class RestError {
  String? name;
  String? message;
  int? code;
  String? className;
  bool? result;

  RestError({this.name, this.message, this.code, this.className, this.result});

  factory RestError.fromJson(Map<String, dynamic> json) => RestError(
      name: json["name"] ?? '',
      message: json["message"] ?? '',
      code: json["code"] ?? 0,
      className: json["className"] ?? '',
      result: json['result'] ?? false);
  @override
  String toString() => message ?? 'Some error occurred';

  Map<String, dynamic> toJson() => {
        "name": name,
        "message": message,
        "code": code,
        "className": className,
      };
}

class NoInternetError {
  @override
  String toString() => 'No internet connection.';
}
String parseFirebaseError(dynamic error){
  if(error is FirebaseException){
    return error.message??"Some error occurred";
  }
  else if(error is SocketException){
    return error.message;
  }
  else if(error is PlatformException){
    return error.message??"Some error occurred";
  }else {
    return "Some error occurred";
  }
}