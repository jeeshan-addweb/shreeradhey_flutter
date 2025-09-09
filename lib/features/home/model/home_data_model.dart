// To parse this JSON data, do
//
//     final homeDataModel = homeDataModelFromJson(jsonString);

import 'dart:convert';

HomeDataModel homeDataModelFromJson(String str) =>
    HomeDataModel.fromJson(json.decode(str));

String homeDataModelToJson(HomeDataModel data) => json.encode(data.toJson());

class HomeDataModel {
  Data? data;

  HomeDataModel({this.data});

  factory HomeDataModel.fromJson(Map<String, dynamic> json) => HomeDataModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {"data": data?.toJson()};
}

class Data {
  List<BannerImage>? bannerImages;
  List<Commitment>? commitment;
  List<Commitment>? psaOptions;
  SpecialOffer? specialOffer;
  String? blogCtaTitle;

  Data({
    this.bannerImages,
    this.commitment,
    this.psaOptions,
    this.specialOffer,
    this.blogCtaTitle,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    bannerImages:
        json["bannerImages"] == null
            ? []
            : List<BannerImage>.from(
              json["bannerImages"]!.map((x) => BannerImage.fromJson(x)),
            ),
    commitment:
        json["commitment"] == null
            ? []
            : List<Commitment>.from(
              json["commitment"]!.map((x) => Commitment.fromJson(x)),
            ),
    psaOptions:
        json["psaOptions"] == null
            ? []
            : List<Commitment>.from(
              json["psaOptions"]!.map((x) => Commitment.fromJson(x)),
            ),
    specialOffer:
        json["specialOffer"] == null
            ? null
            : SpecialOffer.fromJson(json["specialOffer"]),
    blogCtaTitle: json["blogCtaTitle"],
  );

  Map<String, dynamic> toJson() => {
    "bannerImages":
        bannerImages == null
            ? []
            : List<dynamic>.from(bannerImages!.map((x) => x.toJson())),
    "commitment":
        commitment == null
            ? []
            : List<dynamic>.from(commitment!.map((x) => x.toJson())),
    "psaOptions":
        psaOptions == null
            ? []
            : List<dynamic>.from(psaOptions!.map((x) => x.toJson())),
    "specialOffer": specialOffer?.toJson(),
    "blogCtaTitle": blogCtaTitle,
  };
}

class BannerImage {
  String? image;

  BannerImage({this.image});

  factory BannerImage.fromJson(Map<String, dynamic> json) =>
      BannerImage(image: json["image"]);

  Map<String, dynamic> toJson() => {"image": image};
}

class Commitment {
  String? title;
  String? text;
  String? image;

  Commitment({this.title, this.text, this.image});

  factory Commitment.fromJson(Map<String, dynamic> json) => Commitment(
    title: json["title"],
    text: json["text"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "text": text,
    "image": image,
  };
}

class SpecialOffer {
  String? title;
  String? subtitle;
  String? productName;
  String? productUrl;
  String? image;

  SpecialOffer({
    this.title,
    this.subtitle,
    this.productName,
    this.productUrl,
    this.image,
  });

  factory SpecialOffer.fromJson(Map<String, dynamic> json) => SpecialOffer(
    title: json["title"],
    subtitle: json["subtitle"],
    productName: json["product_name"],
    productUrl: json["product_url"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "subtitle": subtitle,
    "product_name": productName,
    "product_url": productUrl,
    "image": image,
  };
}
