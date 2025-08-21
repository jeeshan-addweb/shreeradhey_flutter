class BlogModel {
  final String imagePath;
  final String title;
  final String description;
  final String? writerName;
  final String? date;
  final String? readTime;

  BlogModel({
    required this.imagePath,
    required this.title,
    required this.description,
    this.writerName,
    this.date,
    this.readTime,
  });
}
