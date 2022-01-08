// To parse this JSON data, do
//
//     final responseAlamatList = responseAlamatListFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ResponseAlamatList responseAlamatListFromJson(String str) =>
    ResponseAlamatList.fromJson(json.decode(str));

String responseAlamatListToJson(ResponseAlamatList data) =>
    json.encode(data.toJson());

class ResponseAlamatList {
  ResponseAlamatList({
    required this.status,
    required this.message,
    required this.addresses,
  });

  final String status;
  final String message;
  final List<Address> addresses;

  factory ResponseAlamatList.fromJson(Map<String, dynamic> json) =>
      ResponseAlamatList(
        status: json["status"],
        message: json["message"],
        addresses: List<Address>.from(
            json["addresses"].map((x) => Address.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "addresses": List<dynamic>.from(addresses.map((x) => x.toJson())),
      };
}

class Address {
  Address({
    required this.id,
    required this.userId,
    required this.address,
    required this.cityId,
    required this.postalCode,
    required this.recipientName,
    required this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.latitude,
    required this.longitude,
  });

  final int id;
  final int userId;
  final String address;
  final int cityId;
  final String postalCode;
  final String recipientName;
  final String phoneNumber;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final String latitude;
  final String longitude;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        userId: json["user_id"],
        address: json["address"],
        cityId: json["city_id"],
        postalCode: json["postal_code"],
        recipientName: json["recipient_name"],
        phoneNumber: json["phone_number"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "address": address,
        "city_id": cityId,
        "postal_code": postalCode,
        "recipient_name": recipientName,
        "phone_number": phoneNumber,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "latitude": latitude,
        "longitude": longitude,
      };
}
