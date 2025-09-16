// To parse this JSON data, do
//
//     final getCartModel = getCartModelFromJson(jsonString);

import 'dart:convert';

GetCartModel getCartModelFromJson(String str) =>
    GetCartModel.fromJson(json.decode(str));

String getCartModelToJson(GetCartModel data) => json.encode(data.toJson());

class GetCartModel {
  Data? data;

  GetCartModel({this.data});

  factory GetCartModel.fromJson(Map<String, dynamic> json) => GetCartModel(
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
  Contents? contents;
  String? subtotal;
  String? total;
  String? shippingTotal;
  String? totalTax;
  List<String>? chosenShippingMethods;
  List<AvailableShippingMethod>? availableShippingMethods;

  Cart({
    this.contents,
    this.subtotal,
    this.total,
    this.shippingTotal,
    this.totalTax,
    this.chosenShippingMethods,
    this.availableShippingMethods,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    contents:
        json["contents"] == null ? null : Contents.fromJson(json["contents"]),
    subtotal: json["subtotal"],
    total: json["total"],
    shippingTotal: json["shippingTotal"],
    totalTax: json["totalTax"],
    chosenShippingMethods:
        json["chosenShippingMethods"] == null
            ? []
            : List<String>.from(json["chosenShippingMethods"]!.map((x) => x)),
    availableShippingMethods:
        json["availableShippingMethods"] == null
            ? []
            : List<AvailableShippingMethod>.from(
              json["availableShippingMethods"]!.map(
                (x) => AvailableShippingMethod.fromJson(x),
              ),
            ),
  );

  Map<String, dynamic> toJson() => {
    "contents": contents?.toJson(),
    "subtotal": subtotal,
    "total": total,
    "shippingTotal": shippingTotal,
    "totalTax": totalTax,
    "chosenShippingMethods":
        chosenShippingMethods == null
            ? []
            : List<dynamic>.from(chosenShippingMethods!.map((x) => x)),
    "availableShippingMethods":
        availableShippingMethods == null
            ? []
            : List<dynamic>.from(
              availableShippingMethods!.map((x) => x.toJson()),
            ),
  };
}

class AvailableShippingMethod {
  List<Rate>? rates;

  AvailableShippingMethod({this.rates});

  factory AvailableShippingMethod.fromJson(Map<String, dynamic> json) =>
      AvailableShippingMethod(
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

class Contents {
  int? itemCount;
  String? currencySymbol;
  List<NodeElement>? nodes;

  Contents({this.itemCount, this.nodes, this.currencySymbol});

  factory Contents.fromJson(Map<String, dynamic> json) => Contents(
    itemCount: json["itemCount"],
    currencySymbol: json["currencySymbol"] as String?,
    nodes:
        json["nodes"] == null
            ? []
            : List<NodeElement>.from(
              json["nodes"]!.map((x) => NodeElement.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "itemCount": itemCount,
    "currencySymbol": currencySymbol,
    "nodes":
        nodes == null ? [] : List<dynamic>.from(nodes!.map((x) => x.toJson())),
  };
}

class NodeElement {
  String? key;
  int? quantity;
  String? subtotal;
  String? total;
  Product? product;

  NodeElement({
    this.key,
    this.quantity,
    this.subtotal,
    this.total,
    this.product,
  });

  factory NodeElement.fromJson(Map<String, dynamic> json) => NodeElement(
    key: json["key"],
    quantity: json["quantity"],
    subtotal: json["subtotal"],
    total: json["total"],
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "quantity": quantity,
    "subtotal": subtotal,
    "total": total,
    "product": product?.toJson(),
  };
}

class Product {
  ProductNode? node;

  Product({this.node});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    node: json["node"] == null ? null : ProductNode.fromJson(json["node"]),
  );

  Map<String, dynamic> toJson() => {"node": node?.toJson()};
}

class ProductNode {
  String? id;
  int? databaseId;
  String? name;
  String? slug;
  String? sku;
  String? type;
  Image? image;
  String? price;
  String? regularPrice;
  String? salePrice;

  ProductNode({
    this.id,
    this.databaseId,
    this.name,
    this.slug,
    this.sku,
    this.type,
    this.image,
    this.price,
    this.regularPrice,
    this.salePrice,
  });

  factory ProductNode.fromJson(Map<String, dynamic> json) => ProductNode(
    id: json["id"],
    databaseId: json["databaseId"],
    name: json["name"],
    slug: json["slug"],
    sku: json["sku"],
    type: json["type"],
    image: json["image"] == null ? null : Image.fromJson(json["image"]),
    price: json["price"],
    regularPrice: json["regularPrice"],
    salePrice: json["salePrice"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "databaseId": databaseId,
    "name": name,
    "slug": slug,
    "sku": sku,
    "type": type,
    "image": image?.toJson(),
    "price": price,
    "regularPrice": regularPrice,
    "salePrice": salePrice,
  };
}

class Image {
  String? sourceUrl;
  String? altText;

  Image({this.sourceUrl, this.altText});

  factory Image.fromJson(Map<String, dynamic> json) =>
      Image(sourceUrl: json["sourceUrl"], altText: json["altText"]);

  Map<String, dynamic> toJson() => {"sourceUrl": sourceUrl, "altText": altText};
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
