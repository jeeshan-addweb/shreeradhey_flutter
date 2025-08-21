import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';

class CommonAspectItem extends StatelessWidget {
  final String imagePath; // asset path or network url
  final String label;

  const CommonAspectItem({
    super.key,
    required this.imagePath,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(imagePath, height: 100, width: 100, fit: BoxFit.contain),
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
      ],
    );
  }
}
