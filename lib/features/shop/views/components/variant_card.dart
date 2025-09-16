import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';

class VariantCard extends StatelessWidget {
  final String variantName;
  final String originalPrice;
  final String discountedPrice;
  final double discountPercent;
  final bool isSelected;
  final VoidCallback onTap;
  final String currencySymbol;

  const VariantCard({
    Key? key,
    required this.variantName,
    required this.originalPrice,
    required this.discountedPrice,
    required this.discountPercent,
    required this.isSelected,
    required this.onTap,
    required this.currencySymbol,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.green_6cad10 : AppColors.grey_e2e8f0,
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
                maxLines: 1,
                overflow: TextOverflow.ellipsis, // 👈 add "..." if too long
                textAlign: TextAlign.center, // 👈 center align inside the box
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
                          "$currencySymbol${discountedPrice}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.grey_212121,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "$currencySymbol${originalPrice}",
                          style: TextStyle(
                            fontSize: 14,
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
