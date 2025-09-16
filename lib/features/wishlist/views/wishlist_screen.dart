import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shree_radhey/common/components/product_shimmer.dart';
import 'package:shree_radhey/features/home/controller/wishlist_controller.dart';

import '../../../common/components/common_footer.dart';
import '../../../constants/app_colors.dart';
import '../../cart/controller/cart_controller.dart';
import '../../home/controller/home_controller.dart';
import '../../home/views/widgets/product_section_widget.dart';
import 'components/wishlist_product_card.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final WishlistController wishlistController = Get.put(WishlistController());
  final HomeController controller = Get.put(HomeController(), permanent: true);
  final CartController cartController = Get.put(CartController());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      wishlistController.fetchWishlist();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // so text aligns like your design
              children: [
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
                        text: "Wishlist",
                        style: TextStyle(color: AppColors.red_CC0003),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),
                Text(
                  "MY WISHLIST",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          Obx(() {
            if (wishlistController.isLoading.value) {
              return ProductCardShimmer(height: 500);
            }

            if (wishlistController.wishlist.isEmpty) {
              return Center(child: const Text("No items in wishlist"));
            }

            return ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: wishlistController.wishlist.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final screenWidth = MediaQuery.of(context).size.width;
                final cardWidth = screenWidth * 0.7;
                final product = wishlistController.wishlist[index];
                return SizedBox(
                  width: cardWidth,
                  child: WishlistProductCard(model: product),
                );
              },
            );
          }),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ProductSection(
              firstText: "",
              firstTextColor: AppColors.black,
              secondTextColor: AppColors.black,
              secondText: "Similar Products".toUpperCase(),
              sectionBgColor: AppColors.white,
              tagText: "Best Seller",
              products: controller.allProducts,
            ),
          ),
          SizedBox(height: 20),
          CommonFooter(),
        ],
      ),
    );
  }
}
