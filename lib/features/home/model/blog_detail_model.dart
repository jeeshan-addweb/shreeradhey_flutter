// To parse this JSON data, do
//
//     final blogDetailModel = blogDetailModelFromJson(jsonString);

import 'dart:convert';

BlogDetailModel blogDetailModelFromJson(String str) =>
    BlogDetailModel.fromJson(json.decode(str));

String blogDetailModelToJson(BlogDetailModel data) =>
    json.encode(data.toJson());

class BlogDetailModel {
  Data? data;

  BlogDetailModel({this.data});

  factory BlogDetailModel.fromJson(Map<String, dynamic> json) =>
      BlogDetailModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"data": data?.toJson()};
}

class Data {
  Post? post;

  Data({this.post});

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(post: json["post"] == null ? null : Post.fromJson(json["post"]));

  Map<String, dynamic> toJson() => {"post": post?.toJson()};
}

class Post {
  String? id;
  int? databaseId;
  String? title;
  String? content;
  DateTime? date;
  String? excerpt;
  String? uri;
  Author? author;
  FeaturedImage? featuredImage;
  Categories? categories;
  Categories? tags;

  Post({
    this.id,
    this.databaseId,
    this.title,
    this.content,
    this.date,
    this.excerpt,
    this.uri,
    this.author,
    this.featuredImage,
    this.categories,
    this.tags,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["id"],
    databaseId: json["databaseId"],
    title: json["title"],
    content: json["content"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    excerpt: json["excerpt"],
    uri: json["uri"],
    author: json["author"] == null ? null : Author.fromJson(json["author"]),
    featuredImage:
        json["featuredImage"] == null
            ? null
            : FeaturedImage.fromJson(json["featuredImage"]),
    categories:
        json["categories"] == null
            ? null
            : Categories.fromJson(json["categories"]),
    tags: json["tags"] == null ? null : Categories.fromJson(json["tags"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "databaseId": databaseId,
    "title": title,
    "content": content,
    "date": date?.toIso8601String(),
    "excerpt": excerpt,
    "uri": uri,
    "author": author?.toJson(),
    "featuredImage": featuredImage?.toJson(),
    "categories": categories?.toJson(),
    "tags": tags?.toJson(),
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

  Avatar({this.url});

  factory Avatar.fromJson(Map<String, dynamic> json) =>
      Avatar(url: json["url"]);

  Map<String, dynamic> toJson() => {"url": url};
}

class Categories {
  List<BlogDetailNodeElement>? nodes;

  Categories({this.nodes});

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
    nodes:
        json["nodes"] == null
            ? []
            : List<BlogDetailNodeElement>.from(
              json["nodes"]!.map((x) => BlogDetailNodeElement.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "nodes":
        nodes == null ? [] : List<dynamic>.from(nodes!.map((x) => x.toJson())),
  };
}

class BlogDetailNodeElement {
  String? name;
  String? slug;

  BlogDetailNodeElement({this.name, this.slug});

  factory BlogDetailNodeElement.fromJson(Map<String, dynamic> json) =>
      BlogDetailNodeElement(name: json["name"], slug: json["slug"]);

  Map<String, dynamic> toJson() => {"name": name, "slug": slug};
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
