import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shree_radhey/features/auth/controller/auth_controller.dart';
import 'package:shree_radhey/features/home/controller/home_controller.dart';

import '../../../common/components/common_footer.dart';
import '../../../constants/app_colors.dart';

import '../controller/wishlist_controller.dart';
import 'components/banner_component.dart';

import 'components/blog_section.dart';
import 'components/core_valued_section.dart';
import 'components/feature_slider_component.dart';

import 'widgets/product_section_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = Get.put(HomeController(), permanent: true);
  final AuthController authcontroller = Get.put(
    AuthController(),
    permanent: true,
  );

  @override
  void initState() {
    super.initState();
    debugPrint("Token is : ${authcontroller.token}");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchHomeData();
      controller.fetchBlogs();
      controller.fetchHomePageData(context);
      final wishlistController = Get.find<WishlistController>();
      wishlistController.fetchWishlist();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            BannerComponent(),
            const SizedBox(height: 40),

            // ✅ Each section gets its own Obx
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Obx(
                () => ProductSection(
                  firstText: "BESTSELLERS",
                  firstTextColor: AppColors.red_b12704,
                  secondText: " | PURE JOY IN EVERY PICK",
                  sectionBgColor: AppColors.white,
                  tagText: "Best Seller",
                  secondTextColor: AppColors.black,
                  categoryText: "All",
                  products: controller.allProducts,
                  showShimmer: controller.isProductsLoading.value,
                ),
              ),
            ),

            const SizedBox(height: 20),
            Divider(height: 2, color: AppColors.grey),
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Obx(
                () => ProductSection(
                  firstText: "NEWLY LAUNCHED",
                  firstTextColor: AppColors.red_b12704,
                  secondText: " | CLEAN.FRESH.PURE",
                  sectionBgColor: AppColors.white,
                  tagText: "Newly Launch",
                  secondTextColor: AppColors.black,
                  categoryText: "New",
                  products: controller.newProducts,
                  showShimmer: controller.isProductsLoading.value,
                ),
              ),
            ),

            const SizedBox(height: 20),
            Container(height: 20, color: AppColors.pink_fffbec),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Obx(
                () => ProductSection(
                  firstText: "PURE LIKE DADI USED TO\nMAKE |",
                  firstTextColor: AppColors.black,
                  secondText: " GHEE SELECTION",
                  sectionBgColor: AppColors.pink_fffbec,
                  secondTextColor: AppColors.red_b12704,
                  tagText: "Best Seller",
                  categoryText: "Ghee",
                  products: controller.gheeProducts,
                  showShimmer: controller.isProductsLoading.value,
                ),
              ),
            ),

            Container(height: 20, color: AppColors.pink_fffbec),
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Obx(
                () => ProductSection(
                  firstText: "TRADITIONAL PURITY ,\nSEALED IN EVERY DROP |",
                  firstTextColor: AppColors.black,
                  secondText: " OIL COLLECTION",
                  sectionBgColor: AppColors.white,
                  tagText: "Best Seller",
                  secondTextColor: AppColors.red_b12704,
                  categoryText: "Oil",
                  products: controller.oilProducts,
                  showShimmer: controller.isProductsLoading.value,
                ),
              ),
            ),

            const SizedBox(height: 20),
            Divider(height: 2, color: AppColors.grey),
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Obx(
                () => ProductSection(
                  firstText: "TIMELESS GOODNESS,\nEVERYDAY READY |",
                  firstTextColor: AppColors.black,
                  secondText: " HEALTHY COMBOS",
                  sectionBgColor: AppColors.white,
                  tagText: "Newly Launch",
                  secondTextColor: AppColors.red_b12704,
                  categoryText: "Combo",
                  products: controller.comboProducts,
                  showShimmer: controller.isProductsLoading.value,
                ),
              ),
            ),

            const SizedBox(height: 40),
            const CoreValuedSection(),
            const SizedBox(height: 40),
            const FeatureSlider(),
            BlogSection(),
            const CommonFooter(),
          ],
        ),
      ),
    );
  }
}
