import 'package:flutter/material.dart';

import '../../../common/components/common_footer.dart';
import '../../../common/components/product_card.dart';

import '../../../constants/app_mock_data.dart';

class BestSellerScreen extends StatefulWidget {
  const BestSellerScreen({super.key});

  @override
  State<BestSellerScreen> createState() => _BestSellerScreenState();
}

class _BestSellerScreenState extends State<BestSellerScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // so text aligns like your design
              children: [
                Text(
                  "Best Sellers",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                Text(
                  "Home / Best Sellers",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.red, // like your design's breadcrumb
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
