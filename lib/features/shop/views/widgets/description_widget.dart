import 'package:flutter/material.dart';

import '../../../../common/components/bullet_point.dart';
import '../../../../constants/app_colors.dart';

Widget descriptionWidget() {
  return Card(
    color: AppColors.white,
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    child: ExpansionTile(
      title: Text(
        "Description",
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
      ),
      childrenPadding: const EdgeInsets.all(12),
      children: [
        Container(
          color: AppColors.blue_eef1ed,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              BulletPoint(text: "Made from 100% organic ingredients"),
              BulletPoint(text: "No preservatives or artificial flavors"),
              BulletPoint(text: "Rich in vitamins and minerals"),
              BulletPoint(text: "Ideal for daily use"),
            ],
          ),
        ),
      ],
    ),
  );
}
