import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shree_radhey/utils/routes/app_route_path.dart';

import '../../../common/components/common_footer.dart';
import '../../../common/components/custom_snackbar.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../utils/review_utils.dart';
import '../../auth/controller/auth_controller.dart';
import '../../cart/controller/cart_controller.dart';
import '../../home/controller/wishlist_controller.dart';
import '../controller/product_variant_controller.dart';
import '../controller/shop_controller.dart';
import 'components/add_review_section.dart';
import 'components/faq_section.dart';
import 'components/product_detail_review_section.dart';
import 'components/variant_card.dart';
import 'widgets/additional_info_widget.dart';
import 'widgets/description_widget.dart';
import 'widgets/related_product_section.dart';

class ProductDetailPage extends StatefulWidget {
  final String slug;
  final String category;
  const ProductDetailPage({
    super.key,
    required this.slug,
    required this.category,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final cartController = Get.find<CartController>();
  final auth = Get.find<AuthController>();
  bool showFullVariants = false;

  final ShopController controller = Get.put(ShopController());
  final TextEditingController pinController = TextEditingController();
  final ProductVariantController productVariantController = Get.put(
    ProductVariantController(),
  );
  final WishlistController wishlistController = Get.put(WishlistController());
  Widget _buildCircleIcon(
    IconData icon, {
    Color? color,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, size: 24, color: color ?? AppColors.red_CC0003),
        onPressed: onTap,
        padding: EdgeInsets.zero,
      ),
    );
  }

  int selectedImageIndex = 0;

  int quantity = 1;

  @override
  void initState() {
    super.initState();
    debugPrint("Slug is ${widget.slug}");
    debugPrint("category is ${widget.category}");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchProductDetail(context, widget.slug);
      controller.fetchProductReviews(widget.slug);
      productVariantController.fetchProductVariants(widget.category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Row(
          children: [
            // Quantity Selector
            // Container(
            //   decoration: BoxDecoration(
            //     border: Border.all(color: Colors.grey.shade400),
            //     borderRadius: BorderRadius.circular(8),
            //   ),
            //   child: Row(
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       // Minus
            //       IconButton(
            //         icon: const Icon(Icons.remove, size: 16),
            //         onPressed: () {
            //           setState(() {
            //             if (quantity > 1) quantity--;
            //           });
            //         },
            //       ),

            //       // Divider
            //       Container(width: 1, height: 50, color: Colors.grey.shade300),

            //       // Quantity Text
            //       Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 12),
            //         child: Text(
            //           quantity.toString(),
            //           style: const TextStyle(
            //             fontSize: 16,
            //             fontWeight: FontWeight.w600,
            //           ),
            //         ),
            //       ),

            //       // Divider
            //       Container(width: 1, height: 50, color: Colors.grey.shade300),

            //       // Plus
            //       IconButton(
            //         icon: const Icon(Icons.add, size: 16),
            //         onPressed: () {
            //           setState(() {
            //             quantity++;
            //           });
            //         },
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(width: 12),

            // Add to Cart Button with Gradient
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.green_6cad10, AppColors.green_327801],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (auth.isGuest) {
                      CustomSnackbars.showError(
                        context,
                        "Login Required ! Please login to add items to cart",
                      );

                      // Navigate to login with go_router
                      context.push(AppRoutePath.login);
                      return;
                    }
                    final detail =
                        controller.productDetail.value?.data?.product;
                    if (detail?.isInCart == true) {
                      // Navigate to cart page
                      context.go(AppRoutePath.cartPage);
                    } else {
                      // Add to cart
                      cartController.addProductToCart(
                        detail?.databaseId ?? 0,
                        1,
                        context,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0, // remove shadow since gradient is outside
                    backgroundColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Obx(() {
                    final detail =
                        controller.productDetail.value?.data?.product;
                    if (detail?.databaseId == null) {
                      return const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      );
                    }
                    final productId = detail!.databaseId!;
                    final isAdding =
                        cartController.addingItems[productId] ?? false;
                    final inCart = cartController.isInCart(productId);

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

            const SizedBox(width: 8),

            // Buy Now Button
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  final detail = controller.productDetail.value?.data?.product;
                  cartController.addProductToCart(
                    detail?.databaseId ?? 0,
                    1,
                    context,
                  );
                  context.push(AppRoutePath.checkoutScreen);
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.green_6cad10),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Buy Now",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.white,
      body: Obx(() {
        if (controller.isDetailLoading.value ||
            controller.isVariantLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final detail = controller.productDetail.value?.data?.product;
        if (detail == null) {
          return const Center(child: Text("Product not found"));
        }
        final ratingDistribution = buildRatingDistribution(
          detail.ratingBreakdown,
        );

        // final reviews = buildReviews(detail.reviews?.nodes);
        List<String> getAllImages() {
          // Merge main image + gallery images
          final List<String> images = [];
          if (detail.image?.sourceUrl != null) {
            images.add(detail.image!.sourceUrl!);
          }
          if (detail.galleryImages?.nodes != null) {
            images.addAll(
              detail.galleryImages!.nodes!
                  .map((e) => e.sourceUrl ?? "")
                  .where((url) => url.isNotEmpty),
            );
          }
          return images;
        }

        final images = getAllImages();
        final attributes =
            (detail.attributes?["nodes"] as List<dynamic>?)
                ?.map((e) => e as Map<String, dynamic>)
                .toList() ??
            [];

        if (controller.isReviewLoading.value) {
          return Center(child: const CircularProgressIndicator());
        }
        if (productVariantController.isLoading.value) {
          return Center(child: const CircularProgressIndicator());
        }

        final variants = productVariantController.productVariants;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: "Home",
                        style: TextStyle(
                          color: AppColors.grey_3C403D,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: " / ",
                        style: TextStyle(
                          color: AppColors.red_CC0003,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "Ghee",
                        style: TextStyle(
                          color: AppColors.grey_3C403D,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: " / ",
                        style: TextStyle(
                          color: AppColors.red_CC0003,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: detail.name,
                        style: TextStyle(
                          color: AppColors.red_CC0003,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // ====== IMAGE SECTION ======
              Stack(
                children: [
                  // Big Image
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: ClipRRect(
                      child: Image.network(
                        images[selectedImageIndex],
                        width: double.infinity,
                        height: 350,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Vertical Icons
                  Positioned(
                    top: 30,
                    right: 30,
                    child: Column(
                      children: [
                        Obx(() {
                          final isWishlisted =
                              wishlistController.wishlistMap[detail
                                  .databaseId] ??
                              false;
                          return _buildCircleIcon(
                            isWishlisted
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color:
                                isWishlisted
                                    ? Colors.red
                                    : AppColors.red_CC0003,

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
                                  .toggleWishlist(detail.databaseId ?? 0);
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
                          );
                        }),

                        // const SizedBox(height: 12),
                        // _buildCircleIcon(Icons.search, onTap: () {}),
                        const SizedBox(height: 12),
                        _buildCircleIcon(
                          Icons.ios_share_outlined,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // ====== MINI IMAGES ======
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 18,
                ),
                child: SizedBox(
                  height: 70,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: images.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final bool isSelected = selectedImageIndex == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedImageIndex = index;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  isSelected
                                      ? AppColors.red_ef4444
                                      : Colors.transparent,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              images[index],
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // ====== PRODUCT INFO ======
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Best Seller Tag
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.green_327801,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "Best Seller",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Product Title
                    Text(
                      detail.name ?? "",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Combo text
                    Text(
                      detail.productCategories?.nodes?.isNotEmpty == true
                          ? (detail.productCategories?.nodes?.first.name ?? "")
                          : "",
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: AppColors.orange_f29102,
                          size: 20,
                        ),
                        Icon(
                          Icons.star,
                          color: AppColors.orange_f29102,
                          size: 20,
                        ),
                        Icon(
                          Icons.star,
                          color: AppColors.orange_f29102,
                          size: 20,
                        ),
                        Icon(
                          Icons.star_half,
                          color: AppColors.orange_f29102,
                          size: 20,
                        ),
                        Icon(
                          Icons.star_border,
                          color: AppColors.orange_f29102,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "${detail.averageRating.toString()} | ${detail.reviewCount.toString()} Reviews",
                          style: TextStyle(fontSize: 14, color: AppColors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Price Row
                    Row(
                      children: [
                        Text(
                          "${detail.currencySymbol}${detail.price}",
                          style: TextStyle(
                            color: AppColors.blue_2da5f3,
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(width: 8),
                        Text(
                          "${detail.currencySymbol}${detail.regularPrice}",
                          style: TextStyle(
                            fontSize: 22,
                            decoration: TextDecoration.lineThrough,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "FREE Delivery on prepaid Orders.",
                      style: TextStyle(color: AppColors.grey_212121),
                    ),
                    const SizedBox(height: 16),
                    _buildVariantSection(variants),

                    // Select Variant section
                    // if (productVariantController.productVariants.isEmpty) ...[
                    //   const Text(
                    //     "No variants found",
                    //     style: TextStyle(
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.w500,
                    //       color: Colors.grey,
                    //     ),
                    //   ),
                    // ] else ...[
                    //   Text(
                    //     "Select Variant",
                    //     style: TextStyle(
                    //       fontSize: 18,
                    //       fontWeight: FontWeight.w600,
                    //       color: AppColors.grey_212121,
                    //     ),
                    //   ),
                    //   SizedBox(height: 12),
                    //   GridView.builder(
                    //     padding: EdgeInsets.zero,
                    //     shrinkWrap: true,
                    //     physics: const NeverScrollableScrollPhysics(),
                    //     itemCount: variants.length,
                    //     gridDelegate:
                    //         const SliverGridDelegateWithFixedCrossAxisCount(
                    //           crossAxisCount: 2,
                    //           crossAxisSpacing: 12,
                    //           mainAxisSpacing: 12,
                    //           childAspectRatio:
                    //               1.3, // adjust height/width ratio
                    //         ),
                    //     itemBuilder: (context, index) {
                    //       final v = variants[index];

                    //       return VariantCard(
                    //         variantName: v.productSubtitle ?? "",
                    //         originalPrice: v.regularPrice ?? "",
                    //         discountedPrice: v.salePrice ?? "",
                    //         discountPercent: v.discountPercentage ?? 0,
                    //         currencySymbol: v.currencySymbol ?? "",
                    //         isSelected: selectedVariantIndex == index,
                    //         onTap: () {
                    //           setState(() {
                    //             selectedVariantIndex = index;
                    //           });
                    //         },
                    //       );
                    //     },
                    //   ),
                    // ],
                    // SizedBox(height: 12),
                    // Center(
                    //   child: Text(
                    //     "Explore More Variant",
                    //     textAlign: TextAlign.center,

                    //     style: TextStyle(
                    //       decoration: TextDecoration.underline,
                    //       decorationColor: AppColors.green_6cad10,
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.w700,
                    //       color: AppColors.green_6cad10,
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 20),
                    Image.asset(AppImages.product_page_image),
                    SizedBox(height: 20),
                    Text(
                      "Delivery Estimate",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.grey_212121,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        // Pincode TextField
                        Expanded(
                          child: TextField(
                            controller: pinController,
                            decoration: InputDecoration(
                              hintText: "Enter your pincode",
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: AppColors.grey_bgscreen_f7fafc,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: AppColors.grey_e2e8f0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: AppColors.black),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),

                        const SizedBox(width: 8),

                        // Check Button
                        GestureDetector(
                          onTap: () {
                            final pin = int.tryParse(pinController.text.trim());
                            if (pin != null) {
                              controller.checkDelivery(pin);
                            } else {
                              CustomSnackbars.showError(
                                context,
                                "Enter a valid pincode",
                              );
                            }
                          },
                          child: Container(
                            height: 48,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.green_6cad10,
                                  AppColors.green_327801,
                                ], // green gradient
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Check",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Obx(() {
                      if (controller.isLoading.value) {
                        return const CircularProgressIndicator();
                      }

                      if (controller.error.isNotEmpty) {
                        return Center(
                          child: Text(
                            controller.error.value,
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }

                      final data = controller.deliveryData.value;
                      if (data == null) return const SizedBox();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${data['city']}- ${data['postcode']}, ${data['state']}, ${data['country']}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),

                          const SizedBox(height: 8),

                          Html(data: data['estimatedDelivery'] ?? ""),
                        ],
                      );
                    }),
                    const SizedBox(height: 20),
                    descriptionWidget(detail.description ?? ""),

                    const SizedBox(height: 12),
                    AdditionalInfoWidget(attributes: attributes),
                    SizedBox(height: 20),
                    // Reviews Section
                    if (controller.reviews.isEmpty) ...[
                      const Text(
                        "No reviews found",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ] else ...[
                      Text(
                        "Reviews ${(detail.reviewCount)}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ProductDetailReviewSection(
                        averageRating: (detail.averageRating ?? 0).toDouble(),
                        totalReviews: detail.reviewCount ?? 0,
                        ratingDistribution: ratingDistribution,
                        reviews: controller.reviews,
                      ),
                    ],

                    SizedBox(height: 20),
                    AddReviewSection(productId: detail.databaseId!),
                    SizedBox(height: 20),

                    if (detail.faqContent != null &&
                        detail.faqContent!.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      const Text(
                        "FAQ",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      FAQSection(
                        faqColor: AppColors.black,
                        faqs:
                            detail.faqContent!
                                .map(
                                  (faq) => {
                                    "question": faq.question ?? "",
                                    "answer": faq.answer ?? "",
                                  },
                                )
                                .toList(),
                      ),
                    ],

                    RelatedProductSection(
                      firstText: "",
                      firstTextColor: AppColors.black,
                      secondTextColor: AppColors.black,
                      secondText: "Similar Products".toUpperCase(),
                      sectionBgColor: AppColors.white,

                      products: detail.related?.nodes ?? [],
                    ),
                    // ProductSection(firstText: "", firstTextColor: AppColors.black, secondTextColor: AppColors.black, secondText: "Similar Products".toUpperCase(), sectionBgColor: AppColors.white, tagText: "", products: detail)

                    // ProductSection(
                    //   firstText: "",
                    //   firstTextColor: AppColors.black,
                    //   secondTextColor: AppColors.black,
                    //   secondText: "Similar Products".toUpperCase(),
                    //   sectionBgColor: AppColors.white,
                    //   tagText: "Best Seller",

                    //   products: detail.related?.nodes ?? [],
                    // ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
              CommonFooter(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildVariantSection(List variants) {
    final productVariantController = Get.find<ProductVariantController>();

    if (variants.isEmpty) {
      return const Text(
        "No variants found",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
      );
    }

    // Show only first 3 if longer
    final showAll = variants.length <= 3 || showFullVariants;
    final displayVariants = showAll ? variants : variants.take(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Variant",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.grey_212121,
          ),
        ),
        const SizedBox(height: 12),

        Obx(() {
          final selectedIndex =
              productVariantController.selectedVariantIndex.value;

          return GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: displayVariants.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.3,
            ),
            itemBuilder: (context, index) {
              final v = displayVariants[index];
              return VariantCard(
                variantName: v.productSubtitle ?? "",
                originalPrice: v.regularPrice ?? "",
                discountedPrice: v.salePrice ?? "",
                discountPercent: v.discountPercentage ?? 0,
                currencySymbol: v.currencySymbol ?? "",
                isSelected: selectedIndex == index,
                onTap: () {
                  // Update controller instead of local state
                  productVariantController.setSelectedVariant(index);

                  // Call product detail API again for the selected variant
                  final slug = v.slug; // assuming variant has slug
                  Get.find<ShopController>().fetchProductDetail(context, slug);
                },
              );
            },
          );
        }),

        if (variants.length > 3 && !showFullVariants)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    showFullVariants = true;
                  });
                },
                child: Text(
                  "Explore More Variants",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.green_6cad10,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.green_6cad10,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
