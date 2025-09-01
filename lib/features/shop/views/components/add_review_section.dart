import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';

class AddReviewSection extends StatefulWidget {
  const AddReviewSection({super.key});

  @override
  State<AddReviewSection> createState() => _AddReviewSectionState();
}

class _AddReviewSectionState extends State<AddReviewSection> {
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

        /// Overall rating
        buildRatingRow("Overall rating *", overallRating, (val) {
          setState(() => overallRating = val);
        }),
        const SizedBox(height: 12),

        /// Product rating
        buildRatingRow("Give us rating our products *", productRating, (val) {
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
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(height: 20),

        /// Submit button
        Align(
          alignment: Alignment.centerLeft,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[700], // Grey background
              foregroundColor: Colors.white, // White text
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              textStyle: const TextStyle(fontSize: 14),
              minimumSize: const Size(80, 36), // Small size
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: const Text("Submit"),
          ),
        ),
      ],
    );
  }
}
