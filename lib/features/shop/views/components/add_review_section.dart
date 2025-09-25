import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shree_radhey/features/shop/controller/shop_controller.dart';

import '../../../../common/components/custom_snackbar.dart';
import '../../../../constants/app_colors.dart';
import '../../../../utils/routes/app_route_path.dart';
import '../../../auth/controller/auth_controller.dart';

class AddReviewSection extends StatefulWidget {
  final int productId; // Pass productId from detail page

  const AddReviewSection({super.key, required this.productId});

  @override
  State<AddReviewSection> createState() => _AddReviewSectionState();
}

class _AddReviewSectionState extends State<AddReviewSection> {
  final auth = Get.find<AuthController>();
  double overallRating = 0;
  double productRating = 0;
  final TextEditingController reviewController = TextEditingController();

  Widget buildRatingRow(
    String title,
    double rating,
    Function(double) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            ...List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  index < rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 28,
                ),
                onPressed: () {
                  onChanged(index + 1.0);
                },
              );
            }),
            const SizedBox(width: 8),
            Text("${rating.toInt()}/5"),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final shopController = Get.find<ShopController>();
    final auth = Get.find<AuthController>();

    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Add a review",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.red_CC0003,
            ),
          ),
          const SizedBox(height: 16),
          if (auth.isGuest) ...[
            const Text(
              "Login to add review",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 12),
          ] else ...[
            /// Overall rating
            buildRatingRow("Overall rating *", overallRating, (val) {
              setState(() => overallRating = val);
            }),
            const SizedBox(height: 12),

            /// Product rating
            buildRatingRow("Give us rating our products *", productRating, (
              val,
            ) {
              setState(() => productRating = val);
            }),
            const SizedBox(height: 16),

            /// Review text field
            const Text(
              "Your review *",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: reviewController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Write your review here...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),

            /// Submit button
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: () {
                  if (auth.isGuest) {
                    CustomSnackbars.showError(
                      context,
                      "Login Required ! Please login to submit review",
                    );

                    // Navigate to login with go_router
                    context.push(AppRoutePath.login);
                    return;
                  }
                  shopController.isLoading.value
                      ? null
                      : () {
                        if (overallRating == 0) {
                          CustomSnackbars.showError(
                            context,
                            "Please give an overall rating",
                          );
                          return;
                        }
                        if (reviewController.text.trim().isEmpty) {
                          CustomSnackbars.showError(
                            context,
                            "Please write your review",
                          );
                          return;
                        }

                        final userName = "John Doe";
                        final userEmail = "john@example.com";
                        debugPrint(
                          "Product Id is ${widget.productId} and content is ${reviewController.text.trim()} and rating is ${overallRating.toInt()}",
                        );

                        shopController.submitReview(
                          context: context,
                          productId: widget.productId.toString(),
                          author: userName,
                          email: userEmail,
                          content: reviewController.text.trim(),
                          rating: overallRating.toInt(),
                        );

                        // Clear inputs after submit
                        reviewController.clear();
                        setState(() {
                          overallRating = 0;
                          productRating = 0;
                        });
                      };
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  textStyle: const TextStyle(fontSize: 14),
                  minimumSize: const Size(80, 36),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child:
                    shopController.isLoading.value
                        ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                        : const Text("Submit"),
              ),
            ),
          ],
        ],
      );
    });
  }
}
