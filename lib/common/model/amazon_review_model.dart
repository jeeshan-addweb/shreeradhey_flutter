// To parse this JSON data, do
//
//     final amazonReviewModel = amazonReviewModelFromJson(jsonString);

import 'dart:convert';

AmazonReviewModel amazonReviewModelFromJson(String str) =>
    AmazonReviewModel.fromJson(json.decode(str));

String amazonReviewModelToJson(AmazonReviewModel data) =>
    json.encode(data.toJson());

class AmazonReviewModel {
  Data? data;

  AmazonReviewModel({this.data});

  factory AmazonReviewModel.fromJson(Map<String, dynamic> json) =>
      AmazonReviewModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"data": data?.toJson()};
}

class Data {
  List<AmazonReview>? amazonReviews;

  Data({this.amazonReviews});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    amazonReviews:
        json["amazonReviews"] == null
            ? []
            : List<AmazonReview>.from(
              json["amazonReviews"]!.map((x) => AmazonReview.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "amazonReviews":
        amazonReviews == null
            ? []
            : List<dynamic>.from(amazonReviews!.map((x) => x.toJson())),
  };
}

class AmazonReview {
  String? id;
  String? user;
  String? userPhoto;
  String? text;
  int? rating;
  int? originalRating;
  DateTime? date;

  AmazonReview({
    this.id,
    this.user,
    this.userPhoto,
    this.text,
    this.rating,
    this.originalRating,
    this.date,
  });

  factory AmazonReview.fromJson(Map<String, dynamic> json) => AmazonReview(
    id: json["id"],
    user: json["user"],
    userPhoto: json["user_photo"],
    text: json["text"],
    rating: json["rating"],
    originalRating: json["original_rating"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user,
    "user_photo": userPhoto,
    "text": text,
    "rating": rating,
    "original_rating": originalRating,
    "date":
        "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
  };
}
