import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';

Widget buildOfferCard(String offerText, String couponCode) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: Container(
      decoration: BoxDecoration(color: AppColors.pink_fffced),

      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              offerText,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Container(
              // width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(6),
                color: Colors.white,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    couponCode,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.copy_sharp, size: 16, color: Colors.green),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
