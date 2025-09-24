import 'package:flutter/material.dart';
import '../../../../constants/app_colors.dart';

class AdditionalInfoWidget extends StatelessWidget {
  final List<Map<String, dynamic>> attributes;

  const AdditionalInfoWidget({super.key, required this.attributes});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: ExpansionTile(
        title: const Text(
          "Additional information",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
        ),
        childrenPadding: const EdgeInsets.all(12),
        children: [
          attributes.isEmpty
              ? Center(
                child: Text("No additional info available for this product"),
              )
              : Table(
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(3),
                },
                border: TableBorder(
                  horizontalInside: BorderSide(
                    color: Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                children:
                    attributes.map((attr) {
                      final key = attr["label"] ?? attr["name"] ?? "";
                      final value =
                          (attr["options"] != null &&
                                  attr["options"].isNotEmpty)
                              ? (attr["options"] as List).join(", ")
                              : "";
                      return _buildTableRow(key, value);
                    }).toList(),
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
          child: Text(value, style: const TextStyle(fontSize: 16)),
        ),
      ],
    );
  }
}
