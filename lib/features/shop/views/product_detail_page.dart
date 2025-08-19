import 'package:flutter/material.dart';
import 'package:shree_radhey/constants/app_mock_data.dart';
import 'package:shree_radhey/features/shop/views/components/product_detail_review_section.dart';

import '../../../common/components/common_footer.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../home/views/widgets/product_section_widget.dart';
import 'components/faq_section.dart';
import 'components/variant_card.dart';
import 'widgets/additional_info_widget.dart';
import 'widgets/description_widget.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  Widget _buildCircleIcon(IconData icon, {required VoidCallback onTap}) {
    return Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
      "name": "1L Pet Bottle (Pack of 2)",
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

  final List<String> productImages = [
    AppImages.product_image,
    AppImages.product_image_blog,
    AppImages.core_value_three,
    AppImages.core_value_one,
  ];

  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Home / Ghee /  SHREERADHEY A2 gir cow ghee (1L Pet Bottle),",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.red, // like your design's breadcrumb
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
                    child: Image.asset(
                      productImages[selectedImageIndex],
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
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
              child: SizedBox(
                height: 70,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: productImages.length,
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
                          child: Image.asset(
                            productImages[index],
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
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                  const Text(
                    "SHREERADHEY A2 gir cow ghee (1L Pet Bottle)",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),

                  // Combo text
                  Text(
                    "Combo, Ghee",
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
                        '4.7 | 102 Reviews',
                        style: TextStyle(fontSize: 14, color: AppColors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Price Row
                  Row(
                    children: [
                      Text(
                        "\$110.00",
                        style: TextStyle(
                          color: AppColors.blue_2da5f3,
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(width: 8),
                      Text(
                        "\$115.00",
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
                  descriptionWidget(),

                  const SizedBox(height: 12),
                  additionalInfoWidget(),
                  SizedBox(height: 20),
                  Text(
                    "Reviews (20)",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  ProductDetailReviewSection(
                    averageRating: 4.7,
                    totalReviews: 20,
                    ratingDistribution: AppMockData.mockRatingDistribution,
                    reviews: AppMockData.mockReviews,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "FAQ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.grey_212121,
                    ),
                  ),
                  FAQSection(
                    faqColor: AppColors.black,
                    faqs: [
                      {
                        "question": "What is the shelf life of this product?",
                        "answer":
                            "The product has a shelf life of 12 months from the date of manufacture.",
                      },
                      {
                        "question": "Does it contain preservatives?",
                        "answer":
                            "No, our products are made with 100% natural ingredients.",
                      },
                      {
                        "question": "Is this product vegan?",
                        "answer": "Yes, it is completely plant-based.",
                      },
                    ],
                  ),

                  ProductSection(
                    firstText: "",
                    firstTextColor: AppColors.black,
                    secondTextColor: AppColors.black,
                    secondText: "Similar Products",
                    sectionBgColor: AppColors.white,
                    tagText: "Best Seller",
                  ),

                  SizedBox(height: 40),
                ],
              ),
            ),
            CommonFooter(),
          ],
        ),
      ),
    );
  }
}
