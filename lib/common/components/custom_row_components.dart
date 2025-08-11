import '../../constants/app_colors.dart';
import 'package:flutter/material.dart';

class RowImageText extends StatelessWidget {
  final String assetPath;
  final String text;
  final Color? imageColor;
  final Color? textColor;
  final double imageSize;

  const RowImageText({
    super.key,
    required this.assetPath,
    required this.text,
    this.imageColor,
    this.textColor,
    this.imageSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          assetPath,
          width: imageSize,
          height: imageSize,
          color: imageColor ?? AppColors.orange_fe9f43,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(color: textColor ?? Colors.black),
        ),
      ],
    );
  }
}

class RowImageTitleSubtitle extends StatelessWidget {
  final String assetPath;
  final String title;
  final String? subTitle;
  final Color? imageColor;
  final Color? titleColor;
  final double imageSize;

  const RowImageTitleSubtitle({
    super.key,
    required this.assetPath,
    required this.title,
    this.subTitle,
    this.imageColor,
    this.titleColor,
    this.imageSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          assetPath,
          width: imageSize,
          height: imageSize,
          color: imageColor ?? AppColors.orange_fe9f43,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: titleColor ?? Colors.black, fontWeight: FontWeight.bold),
            ),
            if(subTitle != null)
            Text(
              subTitle!,
              style: TextStyle(color: Colors.grey[900]),
            ),
          ],
        ),
      ],
    );
  }
}