import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';
import '../../utils/routes/app_route_path.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final List<String> icons = [
    AppImages.home,
    AppImages.shopping,
    AppImages.deals,
    AppImages.cart,
    AppImages.menu,
  ];

  final List<String> labels = const ["Home", "Shop", "Deals", "Cart", "Menu"];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      padding: EdgeInsets.zero,
      elevation: 8,
      color: Colors.white,
      child: Container(
        // padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            labels.length,
            (index) => buildNavItem(context, index),
          ),
        ),
      ),
    );
  }

  Widget buildNavItem(BuildContext context, int index) {
    final bool isSelected = index == currentIndex;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          switch (index) {
            case 0:
              context.go(AppRoutePath.homeScreen);
              break;
            case 1:
              context.go(AppRoutePath.shopScreen, extra: 0); // All
              break;
            case 2:
              context.go(AppRoutePath.shopScreen, extra: 5); // All
              break;
            case 3:
              context.go(AppRoutePath.cartPage);
              break;
            case 4:
              // context.go(AppRoutePath.moreScreen);
              break;
          }
        },
        child: Container(
          height: double.infinity,
          decoration:
              isSelected
                  ? BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.green_327801, AppColors.green_6cad10],
                    ),
                  )
                  : null,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (index == 3)
                Stack(
                  children: [
                    Image.asset(
                      icons[index],
                      width: 25,
                      height: 25,
                      color: isSelected ? Colors.white : Colors.grey[700],
                    ),
                    Positioned(
                      right: -2,
                      top: -2,
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: AppColors.green_5b9d0b,
                        child: const Text(
                          "2",
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )
              else
                Image.asset(
                  icons[index],
                  width: 25,
                  height: 25,
                  color: isSelected ? Colors.white : Colors.grey[700],
                ),
              const SizedBox(height: 4),
              Text(
                labels[index],
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                  color: isSelected ? AppColors.white : AppColors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
