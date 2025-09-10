// To parse this JSON data, do
//
//     final getAvailableCouponModel = getAvailableCouponModelFromJson(jsonString);

import 'dart:convert';

GetAvailableCouponModel getAvailableCouponModelFromJson(String str) =>
    GetAvailableCouponModel.fromJson(json.decode(str));

String getAvailableCouponModelToJson(GetAvailableCouponModel data) =>
    json.encode(data.toJson());

class GetAvailableCouponModel {
  Data? data;

  GetAvailableCouponModel({this.data});

  factory GetAvailableCouponModel.fromJson(Map<String, dynamic> json) =>
      GetAvailableCouponModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"data": data?.toJson()};
}

class Data {
  List<AvailableCoupon>? availableCoupons;

  Data({this.availableCoupons});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    availableCoupons:
        json["availableCoupons"] == null
            ? []
            : List<AvailableCoupon>.from(
              json["availableCoupons"]!.map((x) => AvailableCoupon.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "availableCoupons":
        availableCoupons == null
            ? []
            : List<dynamic>.from(availableCoupons!.map((x) => x.toJson())),
  };
}

class AvailableCoupon {
  String? id;
  String? code;
  String? amount;
  String? discountType;
  DateTime? expiryDate;
  int? usageLimit;
  int? usageCount;
  String? description;

  AvailableCoupon({
    this.id,
    this.code,
    this.amount,
    this.discountType,
    this.expiryDate,
    this.usageLimit,
    this.usageCount,
    this.description,
  });

  factory AvailableCoupon.fromJson(Map<String, dynamic> json) =>
      AvailableCoupon(
        id: json["id"],
        code: json["code"],
        amount: json["amount"],
        discountType: json["discountType"],
        expiryDate:
            json["expiryDate"] == null
                ? null
                : DateTime.parse(json["expiryDate"]),
        usageLimit: json["usageLimit"],
        usageCount: json["usageCount"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "amount": amount,
    "discountType": discountType,
    "expiryDate":
        "${expiryDate!.year.toString().padLeft(4, '0')}-${expiryDate!.month.toString().padLeft(2, '0')}-${expiryDate!.day.toString().padLeft(2, '0')}",
    "usageLimit": usageLimit,
    "usageCount": usageCount,
    "description": description,
  };
}
