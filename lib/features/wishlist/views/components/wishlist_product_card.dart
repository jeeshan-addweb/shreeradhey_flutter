import 'package:flutter/material.dart';

import '../../../../common/model/product_model.dart';
import '../../../../constants/app_colors.dart';

class WishlistProductCard extends StatelessWidget {
  final ProductModel model;
  final VoidCallback onRemove;
  final VoidCallback onAddToCart;

  const WishlistProductCard({
    super.key,
    required this.model,
    required this.onRemove,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with Best Seller Tag
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: AspectRatio(
                      aspectRatio: 4 / 3, // keeps image proportional
                      child: Image.asset(
                        model.imageUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.sizeOf(context).height * 0.012,
                  left: MediaQuery.sizeOf(context).height * 0.012,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    height: MediaQuery.sizeOf(context).height * 0.025,
                    decoration: BoxDecoration(
                      color: AppColors.yellow_fbda43,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize:
                          MainAxisSize.min, // <— lets Row shrink to content
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Best Seller",
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // On Sale Tag
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.red_b12704,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      "ON SALE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Product Name
                  Text(
                    model.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Subtitle
                  Text(
                    model.subtitle,
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Rating
                  Row(
                    children: [
                      // ...List.generate(5, (index) {
                      //   return Icon(
                      //     index < model.rating.floor()
                      //         ? Icons.star
                      //         : index < model.rating
                      //         ? Icons.star_half
                      //         : Icons.star_border,
                      //     color: AppColors.orange_f29102,
                      //     size: 13,
                      //   );
                      // }),
                      const SizedBox(width: 6),
                      Text(
                        "(${model.reviewCount})",
                        style: TextStyle(color: AppColors.grey, fontSize: 13),
                      ),
                    ],
                  ),

                  // Description
                  Text(
                    model.description ?? "No Description",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.grey_212121,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),

                  Text(
                    "FREE Delivery on prepaid Orders.",
                    style: TextStyle(
                      color: AppColors.grey_212121,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Price
                  Row(
                    children: [
                      Text(
                        "₹${model.price}",
                        style: TextStyle(
                          color: AppColors.blue_2da5f3,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "₹${model.oldPrice}",
                        style: TextStyle(
                          fontSize: 12,
                          decoration: TextDecoration.lineThrough,
                          color: AppColors.grey_212121,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "(${model.discountPercent}%)",
                        style: TextStyle(
                          color: AppColors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Add to cart
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.green_6cad10,
                          AppColors.green_327801,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ElevatedButton(
                      onPressed: onAddToCart,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Add to cart",
                            style: TextStyle(color: AppColors.white),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.shopping_cart,
                            color: AppColors.white,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Remove
                  GestureDetector(
                    onTap: onRemove,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.delete_outline,
                          color: AppColors.red_CC0003,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "Remove",
                          style: TextStyle(
                            color: AppColors.red_CC0003,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
