import 'package:flutter/material.dart';

import '../../../../common/model/product_model.dart';
import '../../../../constants/app_colors.dart';

Widget buildBetterChoiceSection(ProductModel item, BuildContext context) {
  double cardWidth = MediaQuery.of(context).size.width * 0.95;
  return Container(
    width: cardWidth,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product Image
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            item.imageUrl,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12),

        // Product Info
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item.subtitle,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.star, color: AppColors.orange_f29102, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    "${item.rating}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey_212121,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "| ${item.reviewCount} Reviews",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey_212121,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    "₹${item.price}",
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.blue_2da5f3,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "₹${item.oldPrice}",
                    style: const TextStyle(
                      fontSize: 14,

                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(width: 6),
                ],
              ),
              Text(
                "(${item.discountPercent?.toStringAsFixed(0)}%)",
                style: TextStyle(fontSize: 14, color: AppColors.grey_212121),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    'Best Price \$${item.couponPrice.toStringAsFixed(0)}',
                    style: TextStyle(
                      color: AppColors.green_327801,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'with coupon',
                    style: TextStyle(
                      color: AppColors.grey_212121,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      // TODO: Handle coupon apply action
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.green_6cad10,
                            AppColors.green_327801,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          "Add",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),
            ],
          ),
        ),
      ],
    ),
  );
}
