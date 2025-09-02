class UiProductModel {
  final String imageUrl;
  final String title;
  final String subtitle;
  final double rating;
  final int reviewCount;
  final String price;
  final String oldPrice;
  final String couponPrice;
  final String tagText;
  final String? description;
  final double? discountPercent;
  final String? slug;
  final List<String> productLabels; // <-- Added
  final String currencySymbol; // <-- Added

  UiProductModel({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.reviewCount,
    required this.price,
    required this.oldPrice,
    required this.couponPrice,
    this.tagText = "Best Seller",
    this.description,
    this.discountPercent,
    this.slug,
    this.productLabels = const [], // <-- Default empty list
    this.currencySymbol = "", // <-- Default empty string
  });
  UiProductModel copyWith({
    String? imageUrl,
    String? title,
    String? subtitle,
    String? price,
    String? oldPrice,
    String? couponPrice,
    double? rating,
    int? reviewCount,
    String? tagText,
    String? description,
    double? discountPercent,
    String? slug,
    List<String>? productLabels,
    String? currencySymbol,
  }) {
    return UiProductModel(
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      price: price ?? this.price,
      oldPrice: oldPrice ?? this.oldPrice,
      couponPrice: couponPrice ?? this.couponPrice,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      tagText: tagText ?? this.tagText,
      description: description ?? this.description,
      discountPercent: discountPercent ?? this.discountPercent,
      slug: slug ?? this.slug,
      productLabels: productLabels ?? this.productLabels, // ✅ added
      currencySymbol: currencySymbol ?? this.currencySymbol, // ✅ added
    );
  }
}
