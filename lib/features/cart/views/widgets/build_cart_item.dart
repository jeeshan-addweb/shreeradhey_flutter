import 'package:flutter/material.dart';

import '../../../../common/model/ui_product_model.dart';
import '../../../../constants/app_colors.dart';

Widget buildCartItem(UiProductModel item) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Padding(
      padding: const EdgeInsets.all(12),
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
          Expanded(
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
                      'Best Price \$${item.couponPrice}',
                      style: TextStyle(
                        color: AppColors.green_327801,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'with coupon',
                      style: TextStyle(
                        color: AppColors.grey_212121,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Quantity + Delete
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove, size: 18),
                            onPressed: () {},
                          ),

                          const Text("1"),
                          IconButton(
                            icon: const Icon(Icons.add, size: 18),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.delete_outline_outlined,
                        color: AppColors.red_CC0003,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
