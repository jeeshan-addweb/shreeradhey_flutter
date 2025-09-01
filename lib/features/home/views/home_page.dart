import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shree_radhey/features/home/controller/home_controller.dart';

import '../../../common/components/common_footer.dart';
import '../../../common/components/product_shimmer.dart';
import '../../../constants/app_colors.dart';

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
  final HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    controller.fetchHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Obx(() {
        if (controller.isLoading.value) {
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount:
                controller.allProducts.length, // number of shimmer placeholders
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final screenWidth = MediaQuery.of(context).size.width;
              final cardWidth = screenWidth * 0.7;
              return SizedBox(
                width: cardWidth,
                child:
                    const ProductCardShimmer(), // 👈 use your shimmer widget here
              );
            },
          );
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              BannerComponent(),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ProductSection(
                  firstText: "BESTSELLERS",
                  firstTextColor: AppColors.red_b12704,
                  secondText: " | PURE JOY IN EVERY PICK",
                  sectionBgColor: AppColors.white,
                  tagText: "Best Seller",
                  secondTextColor: AppColors.black,
                  categoryText: "All",
                  products: controller.allProducts,
                ),
              ),
              SizedBox(height: 20),
              Divider(height: 2, color: AppColors.grey),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ProductSection(
                  firstText: "NEWLY LAUNCHED",
                  firstTextColor: AppColors.red_b12704,
                  secondText: " | CLEAN.FRESH.PURE",
                  sectionBgColor: AppColors.white,
                  tagText: "Newly Launch",
                  secondTextColor: AppColors.black,
                  categoryText: "New",
                  products: controller.newProducts,
                ),
              ),

              SizedBox(height: 20),

              SizedBox(
                height: 20,
                child: Container(color: AppColors.pink_fffbec),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ProductSection(
                  firstText: "PURE LIKE DADI USED TO\nMAKE |",
                  firstTextColor: AppColors.black,
                  secondText: " GHEE SELECTION",
                  sectionBgColor: AppColors.pink_fffbec,
                  secondTextColor: AppColors.red_b12704,
                  tagText: "Best Seller",
                  categoryText: "Ghee",
                  products: controller.gheeProducts,
                ),
              ),
              SizedBox(
                height: 20,
                child: Container(color: AppColors.pink_fffbec),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ProductSection(
                  firstText: "TRADITIONAL PURITY ,\nSEALED IN EVERY DROP |",
                  firstTextColor: AppColors.black,
                  secondText: " OIL COLLECTION",
                  sectionBgColor: AppColors.white,
                  tagText: "Best Seller",
                  secondTextColor: AppColors.red_b12704,
                  categoryText: "Oil",
                  products: controller.oilProducts,
                ),
              ),
              SizedBox(height: 20),
              Divider(height: 2, color: AppColors.grey),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ProductSection(
                  firstText: "TIMELESS GOODNESS,\nEVERYDAY READY |",
                  firstTextColor: AppColors.black,
                  secondText: " HEALTHY COMBOS",
                  sectionBgColor: AppColors.white,
                  tagText: "Newly Launch",
                  secondTextColor: AppColors.red_b12704,
                  categoryText: "Combo",
                  products: controller.comboProducts,
                ),
              ),
              SizedBox(height: 40),
              CoreValuedSection(),
              SizedBox(height: 40),
              FeatureSlider(),

              BlogSection(),

              CommonFooter(),
            ],
          ),
        );
      }),
    );
  }
}
