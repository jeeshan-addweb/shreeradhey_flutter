// To parse this JSON data, do
//
//     final cartShippingMethodModel = cartShippingMethodModelFromJson(jsonString);

import 'dart:convert';

CartShippingMethodModel cartShippingMethodModelFromJson(String str) =>
    CartShippingMethodModel.fromJson(json.decode(str));

String cartShippingMethodModelToJson(CartShippingMethodModel data) =>
    json.encode(data.toJson());

class CartShippingMethodModel {
  Data? data;

  CartShippingMethodModel({this.data});

  factory CartShippingMethodModel.fromJson(Map<String, dynamic> json) =>
      CartShippingMethodModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"data": data?.toJson()};
}

class Data {
  Cart? cart;

  Data({this.cart});

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(cart: json["cart"] == null ? null : Cart.fromJson(json["cart"]));

  Map<String, dynamic> toJson() => {"cart": cart?.toJson()};
}

class Cart {
  List<AvailableShippingMethodCart>? availableShippingMethods;

  Cart({this.availableShippingMethods});

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    availableShippingMethods:
        json["availableShippingMethods"] == null
            ? []
            : List<AvailableShippingMethodCart>.from(
              json["availableShippingMethods"]!.map(
                (x) => AvailableShippingMethodCart.fromJson(x),
              ),
            ),
  );

  Map<String, dynamic> toJson() => {
    "availableShippingMethods":
        availableShippingMethods == null
            ? []
            : List<dynamic>.from(
              availableShippingMethods!.map((x) => x.toJson()),
            ),
  };
}

class AvailableShippingMethodCart {
  List<Rate>? rates;

  AvailableShippingMethodCart({this.rates});

  factory AvailableShippingMethodCart.fromJson(Map<String, dynamic> json) =>
      AvailableShippingMethodCart(
        rates:
            json["rates"] == null
                ? []
                : List<Rate>.from(json["rates"]!.map((x) => Rate.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "rates":
        rates == null ? [] : List<dynamic>.from(rates!.map((x) => x.toJson())),
  };
}

class Rate {
  String? id;
  String? label;
  dynamic cost;

  Rate({this.id, this.label, this.cost});

  factory Rate.fromJson(Map<String, dynamic> json) =>
      Rate(id: json["id"], label: json["label"], cost: json["cost"]);

  Map<String, dynamic> toJson() => {"id": id, "label": label, "cost": cost};
}
