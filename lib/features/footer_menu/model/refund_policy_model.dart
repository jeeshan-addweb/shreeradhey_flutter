// To parse this JSON data, do
//
//     final refundPolicyModel = refundPolicyModelFromJson(jsonString);

import 'dart:convert';

RefundPolicyModel refundPolicyModelFromJson(String str) =>
    RefundPolicyModel.fromJson(json.decode(str));

String refundPolicyModelToJson(RefundPolicyModel data) =>
    json.encode(data.toJson());

class RefundPolicyModel {
  Data? data;

  RefundPolicyModel({this.data});

  factory RefundPolicyModel.fromJson(Map<String, dynamic> json) =>
      RefundPolicyModel(
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

enum Name { CORE_HEADING, CORE_PARAGRAPH }

final nameValues = EnumValues({
  "core/heading": Name.CORE_HEADING,
  "core/paragraph": Name.CORE_PARAGRAPH,
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
