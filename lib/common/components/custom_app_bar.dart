import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';
import '../../features/auth/controller/auth_controller.dart';
import '../../features/cart/controller/cart_controller.dart';
import '../../utils/routes/app_route_path.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool isDrawerOpen;
  final VoidCallback onMenuTap;

  const CustomAppBar({
    super.key,
    required this.isDrawerOpen,
    required this.onMenuTap,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 50);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  final auth = Get.find<AuthController>();

  void _startSearch() {
    setState(() => isSearching = true);
  }

  void _stopSearch() {
    setState(() {
      isSearching = false;
      _searchController.clear();
    });
  }

  void _onSearchSubmit(String query) {
    if (query.trim().isNotEmpty) {
      context.push(
        AppRoutePath.searchPage,
        extra: query.trim(), // Pass search term to SearchPage
      );
      _stopSearch();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 42, child: Container(color: AppColors.green_6cad10)),
        Container(
          height: kToolbarHeight + 20,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              // Drawer/Menu button
              Builder(
                builder:
                    (context) => IconButton(
                      padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                      icon: Icon(
                        widget.isDrawerOpen ? Icons.close : Icons.menu,
                        size: 30,
                      ),
                      onPressed: widget.onMenuTap,
                    ),
              ),

              // Logo (hidden if searching)
              if (!isSearching) Image.asset(AppImages.logo, height: 40),

              const Spacer(),

              // --- Search Mode ---
              if (isSearching) ...[
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: "Search products...",
                      prefixIcon: const Icon(Icons.search, color: Colors.black),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.close, color: Colors.black),
                        onPressed: _stopSearch,
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    ),
                    textInputAction: TextInputAction.search,
                    onSubmitted: _onSearchSubmit,
                  ),
                ),
              ]
              // --- Normal Mode ---
              else ...[
                GestureDetector(
                  onTap: _startSearch,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Image.asset(
                      AppImages.search,
                      color: AppColors.black,
                      height: 30,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => context.push(AppRoutePath.wishlistScreen),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Image.asset(
                      AppImages.wishlist,
                      color: AppColors.black,
                      height: 30,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (auth.isGuest) {
                      // Navigate to login with go_router
                      context.push(AppRoutePath.login);
                      return;
                    }
                    context.push(AppRoutePath.accountPage);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Image.asset(
                      AppImages.profile,
                      color: AppColors.black,
                      height: 30,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => context.push(AppRoutePath.cartPage),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Image.asset(
                          AppImages.cart,
                          color: AppColors.black,
                          height: 30,
                        ),
                      ),
                      Obx(() {
                        final count =
                            Get.find<CartController>().cartCount.value;
                        if (count == 0) return const SizedBox.shrink();

                        return Positioned(
                          right: 4,
                          top: 0,
                          child: CircleAvatar(
                            radius: 8,
                            backgroundColor: AppColors.green_5b9d0b,
                            child: Text(
                              count.toString(),
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
        const TopBannerToggle(),
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
