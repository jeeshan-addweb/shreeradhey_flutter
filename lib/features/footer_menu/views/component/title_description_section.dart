import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';

class TitleDescriptionSection extends StatelessWidget {
  final String title;
  final String description;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;

  const TitleDescriptionSection({
    super.key,
    required this.title,
    required this.description,
    this.titleStyle,
    this.descriptionStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
          description,
          style: descriptionStyle ?? const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
