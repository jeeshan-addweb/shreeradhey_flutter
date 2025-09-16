// To parse this JSON data, do
//
//     final createOrderModel = createOrderModelFromJson(jsonString);

import 'dart:convert';

CreateOrderModel createOrderModelFromJson(String str) =>
    CreateOrderModel.fromJson(json.decode(str));

String createOrderModelToJson(CreateOrderModel data) =>
    json.encode(data.toJson());

class CreateOrderModel {
  Data? data;

  CreateOrderModel({this.data});

  factory CreateOrderModel.fromJson(Map<String, dynamic> json) =>
      CreateOrderModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"data": data?.toJson()};
}

class Data {
  CreateOrder? createOrder;

  Data({this.createOrder});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    createOrder:
        json["createOrder"] == null
            ? null
            : CreateOrder.fromJson(json["createOrder"]),
  );

  Map<String, dynamic> toJson() => {"createOrder": createOrder?.toJson()};
}

class CreateOrder {
  Order? order;
  int? orderId;

  CreateOrder({this.order, this.orderId});

  factory CreateOrder.fromJson(Map<String, dynamic> json) => CreateOrder(
    order: json["order"] == null ? null : Order.fromJson(json["order"]),
    orderId: json["orderId"],
  );

  Map<String, dynamic> toJson() => {
    "order": order?.toJson(),
    "orderId": orderId,
  };
}

class Order {
  dynamic orderKey;
  String? status;
  String? total;
  LineItems? lineItems;

  Order({this.orderKey, this.status, this.total, this.lineItems});

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    orderKey: json["orderKey"],
    status: json["status"],
    total: json["total"],
    lineItems:
        json["lineItems"] == null
            ? null
            : LineItems.fromJson(json["lineItems"]),
  );

  Map<String, dynamic> toJson() => {
    "orderKey": orderKey,
    "status": status,
    "total": total,
    "lineItems": lineItems?.toJson(),
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
  Product? product;
  String? total;

  NodeElement({this.product, this.total});

  factory NodeElement.fromJson(Map<String, dynamic> json) => NodeElement(
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "product": product?.toJson(),
    "total": total,
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

  ProductNode({this.name});

  factory ProductNode.fromJson(Map<String, dynamic> json) =>
      ProductNode(name: json["name"]);

  Map<String, dynamic> toJson() => {"name": name};
}
