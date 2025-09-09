import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart' as html_parser;
import '../../../../common/model/amazon_review_model.dart';
import '../../../../constants/app_colors.dart';

class ReviewCard extends StatefulWidget {
  final AmazonReview review;

  const ReviewCard({super.key, required this.review});

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> with TickerProviderStateMixin {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final reviewText = widget.review.text ?? "";

    // ✅ Strip HTML tags just to calculate plain length
    final plainText = html_parser.parse(reviewText).body?.text ?? "";
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.grey.withOpacity(0.4),
                  backgroundImage:
                      widget.review.userPhoto != null
                          ? NetworkImage(widget.review.userPhoto!)
                          : null,
                  radius: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.review.user ?? "Anonymous",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      if (widget.review.date != null)
                        Text(
                          "${widget.review.date!.day}/${widget.review.date!.month}/${widget.review.date!.year}",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Rating
            Row(
              children: List.generate(
                widget.review.rating ?? 0,
                (index) =>
                    const Icon(Icons.star, color: Colors.amber, size: 20),
              ),
            ),
            const SizedBox(height: 8),

            // Review Text
            Html(
              data: reviewText,
              style: {
                "body": Style(
                  margin: Margins.zero,
                  padding: HtmlPaddings.zero,
                  fontSize: FontSize(14),
                  maxLines: isExpanded ? null : 3,
                  textOverflow:
                      isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                ),
              },
            ),

            if (plainText.length > 120)
              GestureDetector(
                onTap: () => setState(() => isExpanded = !isExpanded),
                child: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    isExpanded ? "Hide" : "Read more",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: AppColors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
