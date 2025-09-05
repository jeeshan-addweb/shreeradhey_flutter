// To parse this JSON data, do
//
//     final privacyPolicyModel = privacyPolicyModelFromJson(jsonString);

import 'dart:convert';

PrivacyPolicyModel privacyPolicyModelFromJson(String str) =>
    PrivacyPolicyModel.fromJson(json.decode(str));

String privacyPolicyModelToJson(PrivacyPolicyModel data) =>
    json.encode(data.toJson());

class PrivacyPolicyModel {
  Data? data;

  PrivacyPolicyModel({this.data});

  factory PrivacyPolicyModel.fromJson(Map<String, dynamic> json) =>
      PrivacyPolicyModel(
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
