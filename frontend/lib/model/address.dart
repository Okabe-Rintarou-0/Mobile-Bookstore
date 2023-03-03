// To parse this JSON data, do
//
//     final addressInfo = addressInfoFromJson(jsonString);

import 'dart:convert';

AddressInfo addressInfoFromJson(String str) =>
    AddressInfo.fromJson(json.decode(str));

String addressInfoToJson(AddressInfo data) => json.encode(data.toJson());

class AddressInfo {
  AddressInfo({
    required this.id,
    required this.address,
    required this.tel,
    required this.name,
    required this.isDefault,
  });

  int id;
  String address;
  String tel;
  String name;
  bool isDefault;

  factory AddressInfo.fromJson(Map<String, dynamic> json) => AddressInfo(
        id: json["id"],
        address: json["address"],
        tel: json["tel"],
        name: json["name"],
        isDefault: json["isDefault"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "tel": tel,
        "name": name,
        "isDefault": isDefault,
      };
}
