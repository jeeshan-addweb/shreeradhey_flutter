// To parse this JSON data, do
//
//     final searchAndFilterBlogModel = searchAndFilterBlogModelFromJson(jsonString);

import 'dart:convert';

SearchAndFilterBlogModel searchAndFilterBlogModelFromJson(String str) =>
    SearchAndFilterBlogModel.fromJson(json.decode(str));

String searchAndFilterBlogModelToJson(SearchAndFilterBlogModel data) =>
    json.encode(data.toJson());

class SearchAndFilterBlogModel {
  Data? data;

  SearchAndFilterBlogModel({this.data});

  factory SearchAndFilterBlogModel.fromJson(Map<String, dynamic> json) =>
      SearchAndFilterBlogModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"data": data?.toJson()};
}

class Data {
  PostsSearch? posts;

  Data({this.posts});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    posts: json["posts"] == null ? null : PostsSearch.fromJson(json["posts"]),
  );

  Map<String, dynamic> toJson() => {"posts": posts?.toJson()};
}

class PostsSearch {
  PageInfoSearch? pageInfo;
  List<PostsNode>? nodes;

  PostsSearch({this.pageInfo, this.nodes});

  factory PostsSearch.fromJson(Map<String, dynamic> json) => PostsSearch(
    pageInfo:
        json["pageInfo"] == null
            ? null
            : PageInfoSearch.fromJson(json["pageInfo"]),
    nodes:
        json["nodes"] == null
            ? []
            : List<PostsNode>.from(
              json["nodes"]!.map((x) => PostsNode.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "pageInfo": pageInfo?.toJson(),
    "nodes":
        nodes == null ? [] : List<dynamic>.from(nodes!.map((x) => x.toJson())),
  };
}

class PostsNode {
  String? id;
  String? title;
  String? slug;
  String? uri;
  DateTime? date;
  String? excerpt;
  FeaturedImage? featuredImage;
  Categories? categories;

  PostsNode({
    this.id,
    this.title,
    this.slug,
    this.uri,
    this.date,
    this.excerpt,
    this.featuredImage,
    this.categories,
  });

  factory PostsNode.fromJson(Map<String, dynamic> json) => PostsNode(
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
    categories:
        json["categories"] == null
            ? null
            : Categories.fromJson(json["categories"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "uri": uri,
    "date": date?.toIso8601String(),
    "excerpt": excerpt,
    "featuredImage": featuredImage?.toJson(),
    "categories": categories?.toJson(),
  };
}

class Categories {
  List<CategoriesNode>? nodes;

  Categories({this.nodes});

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
    nodes:
        json["nodes"] == null
            ? []
            : List<CategoriesNode>.from(
              json["nodes"]!.map((x) => CategoriesNode.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "nodes":
        nodes == null ? [] : List<dynamic>.from(nodes!.map((x) => x.toJson())),
  };
}

class CategoriesNode {
  Id? id;
  Name? name;
  Slug? slug;

  CategoriesNode({this.id, this.name, this.slug});

  factory CategoriesNode.fromJson(Map<String, dynamic> json) => CategoriesNode(
    id: idValues.map[json["id"]]!,
    name: nameValues.map[json["name"]]!,
    slug: slugValues.map[json["slug"]]!,
  );

  Map<String, dynamic> toJson() => {
    "id": idValues.reverse[id],
    "name": nameValues.reverse[name],
    "slug": slugValues.reverse[slug],
  };
}

enum Id { D_G_VYB_TO4_NG }

final idValues = EnumValues({"dGVybTo4Ng==": Id.D_G_VYB_TO4_NG});

enum Name { A2_GHEE }

final nameValues = EnumValues({"A2 Ghee": Name.A2_GHEE});

enum Slug { A2_GHEE }

final slugValues = EnumValues({"a2-ghee": Slug.A2_GHEE});

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

class PageInfoSearch {
  bool? hasNextPage;
  String? endCursor;

  PageInfoSearch({this.hasNextPage, this.endCursor});

  factory PageInfoSearch.fromJson(Map<String, dynamic> json) => PageInfoSearch(
    hasNextPage: json["hasNextPage"],
    endCursor: json["endCursor"],
  );

  Map<String, dynamic> toJson() => {
    "hasNextPage": hasNextPage,
    "endCursor": endCursor,
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
