///
/// Created by Sunil Kumar (sunil@smarttersstudio.com)
/// On 03-11-2021 06:46 PM
///
// To parse this JSON data, do
//
//     final userAddressData = userAddressDataFromJson(jsonString);

import 'dart:convert';

UserAddressData userAddressDataFromJson(String str) =>
    UserAddressData.fromJson(json.decode(str));

String userAddressDataToJson(UserAddressData data) =>
    json.encode(data.toJson());

class UserAddressData {
  UserAddressData({
    required this.lat,
    required this.lng,
    required this.country,
    required this.state,
    required this.district,
    required this.placeName,
    required this.locality,
    required this.formattedAddress,
  });

  double lat;
  double lng;
  String country;
  String state;
  String district;
  String placeName;
  String locality;
  String formattedAddress;

  factory UserAddressData.fromJson(Map<String, dynamic> json) =>
      UserAddressData(
        lat: (json["lat"] ?? 0).toDouble(),
        lng: (json["lng"] ?? 0).toDouble(),
        country: json["country"] ?? "",
        state: json["state"] ?? "",
        district: json["district"] ?? "",
        placeName: json["placeName"] ?? "",
        locality: json["locality"] ?? "",
        formattedAddress: json["formattedAddress"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
        "country": country,
        "state": state,
        "district": district,
        "placeName": placeName,
        "locality": locality,
        "formattedAddress": formattedAddress,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAddressData &&
          runtimeType == other.runtimeType &&
          formattedAddress == other.formattedAddress;

  @override
  int get hashCode => formattedAddress.hashCode;
}
