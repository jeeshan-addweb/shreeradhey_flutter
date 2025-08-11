import 'dart:async';

import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isDrawerOpen;
  final VoidCallback onMenuTap;
  const CustomAppBar({
    super.key,
    required this.isDrawerOpen,
    required this.onMenuTap,
  });
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 50); // adjust height if needed

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 40),
        TopBannerToggle(),
        Container(
          height: kToolbarHeight + 20,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Builder(
                builder:
                    (context) => IconButton(
                      icon: Icon(
                        isDrawerOpen ? Icons.close : Icons.menu,
                        size: 30,
                      ),
                      onPressed: onMenuTap,
                    ),
              ),

              // Logo
              Image.asset(AppImages.logo, height: 40),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Icon(
                  Icons.search_outlined,
                  color: AppColors.black,
                  size: 30,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Icon(
                  Icons.favorite_border_outlined,
                  color: AppColors.black,
                  size: 30,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Icon(
                  Icons.person_outlined,
                  color: AppColors.black,
                  size: 30,
                ),
              ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Image.asset(
                      AppImages.cart,
                      color: AppColors.black,
                      height: 30,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: AppColors.green_327801,
                      child: Text(
                        "0",
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TopBannerToggle extends StatefulWidget {
  const TopBannerToggle({super.key});

  @override
  State<TopBannerToggle> createState() => _TopBannerToggleState();
}

class _TopBannerToggleState extends State<TopBannerToggle> {
  int _currentIndex = 0;

  final List<String> _messages = [
    "Free Shipping All over India.",
    "Enjoy FLAT 15% OFF | Use Code : SHREE15",
  ];

  @override
  void initState() {
    super.initState();

    // Toggle message every 3 seconds
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted) return;
      setState(() {
        _currentIndex = (_currentIndex + 1) % _messages.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.green_327801, AppColors.green_6cad10],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      alignment: Alignment.center,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: Text(
          _messages[_currentIndex],
          key: ValueKey(_messages[_currentIndex]), // important!
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
