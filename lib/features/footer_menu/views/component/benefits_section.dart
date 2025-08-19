import 'package:flutter/material.dart';

import 'common_benefit_item.dart';

class BenefitsSection extends StatelessWidget {
  final List<Map<String, String>> benefits;

  const BenefitsSection({super.key, required this.benefits});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children:
                benefits
                    .map(
                      (benefit) => CommonBenefitItem(
                        imagePath: benefit["icon"]!,
                        title: benefit["title"]!,
                        description: benefit["desc"]!,
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }
}
