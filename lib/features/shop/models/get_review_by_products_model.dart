// To parse this JSON data, do
//
//     final getReviewByProductModel = getReviewByProductModelFromJson(jsonString);

import 'dart:convert';

GetReviewByProductModel getReviewByProductModelFromJson(String str) =>
    GetReviewByProductModel.fromJson(json.decode(str));

String getReviewByProductModelToJson(GetReviewByProductModel data) =>
    json.encode(data.toJson());

class GetReviewByProductModel {
  Data? data;

  GetReviewByProductModel({this.data});

  factory GetReviewByProductModel.fromJson(Map<String, dynamic> json) =>
      GetReviewByProductModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"data": data?.toJson()};
}

class Data {
  Product? product;

  Data({this.product});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {"product": product?.toJson()};
}

class Product {
  Reviews? reviews;

  Product({this.reviews});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    reviews: json["reviews"] == null ? null : Reviews.fromJson(json["reviews"]),
  );

  Map<String, dynamic> toJson() => {"reviews": reviews?.toJson()};
}

class Reviews {
  PageInfo? pageInfo;
  List<NodeElement>? nodes;

  Reviews({this.pageInfo, this.nodes});

  factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
    pageInfo:
        json["pageInfo"] == null ? null : PageInfo.fromJson(json["pageInfo"]),
    nodes:
        json["nodes"] == null
            ? []
            : List<NodeElement>.from(
              json["nodes"]!.map((x) => NodeElement.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "pageInfo": pageInfo?.toJson(),
    "nodes":
        nodes == null ? [] : List<dynamic>.from(nodes!.map((x) => x.toJson())),
  };
}

class NodeElement {
  String? id;
  String? content;
  DateTime? date;
  int? rating;
  Author? author;

  NodeElement({this.id, this.content, this.date, this.rating, this.author});

  factory NodeElement.fromJson(Map<String, dynamic> json) => NodeElement(
    id: json["id"],
    content: json["content"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    rating: json["rating"],
    author: json["author"] == null ? null : Author.fromJson(json["author"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content,
    "date": date?.toIso8601String(),
    "rating": rating,
    "author": author?.toJson(),
  };
}

class Author {
  AuthorNode? node;

  Author({this.node});

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    node: json["node"] == null ? null : AuthorNode.fromJson(json["node"]),
  );

  Map<String, dynamic> toJson() => {"node": node?.toJson()};
}

class AuthorNode {
  String? name;
  Avatar? avatar;

  AuthorNode({this.name, this.avatar});

  factory AuthorNode.fromJson(Map<String, dynamic> json) => AuthorNode(
    name: json["name"],
    avatar: json["avatar"] == null ? null : Avatar.fromJson(json["avatar"]),
  );

  Map<String, dynamic> toJson() => {"name": name, "avatar": avatar?.toJson()};
}

class Avatar {
  String? url;
  int? width;
  int? height;

  Avatar({this.url, this.width, this.height});

  factory Avatar.fromJson(Map<String, dynamic> json) =>
      Avatar(url: json["url"], width: json["width"], height: json["height"]);

  Map<String, dynamic> toJson() => {
    "url": url,
    "width": width,
    "height": height,
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
