// To parse this JSON data, do
//
//     final termsConditionModel = termsConditionModelFromJson(jsonString);

import 'dart:convert';

TermsConditionModel termsConditionModelFromJson(String str) =>
    TermsConditionModel.fromJson(json.decode(str));

String termsConditionModelToJson(TermsConditionModel data) =>
    json.encode(data.toJson());

class TermsConditionModel {
  Data? data;

  TermsConditionModel({this.data});

  factory TermsConditionModel.fromJson(Map<String, dynamic> json) =>
      TermsConditionModel(
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
  String? name;
  String? content;

  Block({this.name, this.content});

  factory Block.fromJson(Map<String, dynamic> json) =>
      Block(name: json["name"], content: json["content"]);

  Map<String, dynamic> toJson() => {"name": name, "content": content};
}
