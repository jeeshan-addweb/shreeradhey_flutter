class ProductModel {
  final String imageUrl;
  final String title;
  final String subtitle;
  final double rating;
  final int reviewCount;
  final double price;
  final double oldPrice;
  final double couponPrice;
  final String tagText;

  ProductModel({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.reviewCount,
    required this.price,
    required this.oldPrice,
    required this.couponPrice,
    this.tagText = "Best Seller",
  });
  ProductModel copyWith({
    String? imageUrl,
    String? title,
    String? subtitle,
    double? price,
    double? oldPrice,
    double? couponPrice,
    double? rating,
    int? reviewCount,
    String? tagText,
  }) {
    return ProductModel(
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      price: price ?? this.price,
      oldPrice: oldPrice ?? this.oldPrice,
      couponPrice: couponPrice ?? this.couponPrice,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      tagText: tagText ?? this.tagText,
    );
  }
}
