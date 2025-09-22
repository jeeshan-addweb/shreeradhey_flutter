import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/components/common_footer.dart';
import '../../../common/components/product_card.dart';

import '../../../common/components/product_shimmer.dart';
import '../../../constants/app_colors.dart';
import '../../shop/controller/shop_controller.dart';

class GheeScreen extends StatefulWidget {
  const GheeScreen({super.key});

  @override
  State<GheeScreen> createState() => _GheeScreenState();
}

class _GheeScreenState extends State<GheeScreen> {
  final ShopController controller = Get.put(ShopController());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchProducts("Ghee");
    });
  }

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
                  "Ghee",
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
                        style: TextStyle(color: AppColors.black),
                      ),
                      TextSpan(
                        text: "/ ",
                        style: TextStyle(color: AppColors.red_CC0003),
                      ),
                      TextSpan(
                        text: "Ghee",
                        style: TextStyle(color: AppColors.red_CC0003),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Obx(() {
            if (controller.isLoading.value) {
              // Show shimmer cards while loading
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: 5,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final screenWidth = MediaQuery.of(context).size.width;
                  final cardWidth = screenWidth * 0.7;
                  return SizedBox(
                    width: cardWidth,
                    child: const ProductCardShimmer(),
                  );
                },
              );
            }
            if (controller.error.isNotEmpty) {
              return Center(child: Text("Error: ${controller.error}"));
            }
            if (controller.products.isEmpty) {
              return const Center(child: Text("No Products Found"));
            }
            return ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: controller.products.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final screenWidth = MediaQuery.of(context).size.width;
                final cardWidth = screenWidth * 0.7;
                final product = controller.products[index];
                return SizedBox(
                  width: cardWidth,
                  child: ProductCard(model: product),
                );
              },
            );
          }),
          SizedBox(height: 40),

          CommonFooter(),
        ],
      ),
    );
  }
}
