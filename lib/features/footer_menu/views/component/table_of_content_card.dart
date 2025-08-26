import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';

class TableOfContentCard extends StatelessWidget {
  final List<String> contents;
  final Function(int) onItemTap; // callback when tapped

  const TableOfContentCard({
    super.key,
    required this.contents,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.25,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Table of Content",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: contents.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => onItemTap(index),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.comment, size: 12),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                contents[index],
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                                softWrap: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
