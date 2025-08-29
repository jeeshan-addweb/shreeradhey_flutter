// To parse this JSON data, do
//
//     final productDetailModel = productDetailModelFromJson(jsonString);

import 'dart:convert';

ProductDetailModel productDetailModelFromJson(String str) =>
    ProductDetailModel.fromJson(json.decode(str));

String productDetailModelToJson(ProductDetailModel data) =>
    json.encode(data.toJson());

class ProductDetailModel {
  Data? data;

  ProductDetailModel({this.data});

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailModel(
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
  String? id;
  int? databaseId;
  String? name;
  String? slug;
  String? description;
  String? shortDescription;
  String? type;
  String? productSubtitle;
  String? price;
  String? regularPrice;
  String? salePrice;
  String? bestPrice;
  String? stockStatus;
  double? discountPercentage;
  double? averageRating;
  int? reviewCount;
  dynamic totalSales;
  String? sku;
  dynamic dateOnSaleFrom;
  dynamic dateOnSaleTo;
  bool? downloadable;
  bool? virtual;
  bool? featured;
  dynamic weight;
  List<FaqContent>? faqContent;
  List<RatingBreakdown>? ratingBreakdown;
  ImageElement? image;
  GalleryImages? galleryImages;
  dynamic attributes;
  ProductCategories? productCategories;
  Reviews? reviews;
  Related? related;

  Product({
    this.id,
    this.databaseId,
    this.name,
    this.slug,
    this.description,
    this.shortDescription,
    this.type,
    this.productSubtitle,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.bestPrice,
    this.stockStatus,
    this.discountPercentage,
    this.averageRating,
    this.reviewCount,
    this.totalSales,
    this.sku,
    this.dateOnSaleFrom,
    this.dateOnSaleTo,
    this.downloadable,
    this.virtual,
    this.featured,
    this.weight,
    this.faqContent,
    this.ratingBreakdown,
    this.image,
    this.galleryImages,
    this.attributes,
    this.productCategories,
    this.reviews,
    this.related,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    databaseId: json["databaseId"],
    name: json["name"],
    slug: json["slug"],
    description: json["description"],
    shortDescription: json["shortDescription"],
    type: json["type"],
    productSubtitle: json["productSubtitle"],
    price: json["price"],
    regularPrice: json["regularPrice"],
    salePrice: json["salePrice"],
    bestPrice: json["bestPrice"],
    stockStatus: json["stockStatus"],
    discountPercentage: json["discountPercentage"]?.toDouble(),
    averageRating: json["averageRating"]?.toDouble(),
    reviewCount: json["reviewCount"],
    totalSales: json["totalSales"],
    sku: json["sku"],
    dateOnSaleFrom: json["dateOnSaleFrom"],
    dateOnSaleTo: json["dateOnSaleTo"],
    downloadable: json["downloadable"],
    virtual: json["virtual"],
    featured: json["featured"],
    weight: json["weight"],
    faqContent:
        json["faqContent"] == null
            ? []
            : List<FaqContent>.from(
              json["faqContent"]!.map((x) => FaqContent.fromJson(x)),
            ),
    ratingBreakdown:
        json["ratingBreakdown"] == null
            ? []
            : List<RatingBreakdown>.from(
              json["ratingBreakdown"]!.map((x) => RatingBreakdown.fromJson(x)),
            ),
    image: json["image"] == null ? null : ImageElement.fromJson(json["image"]),
    galleryImages:
        json["galleryImages"] == null
            ? null
            : GalleryImages.fromJson(json["galleryImages"]),
    attributes: json["attributes"],
    productCategories:
        json["productCategories"] == null
            ? null
            : ProductCategories.fromJson(json["productCategories"]),
    reviews: json["reviews"] == null ? null : Reviews.fromJson(json["reviews"]),
    related: json["related"] == null ? null : Related.fromJson(json["related"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "databaseId": databaseId,
    "name": name,
    "slug": slug,
    "description": description,
    "shortDescription": shortDescription,
    "type": type,
    "productSubtitle": productSubtitle,
    "price": price,
    "regularPrice": regularPrice,
    "salePrice": salePrice,
    "bestPrice": bestPrice,
    "stockStatus": stockStatus,
    "discountPercentage": discountPercentage,
    "averageRating": averageRating,
    "reviewCount": reviewCount,
    "totalSales": totalSales,
    "sku": sku,
    "dateOnSaleFrom": dateOnSaleFrom,
    "dateOnSaleTo": dateOnSaleTo,
    "downloadable": downloadable,
    "virtual": virtual,
    "featured": featured,
    "weight": weight,
    "faqContent":
        faqContent == null
            ? []
            : List<dynamic>.from(faqContent!.map((x) => x.toJson())),
    "ratingBreakdown":
        ratingBreakdown == null
            ? []
            : List<dynamic>.from(ratingBreakdown!.map((x) => x.toJson())),
    "image": image?.toJson(),
    "galleryImages": galleryImages?.toJson(),
    "attributes": attributes,
    "productCategories": productCategories?.toJson(),
    "reviews": reviews?.toJson(),
    "related": related?.toJson(),
  };
}

class FaqContent {
  String? question;
  String? answer;

  FaqContent({this.question, this.answer});

  factory FaqContent.fromJson(Map<String, dynamic> json) =>
      FaqContent(question: json["question"], answer: json["answer"]);

  Map<String, dynamic> toJson() => {"question": question, "answer": answer};
}

class GalleryImages {
  List<ImageElement>? nodes;

  GalleryImages({this.nodes});

  factory GalleryImages.fromJson(Map<String, dynamic> json) => GalleryImages(
    nodes:
        json["nodes"] == null
            ? []
            : List<ImageElement>.from(
              json["nodes"]!.map((x) => ImageElement.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "nodes":
        nodes == null ? [] : List<dynamic>.from(nodes!.map((x) => x.toJson())),
  };
}

class ImageElement {
  String? sourceUrl;
  String? altText;

  ImageElement({this.sourceUrl, this.altText});

  factory ImageElement.fromJson(Map<String, dynamic> json) =>
      ImageElement(sourceUrl: json["sourceUrl"], altText: json["altText"]);

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

class RatingBreakdown {
  int? count;
  int? percentage;
  int? star;

  RatingBreakdown({this.count, this.percentage, this.star});

  factory RatingBreakdown.fromJson(Map<String, dynamic> json) =>
      RatingBreakdown(
        count: json["count"],
        percentage: json["percentage"],
        star: json["star"],
      );

  Map<String, dynamic> toJson() => {
    "count": count,
    "percentage": percentage,
    "star": star,
  };
}

class Related {
  List<RelatedNode>? nodes;

  Related({this.nodes});

  factory Related.fromJson(Map<String, dynamic> json) => Related(
    nodes:
        json["nodes"] == null
            ? []
            : List<RelatedNode>.from(
              json["nodes"]!.map((x) => RelatedNode.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "nodes":
        nodes == null ? [] : List<dynamic>.from(nodes!.map((x) => x.toJson())),
  };
}

class RelatedNode {
  String? id;
  String? name;
  String? slug;
  String? price;
  NodeImage? image;

  RelatedNode({this.id, this.name, this.slug, this.price, this.image});

  factory RelatedNode.fromJson(Map<String, dynamic> json) => RelatedNode(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    price: json["price"],
    image: json["image"] == null ? null : NodeImage.fromJson(json["image"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "price": price,
    "image": image?.toJson(),
  };
}

class NodeImage {
  String? sourceUrl;

  NodeImage({this.sourceUrl});

  factory NodeImage.fromJson(Map<String, dynamic> json) =>
      NodeImage(sourceUrl: json["sourceUrl"]);

  Map<String, dynamic> toJson() => {"sourceUrl": sourceUrl};
}

class Reviews {
  List<ReviewsNode>? nodes;

  Reviews({this.nodes});

  factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
    nodes:
        json["nodes"] == null
            ? []
            : List<ReviewsNode>.from(
              json["nodes"]!.map((x) => ReviewsNode.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "nodes":
        nodes == null ? [] : List<dynamic>.from(nodes!.map((x) => x.toJson())),
  };
}

class ReviewsNode {
  String? id;
  String? content;
  DateTime? date;
  int? rating;
  Author? author;

  ReviewsNode({this.id, this.content, this.date, this.rating, this.author});

  factory ReviewsNode.fromJson(Map<String, dynamic> json) => ReviewsNode(
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
