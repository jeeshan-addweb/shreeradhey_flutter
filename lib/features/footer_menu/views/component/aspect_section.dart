import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import 'common_aspect_item.dart';

class AspectsSection extends StatelessWidget {
  final String title;
  final List<Map<String, String>> aspects;

  const AspectsSection({super.key, required this.title, required this.aspects});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.grey_65758b,
          ),
        ),
        const SizedBox(height: 16),
        Column(
          children:
              aspects
                  .map(
                    (aspect) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: CommonAspectItem(
                        imagePath: aspect["icon"]!,
                        label: aspect["text"]!,
                      ),
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }
}
