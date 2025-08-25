import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';

class AboutUsInfoListSection extends StatelessWidget {
  final List<AboutUsInfoItem> items;

  const AboutUsInfoListSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          items.map((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon
                  Image.asset(
                    item.iconPath,
                    width: 50,
                    height: 50,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 8),

                  // Title
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Description
                  Text(
                    item.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.grey_212121,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }
}

class AboutUsInfoItem {
  final String iconPath;
  final String title;
  final String description;

  AboutUsInfoItem({
    required this.iconPath,
    required this.title,
    required this.description,
  });
}
