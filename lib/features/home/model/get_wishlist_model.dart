// To parse this JSON data, do
//
//     final getWishlistModel = getWishlistModelFromJson(jsonString);

import 'dart:convert';

GetWishlistModel getWishlistModelFromJson(String str) =>
    GetWishlistModel.fromJson(json.decode(str));

String getWishlistModelToJson(GetWishlistModel data) =>
    json.encode(data.toJson());

class GetWishlistModel {
  Data? data;

  GetWishlistModel({this.data});

  factory GetWishlistModel.fromJson(Map<String, dynamic> json) =>
      GetWishlistModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"data": data?.toJson()};
}

class Data {
  List<WishlistProduct>? wishlistProducts;

  Data({this.wishlistProducts});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    wishlistProducts:
        json["wishlistProducts"] == null
            ? []
            : List<WishlistProduct>.from(
              json["wishlistProducts"]!.map((x) => WishlistProduct.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "wishlistProducts":
        wishlistProducts == null
            ? []
            : List<dynamic>.from(wishlistProducts!.map((x) => x.toJson())),
  };
}

class WishlistProduct {
  String? id;
  int? databaseId;
  bool? isInCart;
  String? name;
  String? slug;
  String? uri;
  ProductImage? image;
  ProductCategories? productCategories;
  ProductLabels? productLabels;
  String? currencySymbol;
  String? price;
  String? regularPrice;
  String? salePrice;
  String? bestPrice;
  double? discountPercentage;
  double? averageRating;
  int? reviewCount;

  WishlistProduct({
    this.id,
    this.databaseId,
    this.isInCart,
    this.name,
    this.slug,
    this.uri,
    this.image,
    this.productCategories,
    this.productLabels,
    this.currencySymbol,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.bestPrice,
    this.discountPercentage,
    this.averageRating,
    this.reviewCount,
  });

  factory WishlistProduct.fromJson(Map<String, dynamic> json) =>
      WishlistProduct(
        id: json["id"],
        databaseId: json["databaseId"],
        isInCart: json["isInCart"],
        name: json["name"],
        slug: json["slug"],
        uri: json["uri"],
        image:
            json["image"] == null ? null : ProductImage.fromJson(json["image"]),
        productCategories:
            json["productCategories"] == null
                ? null
                : ProductCategories.fromJson(json["productCategories"]),
        productLabels:
            json["productLabels"] == null
                ? null
                : ProductLabels.fromJson(json["productLabels"]),
        currencySymbol: json["currencySymbol"],
        price: json["price"],
        regularPrice: json["regularPrice"],
        salePrice: json["salePrice"],
        bestPrice: json["bestPrice"],
        discountPercentage: json["discountPercentage"]?.toDouble(),
        averageRating: json["averageRating"]?.toDouble(),
        reviewCount: json["reviewCount"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "databaseId": databaseId,
    "isInCart": isInCart,
    "name": name,
    "slug": slug,
    "uri": uri,
    "image": image?.toJson(),
    "productCategories": productCategories?.toJson(),
    "productLabels": productLabels?.toJson(),
    "currencySymbol": currencySymbol,
    "price": price,
    "regularPrice": regularPrice,
    "salePrice": salePrice,
    "bestPrice": bestPrice,
    "discountPercentage": discountPercentage,
    "averageRating": averageRating,
    "reviewCount": reviewCount,
  };
}

class ProductImage {
  String? sourceUrl;
  String? altText;

  ProductImage({this.sourceUrl, this.altText});

  factory ProductImage.fromJson(Map<String, dynamic> json) =>
      ProductImage(sourceUrl: json["sourceUrl"], altText: json["altText"]);

  Map<String, dynamic> toJson() => {"sourceUrl": sourceUrl, "altText": altText};
}

class ProductCategories {
  List<ProductCategoriesNode>? nodes;

  ProductCategories({this.nodes});

  factory ProductCategories.fromJson(Map<String, dynamic> json) =>
      ProductCategories(
        nodes:
            json["nodes"] == null
                ? []
                : List<ProductCategoriesNode>.from(
                  json["nodes"]!.map((x) => ProductCategoriesNode.fromJson(x)),
                ),
      );

  Map<String, dynamic> toJson() => {
    "nodes":
        nodes == null ? [] : List<dynamic>.from(nodes!.map((x) => x.toJson())),
  };
}

class ProductCategoriesNode {
  String? name;
  String? slug;

  ProductCategoriesNode({this.name, this.slug});

  factory ProductCategoriesNode.fromJson(Map<String, dynamic> json) =>
      ProductCategoriesNode(name: json["name"], slug: json["slug"]);

  Map<String, dynamic> toJson() => {"name": name, "slug": slug};
}

class ProductLabels {
  List<ProductLabelsNode>? nodes;

  ProductLabels({this.nodes});

  factory ProductLabels.fromJson(Map<String, dynamic> json) => ProductLabels(
    nodes:
        json["nodes"] == null
            ? []
            : List<ProductLabelsNode>.from(
              json["nodes"]!.map((x) => ProductLabelsNode.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "nodes":
        nodes == null ? [] : List<dynamic>.from(nodes!.map((x) => x.toJson())),
  };
}

class ProductLabelsNode {
  String? id;
  String? name;
  String? slug;

  ProductLabelsNode({this.id, this.name, this.slug});

  factory ProductLabelsNode.fromJson(Map<String, dynamic> json) =>
      ProductLabelsNode(id: json["id"], name: json["name"], slug: json["slug"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name, "slug": slug};
}
