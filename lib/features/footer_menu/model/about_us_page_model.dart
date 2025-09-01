// To parse this JSON data, do
//
//     final aboutUsPageModel = aboutUsPageModelFromJson(jsonString);

import 'dart:convert';

AboutUsPageModel aboutUsPageModelFromJson(String str) =>
    AboutUsPageModel.fromJson(json.decode(str));

String aboutUsPageModelToJson(AboutUsPageModel data) =>
    json.encode(data.toJson());

class AboutUsPageModel {
  Data? data;
  Extensions? extensions;

  AboutUsPageModel({this.data, this.extensions});

  factory AboutUsPageModel.fromJson(Map<String, dynamic> json) =>
      AboutUsPageModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        extensions:
            json["extensions"] == null
                ? null
                : Extensions.fromJson(json["extensions"]),
      );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "extensions": extensions?.toJson(),
  };
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

class Extensions {
  List<dynamic>? debug;
  QueryAnalyzer? queryAnalyzer;

  Extensions({this.debug, this.queryAnalyzer});

  factory Extensions.fromJson(Map<String, dynamic> json) => Extensions(
    debug:
        json["debug"] == null
            ? []
            : List<dynamic>.from(json["debug"]!.map((x) => x)),
    queryAnalyzer:
        json["queryAnalyzer"] == null
            ? null
            : QueryAnalyzer.fromJson(json["queryAnalyzer"]),
  );

  Map<String, dynamic> toJson() => {
    "debug": debug == null ? [] : List<dynamic>.from(debug!.map((x) => x)),
    "queryAnalyzer": queryAnalyzer?.toJson(),
  };
}

class QueryAnalyzer {
  String? keys;
  int? keysLength;
  int? keysCount;
  String? skippedKeys;
  int? skippedKeysSize;
  int? skippedKeysCount;
  List<dynamic>? skippedTypes;

  QueryAnalyzer({
    this.keys,
    this.keysLength,
    this.keysCount,
    this.skippedKeys,
    this.skippedKeysSize,
    this.skippedKeysCount,
    this.skippedTypes,
  });

  factory QueryAnalyzer.fromJson(Map<String, dynamic> json) => QueryAnalyzer(
    keys: json["keys"],
    keysLength: json["keysLength"],
    keysCount: json["keysCount"],
    skippedKeys: json["skippedKeys"],
    skippedKeysSize: json["skippedKeysSize"],
    skippedKeysCount: json["skippedKeysCount"],
    skippedTypes:
        json["skippedTypes"] == null
            ? []
            : List<dynamic>.from(json["skippedTypes"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "keys": keys,
    "keysLength": keysLength,
    "keysCount": keysCount,
    "skippedKeys": skippedKeys,
    "skippedKeysSize": skippedKeysSize,
    "skippedKeysCount": skippedKeysCount,
    "skippedTypes":
        skippedTypes == null
            ? []
            : List<dynamic>.from(skippedTypes!.map((x) => x)),
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
