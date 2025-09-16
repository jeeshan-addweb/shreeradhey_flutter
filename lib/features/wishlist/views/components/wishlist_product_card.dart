import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shree_radhey/features/home/model/get_wishlist_model.dart';
import '../../../../common/components/custom_snackbar.dart';
import '../../../../constants/app_colors.dart';
import '../../../cart/controller/cart_controller.dart';
import '../../../home/controller/wishlist_controller.dart';

class WishlistProductCard extends StatefulWidget {
  final WishlistProduct model;
  // final VoidCallback onRemove;
  // final VoidCallback onAddToCart;

  const WishlistProductCard({
    super.key,
    required this.model,
    // required this.onRemove,
    // required this.onAddToCart,
  });

  @override
  State<WishlistProductCard> createState() => _WishlistProductCardState();
}

class _WishlistProductCardState extends State<WishlistProductCard> {
  final cartController = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    final WishlistController wishlistController = Get.put(WishlistController());
    final categories = widget.model.productCategories?.nodes ?? [];

    String subtitle = "";
    if (categories.isNotEmpty) {
      subtitle = categories.first.name ?? "";
      if (categories.length > 1) {
        subtitle += ", ${categories[1].name}";
      }
    }
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
                      aspectRatio: 4 / 3,
                      child: Image.network(
                        widget.model.image?.sourceUrl ?? "",
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
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.model.productLabels!.nodes!.first.name ?? "",
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

                  Text(
                    widget.model.name ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),

                  Text(
                    subtitle,
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),

                  Row(
                    children: [
                      Text(
                        "(${widget.model.reviewCount})",
                        style: TextStyle(color: AppColors.grey, fontSize: 13),
                      ),
                    ],
                  ),

                  // Description
                  // Text(
                  //   model.description ?? "No Description",
                  //   style: TextStyle(
                  //     fontSize: 14,
                  //     color: AppColors.grey_212121,
                  //   ),
                  //   maxLines: 3,
                  //   overflow: TextOverflow.ellipsis,
                  // ),
                  Text(
                    "FREE Delivery on prepaid Orders.",
                    style: TextStyle(
                      color: AppColors.grey_212121,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 6),

                  Row(
                    children: [
                      Text(
                        "${widget.model.currencySymbol}${widget.model.price}",
                        style: TextStyle(
                          color: AppColors.blue_2da5f3,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "${widget.model.currencySymbol}${widget.model.regularPrice}",
                        style: TextStyle(
                          fontSize: 12,
                          decoration: TextDecoration.lineThrough,
                          color: AppColors.grey_212121,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "(${widget.model.discountPercentage}%)",
                        style: TextStyle(
                          color: AppColors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // SizedBox(
                  //   width: double.infinity,
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       if (widget.model.isInCart.value) {
                  //         // Navigate to cart page
                  //         context.go(AppRoutePath.cartPage);
                  //       } else {
                  //         // Add to cart
                  //         cartController.addProductToCart(
                  //           widget.model.databaseId ?? 0,
                  //           1,
                  //           context,
                  //         );

                  //         widget.model.isInCart.value = true;
                  //       }
                  //     },
                  //     style: ElevatedButton.styleFrom(
                  //       padding: EdgeInsets.zero,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(8),
                  //       ),
                  //       minimumSize: const Size.fromHeight(40),
                  //       shadowColor: Colors.transparent,
                  //       backgroundColor: Colors.transparent,
                  //     ).copyWith(
                  //       backgroundColor: WidgetStateProperty.all<Color>(
                  //         Colors.transparent,
                  //       ),
                  //       overlayColor: WidgetStateProperty.all<Color>(
                  //         Colors.transparent,
                  //       ),
                  //     ),
                  //     child: Ink(
                  //       decoration: BoxDecoration(
                  //         gradient: LinearGradient(
                  //           colors: [
                  //             AppColors.green_6cad10,
                  //             AppColors.green_327801,
                  //           ],
                  //           begin: Alignment.topCenter,
                  //           end: Alignment.bottomCenter,
                  //         ),
                  //         borderRadius: BorderRadius.circular(8),
                  //       ),
                  //       child: Container(
                  //         alignment: Alignment.center,
                  //         constraints: const BoxConstraints(minHeight: 40),
                  //         child: Obx(() {
                  //           final isAdding =
                  //               cartController.addingItems[widget
                  //                   .model
                  //                   .databaseId] ??
                  //               false;

                  //           if (isAdding) {
                  //             return const SizedBox(
                  //               height: 20,
                  //               width: 20,
                  //               child: CircularProgressIndicator(
                  //                 color: Colors.white,
                  //                 strokeWidth: 2,
                  //               ),
                  //             );
                  //           } else {
                  //             return Row(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               mainAxisSize: MainAxisSize.min,
                  //               children: [
                  //                 Text(
                  //                   widget.model.isInCart.value
                  //                       ? 'View My Cart'
                  //                       : 'Add to Cart',
                  //                   style: TextStyle(
                  //                     color: AppColors.white,
                  //                     fontSize: 16,
                  //                   ),
                  //                 ),
                  //                 const SizedBox(width: 5),
                  //                 Icon(
                  //                   Icons.shopping_cart,
                  //                   color: AppColors.white,
                  //                   size: 20,
                  //                 ),
                  //               ],
                  //             );
                  //           }
                  //         }),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 10),

                  GestureDetector(
                    onTap: () async {
                      final response = await wishlistController.toggleWishlist(
                        widget.model.databaseId ?? 0,
                      );

                      if (response["success"] == true) {
                        CustomSnackbars.showSuccess(
                          context,
                          response["message"],
                        );
                      } else {
                        CustomSnackbars.showError(context, response["message"]);
                      }
                    },
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
