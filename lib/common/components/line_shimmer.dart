import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LineShimmer extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;

  const LineShimmer({
    super.key,
    this.height = 20,
    this.width = double.infinity,
    this.borderRadius = 6,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
