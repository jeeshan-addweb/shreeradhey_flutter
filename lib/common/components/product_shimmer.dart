import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductCardShimmer extends StatelessWidget {
  final double height;
  final double imageHeight;
  const ProductCardShimmer({
    super.key,
    this.height = 300,
    this.imageHeight = 150,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder
            Container(
              height: imageHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8),
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Title placeholder
            Container(
              height: 16,
              width: 120,
              color: Colors.grey[300],
              margin: const EdgeInsets.symmetric(horizontal: 8),
            ),

            const SizedBox(height: 8),

            // Price placeholder
            Container(
              height: 16,
              width: 60,
              color: Colors.grey[300],
              margin: const EdgeInsets.symmetric(horizontal: 8),
            ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
