class ClientReview {
  final String name;
  final String date;
  final double rating;
  final String comment;
  final String? profileImage;

  ClientReview({
    required this.name,
    required this.date,
    required this.rating,
    required this.comment,
    this.profileImage,
  });
}
