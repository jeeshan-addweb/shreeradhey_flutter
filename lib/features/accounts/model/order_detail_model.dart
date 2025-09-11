// To parse this JSON data, do
//
//     final orderDetailModel = orderDetailModelFromJson(jsonString);

import 'dart:convert';

OrderDetailModel orderDetailModelFromJson(String str) =>
    OrderDetailModel.fromJson(json.decode(str));

String orderDetailModelToJson(OrderDetailModel data) =>
    json.encode(data.toJson());

class OrderDetailModel {
  Data? data;

  OrderDetailModel({this.data});

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"data": data?.toJson()};
}

class Data {
  Order? order;

  Data({this.order});

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(order: json["order"] == null ? null : Order.fromJson(json["order"]));

  Map<String, dynamic> toJson() => {"order": order?.toJson()};
}

class Order {
  String? orderNumber;
  int? databaseId;
  DateTime? date;
  String? status;
  String? total;
  String? shippingTotal;
  String? paymentMethodTitle;
  String? transactionId;
  dynamic customerNote;
  LineItems? lineItems;
  Ing? billing;
  Ing? shipping;

  Order({
    this.orderNumber,
    this.databaseId,
    this.date,
    this.status,
    this.total,
    this.shippingTotal,
    this.paymentMethodTitle,
    this.transactionId,
    this.customerNote,
    this.lineItems,
    this.billing,
    this.shipping,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    orderNumber: json["orderNumber"],
    databaseId: json["databaseId"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    status: json["status"],
    total: json["total"],
    shippingTotal: json["shippingTotal"],
    paymentMethodTitle: json["paymentMethodTitle"],
    transactionId: json["transactionId"],
    customerNote: json["customerNote"],
    lineItems:
        json["lineItems"] == null
            ? null
            : LineItems.fromJson(json["lineItems"]),
    billing: json["billing"] == null ? null : Ing.fromJson(json["billing"]),
    shipping: json["shipping"] == null ? null : Ing.fromJson(json["shipping"]),
  );

  Map<String, dynamic> toJson() => {
    "orderNumber": orderNumber,
    "databaseId": databaseId,
    "date": date?.toIso8601String(),
    "status": status,
    "total": total,
    "shippingTotal": shippingTotal,
    "paymentMethodTitle": paymentMethodTitle,
    "transactionId": transactionId,
    "customerNote": customerNote,
    "lineItems": lineItems?.toJson(),
    "billing": billing?.toJson(),
    "shipping": shipping?.toJson(),
  };
}

class Ing {
  String? firstName;
  String? lastName;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? postcode;
  String? country;
  String? email;
  String? phone;

  Ing({
    this.firstName,
    this.lastName,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.postcode,
    this.country,
    this.email,
    this.phone,
  });

  factory Ing.fromJson(Map<String, dynamic> json) => Ing(
    firstName: json["firstName"],
    lastName: json["lastName"],
    address1: json["address1"],
    address2: json["address2"],
    city: json["city"],
    state: json["state"],
    postcode: json["postcode"],
    country: json["country"],
    email: json["email"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "address1": address1,
    "address2": address2,
    "city": city,
    "state": state,
    "postcode": postcode,
    "country": country,
    "email": email,
    "phone": phone,
  };
}

class LineItems {
  List<NodeElement>? nodes;

  LineItems({this.nodes});

  factory LineItems.fromJson(Map<String, dynamic> json) => LineItems(
    nodes:
        json["nodes"] == null
            ? []
            : List<NodeElement>.from(
              json["nodes"]!.map((x) => NodeElement.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "nodes":
        nodes == null ? [] : List<dynamic>.from(nodes!.map((x) => x.toJson())),
  };
}

class NodeElement {
  int? databaseId;
  int? quantity;
  String? total;
  String? subtotal;
  Product? product;

  NodeElement({
    this.databaseId,
    this.quantity,
    this.total,
    this.subtotal,
    this.product,
  });

  factory NodeElement.fromJson(Map<String, dynamic> json) => NodeElement(
    databaseId: json["databaseId"],
    quantity: json["quantity"],
    total: json["total"],
    subtotal: json["subtotal"],
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "databaseId": databaseId,
    "quantity": quantity,
    "total": total,
    "subtotal": subtotal,
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
  String? name;
  String? slug;
  String? sku;
  String? price;
  String? regularPrice;
  String? salePrice;

  ProductNode({
    this.name,
    this.slug,
    this.sku,
    this.price,
    this.regularPrice,
    this.salePrice,
  });

  factory ProductNode.fromJson(Map<String, dynamic> json) => ProductNode(
    name: json["name"],
    slug: json["slug"],
    sku: json["sku"],
    price: json["price"],
    regularPrice: json["regularPrice"],
    salePrice: json["salePrice"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "slug": slug,
    "sku": sku,
    "price": price,
    "regularPrice": regularPrice,
    "salePrice": salePrice,
  };
}
