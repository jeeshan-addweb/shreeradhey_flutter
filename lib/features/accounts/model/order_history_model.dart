// To parse this JSON data, do
//
//     final orderHistoryModel = orderHistoryModelFromJson(jsonString);

import 'dart:convert';

OrderHistoryModel orderHistoryModelFromJson(String str) =>
    OrderHistoryModel.fromJson(json.decode(str));

String orderHistoryModelToJson(OrderHistoryModel data) =>
    json.encode(data.toJson());

class OrderHistoryModel {
  Data? data;

  OrderHistoryModel({this.data});

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) =>
      OrderHistoryModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"data": data?.toJson()};
}

class Data {
  Customer? customer;

  Data({this.customer});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    customer:
        json["customer"] == null ? null : Customer.fromJson(json["customer"]),
  );

  Map<String, dynamic> toJson() => {"customer": customer?.toJson()};
}

class Customer {
  Orders? orders;

  Customer({this.orders});

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    orders: json["orders"] == null ? null : Orders.fromJson(json["orders"]),
  );

  Map<String, dynamic> toJson() => {"orders": orders?.toJson()};
}

class Orders {
  PageInfo? pageInfo;
  List<OrdersNode>? nodes;

  Orders({this.pageInfo, this.nodes});

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
    pageInfo:
        json["pageInfo"] == null ? null : PageInfo.fromJson(json["pageInfo"]),
    nodes:
        json["nodes"] == null
            ? []
            : List<OrdersNode>.from(
              json["nodes"]!.map((x) => OrdersNode.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "pageInfo": pageInfo?.toJson(),
    "nodes":
        nodes == null ? [] : List<dynamic>.from(nodes!.map((x) => x.toJson())),
  };
}

class OrdersNode {
  String? id;
  int? databaseId;
  String? orderNumber;
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

  OrdersNode({
    this.id,
    this.databaseId,
    this.orderNumber,
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

  factory OrdersNode.fromJson(Map<String, dynamic> json) => OrdersNode(
    id: json["id"],
    databaseId: json["databaseId"],
    orderNumber: json["orderNumber"],
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
    "id": id,
    "databaseId": databaseId,
    "orderNumber": orderNumber,
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
  List<LineItemsNode>? nodes;

  LineItems({this.nodes});

  factory LineItems.fromJson(Map<String, dynamic> json) => LineItems(
    nodes:
        json["nodes"] == null
            ? []
            : List<LineItemsNode>.from(
              json["nodes"]!.map((x) => LineItemsNode.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "nodes":
        nodes == null ? [] : List<dynamic>.from(nodes!.map((x) => x.toJson())),
  };
}

class LineItemsNode {
  int? databaseId;
  int? quantity;
  String? total;
  String? subtotal;
  Product? product;

  LineItemsNode({
    this.databaseId,
    this.quantity,
    this.total,
    this.subtotal,
    this.product,
  });

  factory LineItemsNode.fromJson(Map<String, dynamic> json) => LineItemsNode(
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

class PageInfo {
  bool? hasNextPage;
  String? endCursor;

  PageInfo({this.hasNextPage, this.endCursor});

  factory PageInfo.fromJson(Map<String, dynamic> json) =>
      PageInfo(hasNextPage: json["hasNextPage"], endCursor: json["endCursor"]);

  Map<String, dynamic> toJson() => {
    "hasNextPage": hasNextPage,
    "endCursor": endCursor,
  };
}
