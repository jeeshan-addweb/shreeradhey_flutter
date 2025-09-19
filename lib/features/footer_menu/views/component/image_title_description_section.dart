import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';

class ImageTitleDescriptionSection extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;

  const ImageTitleDescriptionSection({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    this.titleStyle,
    this.descriptionStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(image, fit: BoxFit.contain),
        const SizedBox(height: 4),
        Text(
          title,
          style:
              titleStyle ??
              TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: AppColors.grey_65758b,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          textAlign: TextAlign.center,
          description,
          style: descriptionStyle ?? const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
