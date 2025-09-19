import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_images.dart';
import '../../../../utils/routes/app_route_path.dart';
import '../../controller/home_controller.dart';
import 'blog_card.dart';
import 'special_offer_card.dart';

class BlogSection extends StatelessWidget {
  BlogSection({super.key});
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isBlogsLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.hasError.value) {
        return Center(child: Text("Error: ${controller.errorMessage}"));
      }

      if (controller.blogs.isEmpty) {
        return const Center(child: Text("No blogs available"));
      }
      return Container(
        color: AppColors.pink_fffbec,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            SpecialOfferCard(
              imagePath:
                  controller.homePageData.value?.data?.specialOffer?.image ??
                  "Image not found",
              offerLabel:
                  controller.homePageData.value?.data?.specialOffer?.title ??
                  "No title",
              title:
                  controller.homePageData.value?.data?.specialOffer?.subtitle ??
                  "No subtitle",
              productName:
                  controller
                      .homePageData
                      .value
                      ?.data
                      ?.specialOffer
                      ?.productName ??
                  "Product name not found",
              onShopNow: () {
                debugPrint("Tapped");
                context.push(
                  AppRoutePath.productDetail,
                  // pathParameters: {'slug': widget.model.slug ?? ""},
                  extra: {
                    'hideNav': true,
                    'slug': "shree-radhey-a2-gir-cow-ghee-300-ml-274gm",
                    'category': "ghee",
                  },
                );
              },
            ),
            SizedBox(height: 40),
            // Section title
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8,
              ),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "BEYOND PRODUCTS, ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.red_b12704,
                        fontStyle: FontStyle.italic,
                        fontSize: 28,
                      ),
                    ),
                    TextSpan(
                      text: "INTO THE KITCHEN.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Blog list
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.blogs.length,
              separatorBuilder: (_, __) => const SizedBox(height: 20),
              itemBuilder: (context, index) {
                final blog = controller.blogs[index];
                return BlogCard(blogModel: blog);
              },
            ),

            const SizedBox(height: 12),

            // View All Blogs button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 250, // button never exceeds this
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.green_6cad10,
                          AppColors.green_327801,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        context.push(AppRoutePath.bloglistingScreen);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        minimumSize: const Size.fromHeight(40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize:
                            MainAxisSize.min, // 👈 prevents stretching
                        children: [
                          Text(
                            'View All Blogs',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Icon(
                            Icons.arrow_forward,
                            color: AppColors.white,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            if (controller.pageInfo.value?.hasNextPage == true)
              controller.isLoadingMore.value
                  ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: CircularProgressIndicator()),
                  )
                  : TextButton(
                    onPressed: controller.loadMoreBlogs,
                    child: const Text("Load More"),
                  ),

            SizedBox(height: 40),
          ],
        ),
      );
    });
  }
}
