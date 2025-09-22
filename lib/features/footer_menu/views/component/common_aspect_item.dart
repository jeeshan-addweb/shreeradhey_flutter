import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';

class CommonAspectItem extends StatelessWidget {
  final String imagePath; // asset path or network url
  final String label;
  final String description;

  const CommonAspectItem({
    super.key,
    required this.imagePath,
    required this.label,
    this.description = "",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.network(imagePath, height: 100, width: 100, fit: BoxFit.contain),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.grey_65758b,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.grey_65758b,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
