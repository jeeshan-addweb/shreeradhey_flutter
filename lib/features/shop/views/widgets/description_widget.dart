import 'package:flutter/material.dart';

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
              _BulletPoint(text: "Made from 100% organic ingredients"),
              _BulletPoint(text: "No preservatives or artificial flavors"),
              _BulletPoint(text: "Rich in vitamins and minerals"),
              _BulletPoint(text: "Ideal for daily use"),
            ],
          ),
        ),
      ],
    ),
  );
}

class _BulletPoint extends StatelessWidget {
  final String text;
  const _BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "• ",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
