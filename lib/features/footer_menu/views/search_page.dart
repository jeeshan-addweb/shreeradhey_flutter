import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shree_radhey/common/search_product_controller.dart';

import '../../../common/components/common_footer.dart';
import '../../../common/components/product_card.dart';
import '../../../common/components/product_shimmer.dart';
import '../../../constants/app_colors.dart';

class SearchPage extends StatefulWidget {
  final String query;

  const SearchPage({super.key, required this.query});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchProductController controller = Get.put(SearchProductController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.searchProducts(widget.query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const ProductCardShimmer();
        }

        // if (controller.searchResults.isEmpty) {
        //   return Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       const SizedBox(height: 100),
        //       Text(
        //         "No products found for \"${widget.query}\"",
        //         style: const TextStyle(
        //           fontSize: 16,
        //           fontWeight: FontWeight.w500,
        //         ),
        //       ),
        //       const SizedBox(height: 20),
        //       const CommonFooter(),
        //     ],
        //   );
        // }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// --- Heading + Breadcrumb ---
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Search Results for '${widget.query}'",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    // RichText(
                    //   text: TextSpan(
                    //     style: const TextStyle(
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.w500,
                    //     ),
                    //     children: [
                    //       TextSpan(
                    //         text: "Home ",
                    //         style: TextStyle(color: AppColors.black),
                    //       ),
                    //       TextSpan(
                    //         text: "/ ",
                    //         style: TextStyle(color: AppColors.red_CC0003),
                    //       ),
                    //       TextSpan(
                    //         text: "Shop ",
                    //         style: TextStyle(color: AppColors.black),
                    //       ),
                    //       TextSpan(
                    //         text: "/ ",
                    //         style: TextStyle(color: AppColors.red_CC0003),
                    //       ),
                    //       TextSpan(
                    //         text: "Search Results for '${widget.query}'",
                    //         style: TextStyle(color: AppColors.red_CC0003),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              controller.searchResults.isEmpty
                  ? Center(
                    child: Text(
                      "No result found for ${widget.query}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                  : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: controller.searchResults.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final product = controller.searchResults[index];
                      final screenWidth = MediaQuery.of(context).size.width;
                      final cardWidth = screenWidth * 0.7;

                      return SizedBox(
                        width: cardWidth,
                        child: ProductCard(model: product),
                      );
                    },
                  ),

              const SizedBox(height: 40),
              const CommonFooter(),
            ],
          ),
        );
      }),
    );
  }
}
