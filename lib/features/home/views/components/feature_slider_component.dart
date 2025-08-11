import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';

class FeatureSlider extends StatefulWidget {
  const FeatureSlider({super.key});

  @override
  State<FeatureSlider> createState() => _FeatureSliderState();
}

class _FeatureSliderState extends State<FeatureSlider> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _features = [
    {
      "icon": "🍃",
      "title": "Organic Products",
      "desc":
          "Our food products are completely free of artificial fertilizers and additives.",
    },
    {
      "icon": "🚚",
      "title": "Free Shipping",
      "desc":
          "Our sole motive is to ensure hassle-free doorstep delivery of purely organic products to customers.",
    },
    {
      "icon": "💰",
      "title": "Quality Assurance",
      "desc":
          "For any hassales we have a 24x7 support team to assist you with your queries.",
    },
  ];

  @override
  Widget build(BuildContext context) {
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
              itemCount: _features.length,
              itemBuilder: (context, index) {
                final item = _features[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(item["icon"]!, style: const TextStyle(fontSize: 40)),
                    const SizedBox(height: 12),
                    Text(
                      item["title"]!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        item["desc"]!,
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
            children: List.generate(_features.length, (index) {
              bool isActive = index == _currentIndex;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: isActive ? 12 : 8,
                height: isActive ? 12 : 8,
                decoration: BoxDecoration(
                  color: isActive ? Colors.grey.shade600 : Colors.grey.shade400,
                  shape: BoxShape.circle,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
