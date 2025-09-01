import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/components/common_footer.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../utils/review_utils.dart';
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
  const ProductDetailPage({super.key, required this.slug});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final ShopController controller = Get.find<ShopController>();

  Widget _buildCircleIcon(IconData icon, {required VoidCallback onTap}) {
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
        icon: Icon(icon, size: 24),
        onPressed: onTap,
        padding: EdgeInsets.zero,
      ),
    );
  }

  int selectedVariantIndex = 0;

  final variants = [
    {
      "name": "1L Pet Bottle (Pack of 2) skxsxszxjszxbhjjhbjjhbcjbjb",
      "original": 120.0,
      "discounted": 110.0,
      "percent": 8,
    },
    {
      "name": "500ml Bottle",
      "original": 65.0,
      "discounted": 60.0,
      "percent": 8,
    },
    {"name": "2L Bottle", "original": 220.0, "discounted": 200.0, "percent": 9},
  ];

  int selectedImageIndex = 0;

  int quantity = 1;
  @override
  void initState() {
    super.initState();
    debugPrint("Slug is ${widget.slug}");
    controller.fetchProductDetail(context, widget.slug);
    controller.fetchProductReviews(widget.slug);
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
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Minus
                  IconButton(
                    icon: const Icon(Icons.remove, size: 16),
                    onPressed: () {
                      setState(() {
                        if (quantity > 1) quantity--;
                      });
                    },
                  ),

                  // Divider
                  Container(width: 1, height: 50, color: Colors.grey.shade300),

                  // Quantity Text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      quantity.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  // Divider
                  Container(width: 1, height: 50, color: Colors.grey.shade300),

                  // Plus
                  IconButton(
                    icon: const Icon(Icons.add, size: 16),
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                  ),
                ],
              ),
            ),

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
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0, // remove shadow since gradient is outside
                    backgroundColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Add to Cart",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.shopping_cart, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(width: 8),

            // Buy Now Button
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  // handle buy now
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
        if (controller.isDetailLoading.value) {
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
          return const CircularProgressIndicator();
        }

        if (controller.reviews.isEmpty) {
          return const Text("No reviews yet");
        }

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
                        _buildCircleIcon(Icons.favorite_border, onTap: () {}),
                        const SizedBox(height: 12),
                        _buildCircleIcon(Icons.search, onTap: () {}),
                        const SizedBox(height: 12),
                        _buildCircleIcon(Icons.download, onTap: () {}),
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
                          detail.price.toString(),
                          style: TextStyle(
                            color: AppColors.blue_2da5f3,
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(width: 8),
                        Text(
                          detail.regularPrice.toString(),
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

                    // Select Variant section
                    Text(
                      "Select Variant",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey_212121,
                      ),
                    ),
                    SizedBox(height: 12),
                    GridView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: variants.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1.3, // adjust height/width ratio
                          ),
                      itemBuilder: (context, index) {
                        final v = variants[index];
                        return VariantCard(
                          variantName: v["name"] as String,
                          originalPrice: v["original"] as double,
                          discountedPrice: v["discounted"] as double,
                          discountPercent: v["percent"] as int,
                          isSelected: selectedVariantIndex == index,
                          onTap: () {
                            setState(() {
                              selectedVariantIndex = index;
                            });
                          },
                        );
                      },
                    ),
                    SizedBox(height: 12),
                    Center(
                      child: Text(
                        "Explore More Variant",
                        textAlign: TextAlign.center,

                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.green_6cad10,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.green_6cad10,
                        ),
                      ),
                    ),
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
                        Container(
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
                      ],
                    ),
                    const SizedBox(height: 20),
                    descriptionWidget(detail.description ?? ""),

                    const SizedBox(height: 12),
                    AdditionalInfoWidget(attributes: attributes),
                    SizedBox(height: 20),
                    Text(
                      "Reviews ${(detail.reviewCount)}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: 20),
                    ProductDetailReviewSection(
                      averageRating: (detail.averageRating ?? 0).toDouble(),
                      totalReviews: detail.reviewCount ?? 0,
                      ratingDistribution: ratingDistribution,
                      reviews: controller.reviews,
                    ),
                    SizedBox(height: 20),
                    AddReviewSection(),
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
}
