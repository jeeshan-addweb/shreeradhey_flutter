import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';

class VariantCard extends StatelessWidget {
  final String variantName;
  final double originalPrice;
  final double discountedPrice;
  final int discountPercent;
  final bool isSelected;
  final VoidCallback onTap;

  const VariantCard({
    Key? key,
    required this.variantName,
    required this.originalPrice,
    required this.discountedPrice,
    required this.discountPercent,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? const Color(0xFF327801) : AppColors.grey_e2e8f0,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top section with gradient or solid bg
            Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
                gradient:
                    isSelected
                        ? LinearGradient(
                          colors: [
                            AppColors.green_6cad10,
                            AppColors.green_327801,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                        : LinearGradient(
                          colors: [
                            AppColors.blue_eef1ed,
                            AppColors.blue_eef1ed,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
              ),
              alignment: Alignment.center,
              child: Text(
                variantName,
                style: TextStyle(
                  fontSize: 16,
                  color: isSelected ? Colors.white : AppColors.grey_212121,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            // Price section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "\$${discountedPrice.toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.grey_212121,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "\$${originalPrice.toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.grey_212121,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const SizedBox(width: 6),
                      ],
                    ),
                    Text(
                      "($discountPercent%)",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey_65758b,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
