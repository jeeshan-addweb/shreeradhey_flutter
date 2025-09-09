import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../constants/app_colors.dart';
import '../../controller/home_controller.dart';

class FeatureSlider extends StatefulWidget {
  const FeatureSlider({super.key});

  @override
  State<FeatureSlider> createState() => _FeatureSliderState();
}

class _FeatureSliderState extends State<FeatureSlider> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  final controller = Get.find<HomeController>();

  // final List<Map<String, String>> _features = [
  //   {
  //     "icon": "🍃",
  //     "title": "Organic Products",
  //     "desc":
  //         "Our food products are completely free of artificial fertilizers and additives.",
  //   },
  //   {
  //     "icon": "🚚",
  //     "title": "Free Shipping",
  //     "desc":
  //         "Our sole motive is to ensure hassle-free doorstep delivery of purely organic products to customers.",
  //   },
  //   {
  //     "icon": "💰",
  //     "title": "Quality Assurance",
  //     "desc":
  //         "For any hassales we have a 24x7 support team to assist you with your queries.",
  //   },
  // ];
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), autoSlide);
  }

  void autoSlide() {
    if (_pageController.hasClients) {
      final nextPage = (_currentIndex + 1) % controller.psaOptions.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      Future.delayed(const Duration(seconds: 3), autoSlide);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final features = controller.psaOptions;

      if (controller.isProductsLoading.value && features.isEmpty) {
        return const Padding(
          padding: EdgeInsets.all(24.0),
          child: CircularProgressIndicator(),
        );
      }

      if (features.isEmpty) {
        return const Text("No commitments available");
      }
      return Container(
        color: AppColors.pink_fffbec,
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 180,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemCount: features.length,
                itemBuilder: (context, index) {
                  final item = features[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.network(item.image ?? ""),
                      const SizedBox(height: 12),
                      Text(
                        item.title ?? "",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          item.text ?? "",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.grey_212121,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(features.length, (index) {
                bool isActive = index == _currentIndex;
                return GestureDetector(
                  onTap:
                      () => _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      ),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isActive ? 12 : 8,
                    height: isActive ? 12 : 8,
                    decoration: BoxDecoration(
                      color:
                          isActive
                              ? Colors.grey.shade600
                              : Colors.grey.shade400,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      );
    });
  }
}
