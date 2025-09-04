// To parse this JSON data, do
//
//     final getBlogModel = getBlogModelFromJson(jsonString);

import 'dart:convert';

GetBlogModel getBlogModelFromJson(String str) =>
    GetBlogModel.fromJson(json.decode(str));

String getBlogModelToJson(GetBlogModel data) => json.encode(data.toJson());

class GetBlogModel {
  Data? data;
  Extensions? extensions;

  GetBlogModel({this.data, this.extensions});

  factory GetBlogModel.fromJson(Map<String, dynamic> json) => GetBlogModel(
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
  Posts? posts;

  Data({this.posts});

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(posts: json["posts"] == null ? null : Posts.fromJson(json["posts"]));

  Map<String, dynamic> toJson() => {"posts": posts?.toJson()};
}

class Posts {
  PageInfo? pageInfo;
  List<NodeElement>? nodes;

  Posts({this.pageInfo, this.nodes});

  factory Posts.fromJson(Map<String, dynamic> json) => Posts(
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
  String? title;
  String? slug;
  String? uri;
  DateTime? date;
  String? excerpt;
  FeaturedImage? featuredImage;

  NodeElement({
    this.id,
    this.title,
    this.slug,
    this.uri,
    this.date,
    this.excerpt,
    this.featuredImage,
  });

  factory NodeElement.fromJson(Map<String, dynamic> json) => NodeElement(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    uri: json["uri"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    excerpt: json["excerpt"],
    featuredImage:
        json["featuredImage"] == null
            ? null
            : FeaturedImage.fromJson(json["featuredImage"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "uri": uri,
    "date": date?.toIso8601String(),
    "excerpt": excerpt,
    "featuredImage": featuredImage?.toJson(),
  };
}

class FeaturedImage {
  FeaturedImageNode? node;

  FeaturedImage({this.node});

  factory FeaturedImage.fromJson(Map<String, dynamic> json) => FeaturedImage(
    node:
        json["node"] == null ? null : FeaturedImageNode.fromJson(json["node"]),
  );

  Map<String, dynamic> toJson() => {"node": node?.toJson()};
}

class FeaturedImageNode {
  String? sourceUrl;
  String? altText;

  FeaturedImageNode({this.sourceUrl, this.altText});

  factory FeaturedImageNode.fromJson(Map<String, dynamic> json) =>
      FeaturedImageNode(sourceUrl: json["sourceUrl"], altText: json["altText"]);

  Map<String, dynamic> toJson() => {"sourceUrl": sourceUrl, "altText": altText};
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
