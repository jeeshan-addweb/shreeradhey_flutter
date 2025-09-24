import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shree_radhey/utils/routes/app_route_path.dart';

import '../../constants/app_colors.dart';
import '../../features/auth/controller/auth_controller.dart';
import '../../features/cart/controller/cart_controller.dart';
import '../../features/home/controller/wishlist_controller.dart';
import '../model/ui_product_model.dart';
import 'custom_snackbar.dart';

class ProductCard extends StatefulWidget {
  final UiProductModel model;

  const ProductCard({super.key, required this.model});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final cartController = Get.find<CartController>();
  final auth = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    final WishlistController wishlistController = Get.put(WishlistController());
    double tagSize = MediaQuery.of(context).size.width * 0.12; // ~12% of screen
    double tagPadding = 12;
    return GestureDetector(
      onTap: () {
        context.push(
          AppRoutePath.productDetail,
          // pathParameters: {'slug': widget.model.slug ?? ""},
          extra: {
            'hideNav': true,
            'slug': widget.model.slug,
            'category': widget.model.category,
          },
        );
        // context.pushNamed(
        //   AppRoutePath.productDetail,
        //   extra: 'coconut-oil-5ltr',
        // );
      },
      child: Card(
        color: AppColors.white,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with tags
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
                      aspectRatio: 6 / 6,
                      child: Image.network(
                        widget.model.imageUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                // Save tag with triangle clip
                Positioned(
                  top: tagPadding,
                  left: tagPadding,
                  child: ClipPath(
                    clipper: SaveTagClipper(),
                    child: Container(
                      width: tagSize,
                      height: tagSize,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.save_red_e51900,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'SAVE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${widget.model.discountPercent.toString()}%",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),
                ),

                // Best seller tag (same size as SAVE tag)
                Positioned(
                  top: tagPadding,
                  right: tagPadding,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),

                    height: 30,
                    decoration: BoxDecoration(
                      color:
                          widget.model.productLabels.isNotEmpty &&
                                  widget.model.productLabels.first ==
                                      "Newly Launch"
                              ? AppColors.blue_2da5f3
                              : AppColors.green_327801,

                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize:
                          MainAxisSize.min, // <— lets Row shrink to content
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          // widget.model.tagText,
                          widget.model.productLabels.isNotEmpty
                              ? widget.model.productLabels.first
                              : "",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        widget.model.productLabels.isNotEmpty
                            ? const SizedBox(width: 4)
                            : SizedBox(),
                        widget.model.productLabels.isNotEmpty
                            ? Container(
                              width: 1,
                              height: 14,
                              color: Colors.white,
                            )
                            : SizedBox(),
                        widget.model.productLabels.isNotEmpty
                            ? const SizedBox(width: 4)
                            : SizedBox(),

                        GestureDetector(
                          onTap: () async {
                            if (auth.isGuest) {
                              CustomSnackbars.showError(
                                context,
                                "Login Required ! Please login to add items to wishlist.",
                              );

                              // Navigate to login with go_router
                              context.push(AppRoutePath.login);
                              return;
                            }

                            final response = await wishlistController
                                .toggleWishlist(widget.model.productId);
                            if (response["success"] == true) {
                              CustomSnackbars.showSuccess(
                                context,
                                response["message"],
                              );
                            } else {
                              CustomSnackbars.showError(
                                context,
                                response["message"],
                              );
                            }
                          },
                          child: Obx(() {
                            final isWishlisted =
                                wishlistController.wishlistMap[widget
                                    .model
                                    .productId] ??
                                false;
                            return Icon(
                              isWishlisted
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isWishlisted ? Colors.red : Colors.white,
                              size: 18,
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                widget.model.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                (widget.model.subtitle.isNotEmpty
                    ? widget.model.subtitle
                    : " "),
                style: TextStyle(
                  color: AppColors.grey_65758b,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                children: [
                  ..._buildStarRating(widget.model.rating ?? 0.0),
                  const SizedBox(width: 4),
                  Text(
                    '${widget.model.rating} | ${widget.model.reviewCount} Reviews',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.grey_212121,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.model.currencySymbol}${widget.model.price}',
                    style: TextStyle(
                      color: AppColors.blue_2da5f3,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${widget.model.currencySymbol}${widget.model.oldPrice}',
                    style: TextStyle(
                      fontSize: 12,
                      decoration: TextDecoration.lineThrough,
                      color: AppColors.grey_212121,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: FittedBox(
                      child: Row(
                        children: [
                          Text(
                            'Best Price ${widget.model.currencySymbol}${widget.model.couponPrice}',
                            style: TextStyle(
                              color: AppColors.green_327801,
                              fontWeight: FontWeight.w700,
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
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (auth.isGuest) {
                      CustomSnackbars.showError(
                        context,
                        "Login Required ! Please login to add items to cart.",
                      );

                      // Navigate to login with go_router
                      context.push(AppRoutePath.login);
                      return;
                    }

                    if (widget.model.isInCart.value) {
                      context.go(AppRoutePath.cartPage);
                    } else {
                      // Add to cart
                      cartController.addProductToCart(
                        widget.model.productId,
                        1,
                        context,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size.fromHeight(40),
                    shadowColor: Colors.transparent,
                    backgroundColor: Colors.transparent,
                  ).copyWith(
                    backgroundColor: WidgetStateProperty.all<Color>(
                      Colors.transparent,
                    ),
                    overlayColor: WidgetStateProperty.all<Color>(
                      Colors.transparent,
                    ),
                  ),
                  child: Ink(
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
                    child: Container(
                      alignment: Alignment.center,
                      constraints: const BoxConstraints(minHeight: 40),
                      child: Obx(() {
                        final isAdding =
                            cartController.addingItems[widget
                                .model
                                .productId] ??
                            false;
                        final inCart = cartController.isInCart(
                          widget.model.productId,
                        );

                        if (isAdding) {
                          return const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          );
                        } else {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                inCart ? 'View My Cart' : 'Add to Cart',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Icon(
                                Icons.shopping_cart,
                                color: AppColors.white,
                                size: 20,
                              ),
                            ],
                          );
                        }
                      }),
                    ),
                  ),
                ),
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            //   child: Container(
            //     decoration: BoxDecoration(
            //       gradient: LinearGradient(
            //         colors: [AppColors.green_6cad10, AppColors.green_327801],
            //         begin: Alignment.topCenter,
            //         end: Alignment.bottomCenter,
            //       ),
            //       borderRadius: BorderRadius.circular(8),
            //     ),
            //     child: ElevatedButton(
            //       onPressed: () {},
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: Colors.transparent,
            //         shadowColor: Colors.transparent,
            //         minimumSize: const Size.fromHeight(40),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(8),
            //         ),
            //       ),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Text(
            //             'Add to cart',
            //             style: TextStyle(color: AppColors.white, fontSize: 16),
            //           ),
            //           SizedBox(width: 5),
            //           Icon(
            //             Icons.shopping_cart,
            //             color: AppColors.white,
            //             size: 20,
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

List<Widget> _buildStarRating(double rating) {
  const maxStars = 5;
  List<Widget> stars = [];

  for (int i = 1; i <= maxStars; i++) {
    if (i <= rating.floor()) {
      // Full star
      stars.add(Icon(Icons.star, color: AppColors.orange_f29102, size: 18));
    } else if (i - rating <= 0.5) {
      // Half star
      stars.add(
        Icon(Icons.star_half, color: AppColors.orange_f29102, size: 18),
      );
    } else {
      // Empty star
      stars.add(
        Icon(Icons.star_border, color: AppColors.orange_f29102, size: 18),
      );
    }
  }

  return stars;
}

class SaveTagClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const double triangleWidth = 10;
    const double triangleHeight = 8;

    Path path = Path();
    path.moveTo(0, 0);

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - triangleHeight);

    // Create zigzag pattern from right to left
    double x = size.width;
    bool goingDown = true;

    while (x > 0) {
      double newX = (x - triangleWidth).clamp(0, size.width);
      double y = goingDown ? size.height : size.height - triangleHeight;

      path.lineTo(newX, y);

      x = newX;
      goingDown = !goingDown;
    }

    path.lineTo(0, size.height - triangleHeight);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
