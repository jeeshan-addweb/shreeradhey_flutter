// To parse this JSON data, do
//
//     final woodPressOilModel = woodPressOilModelFromJson(jsonString);

import 'dart:convert';

WoodPressOilModel woodPressOilModelFromJson(String str) =>
    WoodPressOilModel.fromJson(json.decode(str));

String woodPressOilModelToJson(WoodPressOilModel data) =>
    json.encode(data.toJson());

class WoodPressOilModel {
  Data? data;

  WoodPressOilModel({this.data});

  factory WoodPressOilModel.fromJson(Map<String, dynamic> json) =>
      WoodPressOilModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"data": data?.toJson()};
}

class Data {
  PageBy? pageBy;

  Data({this.pageBy});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    pageBy: json["pageBy"] == null ? null : PageBy.fromJson(json["pageBy"]),
  );

  Map<String, dynamic> toJson() => {"pageBy": pageBy?.toJson()};
}

class PageBy {
  String? title;
  List<Block>? blocks;

  PageBy({this.title, this.blocks});

  factory PageBy.fromJson(Map<String, dynamic> json) => PageBy(
    title: json["title"],
    blocks:
        json["blocks"] == null
            ? []
            : List<Block>.from(json["blocks"]!.map((x) => Block.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "blocks":
        blocks == null
            ? []
            : List<dynamic>.from(blocks!.map((x) => x.toJson())),
  };
}

class Block {
  Name? name;
  String? content;

  Block({this.name, this.content});

  factory Block.fromJson(Map<String, dynamic> json) =>
      Block(name: nameValues.map[json["name"]]!, content: json["content"]);

  Map<String, dynamic> toJson() => {
    "name": nameValues.reverse[name],
    "content": content,
  };
}

enum Name {
  BANNER_IMAGE,
  CERTIFICATE,
  CONTENT,
  FAQ_ANS,
  FAQ_TITLE,
  IMAGE,
  TITLE,
}

final nameValues = EnumValues({
  "banner-image": Name.BANNER_IMAGE,
  "certificate": Name.CERTIFICATE,
  "content": Name.CONTENT,
  "faq-ans": Name.FAQ_ANS,
  "faq-title": Name.FAQ_TITLE,
  "image": Name.IMAGE,
  "title": Name.TITLE,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
