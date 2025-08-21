import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_images.dart';

class ProductDetailReviewSection extends StatelessWidget {
  final double averageRating;
  final int totalReviews;
  final Map<int, double> ratingDistribution; // {5: 0.66, 4: 0.33, ...}
  final List<ReviewModel> reviews;

  const ProductDetailReviewSection({
    super.key,
    required this.averageRating,
    required this.totalReviews,
    required this.ratingDistribution,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Ratings Summary
        Container(
          color: AppColors.white_f9f9f9,
          // elevation: 2,
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  averageRating.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                _buildStars(averageRating),
                const SizedBox(height: 4),
                Text("Based on $totalReviews reviews"),
                const SizedBox(height: 16),
                Column(
                  children:
                      ratingDistribution.entries.map((entry) {
                        return _buildRatingBar(entry.key, entry.value);
                      }).toList(),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Review List
        ...reviews.map((review) => _buildReviewCard(review)),
      ],
    );
  }

  Widget _buildStars(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating.round() ? Icons.star : Icons.star_border,
          color: AppColors.yellow_FFBC00,
          size: 20,
        );
      }),
    );
  }

  Widget _buildRatingBar(int star, double percentage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text("$star star"),
          const SizedBox(width: 8),
          Expanded(
            child: LinearProgressIndicator(
              minHeight: 15,
              value: percentage,
              backgroundColor: Colors.grey[300],
              color: AppColors.yellow_FFBC00,
            ),
          ),
          const SizedBox(width: 8),
          Text("${(percentage * 100).toStringAsFixed(0)}%"),
        ],
      ),
    );
  }

  Widget _buildReviewCard(ReviewModel review) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey_94a3b8),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.grey_e2e8f0,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.grey.withOpacity(0.1),
                ),
                child: Image.asset(AppImages.person, height: 50, width: 50),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          review.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.red_CC0003,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "-${review.date}",
                          style: TextStyle(
                            color: AppColors.grey_212121,
                            fontSize: 16,
                          ),
                        ),
                        if (review.verified) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.red_CC0003,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              "VERIFIED",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              review.comment,
              style: TextStyle(color: AppColors.grey_212121),
            ),
            const SizedBox(height: 4),
            _buildStars(review.rating),
          ],
        ),
      ),
    );
  }
}

class ReviewModel {
  final String name;
  final String date;
  final bool verified;
  final String comment;
  final double rating;

  ReviewModel({
    required this.name,
    required this.date,
    required this.verified,
    required this.comment,
    required this.rating,
  });
}
