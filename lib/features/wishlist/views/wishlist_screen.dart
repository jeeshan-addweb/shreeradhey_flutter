import 'package:flutter/material.dart';

import '../../../common/components/common_footer.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_mock_data.dart';
import '../../home/views/widgets/product_section_widget.dart';
import 'components/wishlist_product_card.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
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
                child: WishlistProductCard(
                  model: product,
                  onAddToCart: () {},
                  onRemove: () {},
                ),
              );
            },
          ),
          SizedBox(height: 20),
          ProductSection(
            firstText: "",
            firstTextColor: AppColors.black,
            secondTextColor: AppColors.black,
            secondText: "Similar Products".toUpperCase(),
            sectionBgColor: AppColors.white,
            tagText: "Best Seller",
          ),
          SizedBox(height: 20),
          CommonFooter(),
        ],
      ),
    );
  }
}
