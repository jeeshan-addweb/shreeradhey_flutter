import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';

class CustomTableOfContent extends StatelessWidget {
  final List<String> contents;
  final Function(int index)? onItemTap;

  const CustomTableOfContent({
    super.key,
    required this.contents,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      margin: const EdgeInsets.all(12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Table of Contents",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            ...List.generate(contents.length, (index) {
              return InkWell(
                onTap: () => onItemTap?.call(index),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_right, size: 20),
                      Expanded(
                        child: Text(
                          contents[index],
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
