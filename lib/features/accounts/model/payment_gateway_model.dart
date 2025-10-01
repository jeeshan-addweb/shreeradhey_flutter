// To parse this JSON data, do
//
//     final paymentGatewayModel = paymentGatewayModelFromJson(jsonString);

import 'dart:convert';

PaymentGatewayModel paymentGatewayModelFromJson(String str) =>
    PaymentGatewayModel.fromJson(json.decode(str));

String paymentGatewayModelToJson(PaymentGatewayModel data) =>
    json.encode(data.toJson());

class PaymentGatewayModel {
  Data? data;

  PaymentGatewayModel({this.data});

  factory PaymentGatewayModel.fromJson(Map<String, dynamic> json) =>
      PaymentGatewayModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"data": data?.toJson()};
}

class Data {
  List<WcPaymentGateway>? wcPaymentGateways;

  Data({this.wcPaymentGateways});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    wcPaymentGateways:
        json["wcPaymentGateways"] == null
            ? []
            : List<WcPaymentGateway>.from(
              json["wcPaymentGateways"]!.map(
                (x) => WcPaymentGateway.fromJson(x),
              ),
            ),
  );

  Map<String, dynamic> toJson() => {
    "wcPaymentGateways":
        wcPaymentGateways == null
            ? []
            : List<dynamic>.from(wcPaymentGateways!.map((x) => x.toJson())),
  };
}

class WcPaymentGateway {
  String? id;
  String? title;
  bool? enabled;
  List<Setting>? settings;

  WcPaymentGateway({this.id, this.title, this.enabled, this.settings});

  factory WcPaymentGateway.fromJson(Map<String, dynamic> json) =>
      WcPaymentGateway(
        id: json["id"],
        title: json["title"],
        enabled: json["enabled"],
        settings:
            json["settings"] == null
                ? []
                : List<Setting>.from(
                  json["settings"]!.map((x) => Setting.fromJson(x)),
                ),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "enabled": enabled,
    "settings":
        settings == null
            ? []
            : List<dynamic>.from(settings!.map((x) => x.toJson())),
  };
}

class Setting {
  String? key;
  String? value;

  Setting({this.key, this.value});

  factory Setting.fromJson(Map<String, dynamic> json) =>
      Setting(key: json["key"], value: json["value"]);

  Map<String, dynamic> toJson() => {"key": key, "value": value};
}
