import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';

Widget additionalInfoWidget() {
  return Card(
    color: AppColors.white,
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    child: ExpansionTile(
      title: Text(
        "Additional information",
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
      ),
      childrenPadding: const EdgeInsets.all(12),
      children: [
        Table(
          columnWidths: const {0: FlexColumnWidth(2), 1: FlexColumnWidth(3)},
          border: TableBorder(
            horizontalInside: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          children: [
            _buildTableRow("Cuisine", "Indian"),
            _buildTableRow(
              "Serving Recommendation",
              "Please serve with hot items",
            ),
            _buildTableRow("Country Of Origin", "India"),
          ],
        ),
      ],
    ),
  );
}

/// --- Table Row Builder ---
TableRow _buildTableRow(String key, String value) {
  return TableRow(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          key,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(value, style: TextStyle(fontSize: 16)),
      ),
    ],
  );
}
