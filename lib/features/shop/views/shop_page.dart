import 'package:flutter/material.dart';

import '../../../common/components/common_footer.dart';
import '../../../common/components/product_card.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_mock_data.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  int selectedIndex = 0;

  final List<Map<String, String>> categories = [
    {"title": "All", "image": AppImages.shree},
    {"title": "New", "image": AppImages.new_icon},
    {"title": "Ghee", "image": AppImages.ghee},
    {"title": "Oil", "image": AppImages.oil},
    {"title": "Combo", "image": AppImages.combo},
    {"title": "On Sale", "image": AppImages.on_sale},
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40, child: Container(color: AppColors.blue_eef1ed)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            color: AppColors.blue_eef1ed,
            height: 150, // container + text
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final category = categories[index];
                final bool isSelected = selectedIndex == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                      // Trigger product list update here
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 88,
                        width: 88,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                isSelected
                                    ? Color(0xFF327801)
                                    : Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Image.asset(
                            category["image"]!,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        category["title"]!,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.grey_3C403D,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // so text aligns like your design
              children: [
                Text(
                  "SHOP",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: "Home ",
                        style: TextStyle(
                          color: AppColors.grey_3C403D,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ), // Home in black
                      ),
                      TextSpan(
                        text: "/ ",
                        style: TextStyle(
                          color: AppColors.red_CC0003,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ), // Slash in black
                      ),
                      TextSpan(
                        text: categories[selectedIndex]['title']!,
                        style: TextStyle(
                          color: AppColors.red_CC0003,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ), // Selected category in red
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // SizedBox(height: 40),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: AppMockData.mockProducts.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final screenWidth = MediaQuery.of(context).size.width;
              final cardWidth = screenWidth * 0.7;
              final product = AppMockData.mockProducts[index].copyWith();
              return SizedBox(
                width: cardWidth,
                child: ProductCard(model: product),
              );
            },
          ),
          SizedBox(height: 40),

          CommonFooter(),
        ],
      ),
    );
  }
}
