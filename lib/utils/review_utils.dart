import '../features/shop/models/product_detail_model.dart';
import '../features/shop/views/components/product_detail_review_section.dart';

Map<int, double> buildRatingDistribution(List<RatingBreakdown>? breakdown) {
  if (breakdown == null || breakdown.isEmpty) return {};

  // Get total reviews count
  int totalReviews = breakdown.fold(0, (sum, item) => sum + (item.count ?? 0));

  if (totalReviews == 0) return {};

  // Build percentage map
  return {
    for (var item in breakdown)
      item.star ?? 0: (item.count ?? 0) / totalReviews,
  };
}

List<ReviewsNode> buildReviews(List<ReviewsNode>? reviews) {
  if (reviews == null || reviews.isEmpty) return [];
  return reviews;
}
