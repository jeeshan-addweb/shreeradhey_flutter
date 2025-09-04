import '../models/api_product_model.dart';
import '../../../common/model/ui_product_model.dart';

extension ApiProductMapper on ProductsNode {
  UiProductModel toUiModel() {
    return UiProductModel(
      imageUrl: image?.sourceUrl ?? "",
      title: name ?? "Untitled",
      subtitle:
          productCategories?.nodes?.isNotEmpty == true
              ? productCategories!.nodes!.first.name.toString()
              : "",
      rating: averageRating ?? 0.0,
      reviewCount: reviewCount ?? 0,
      price: price ?? "0",
      oldPrice: regularPrice ?? "",
      couponPrice: bestPrice ?? "no",
      tagText: discountPercentage != null ? "Best Seller" : "Newly Launch",
      discountPercent: discountPercentage,
      slug: slug,
      productLabels:
          productLabels?.nodes
              ?.map<String>((label) => label.name ?? "")
              .where((name) => name.isNotEmpty)
              .toList() ??
          [],

      currencySymbol: currencySymbol.toString(),
    );
  }
}
