import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shree_radhey/common/components/banner_shimmer.dart';
import 'package:shree_radhey/common/components/product_shimmer.dart';

import '../../../../constants/app_colors.dart';
import '../../controller/home_controller.dart';

class BannerComponent extends StatefulWidget {
  @override
  _BannerComponentState createState() => _BannerComponentState();
}

class _BannerComponentState extends State<BannerComponent> {
  Timer? _autoScrollTimer;
  final PageController _controller = PageController();
  int _currentPage = 0;

  // final List<String> imageUrls = [
  //   "https://images.unsplash.com/photo-1657206456366-ac81460011ee?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8ZGFpcnklMjBmYXJtfGVufDB8fDB8fHww",
  //   "https://images.unsplash.com/photo-1629313472434-cbbfdc2e1a5f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8ZGFpcnklMjBmYXJtfGVufDB8fDB8fHww",
  //   "https://images.unsplash.com/photo-1573731399281-6540bc50ed91?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8ZGFpcnklMjBmYXJtfGVufDB8fDB8fHww",
  // ];

  @override
  void initState() {
    super.initState();

    _autoScrollTimer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      final images =
          Get.find<HomeController>().bannerImages; // read from controller
      if (images.isEmpty) return;
      if (_currentPage < images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0; // loop back to first
      }

      _controller.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Obx(() {
      final images = controller.bannerImages;

      if (images.isEmpty) {
        return const SizedBox(height: 170, child: BannerShimmer());
      }
      return SizedBox(
        height: 200,
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: images.length,

              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              itemBuilder: (context, index) {
                return Stack(
                  fit: StackFit.expand,
                  children: [Image.network(images[index], fit: BoxFit.cover)],
                );
              },
            ),

            // Left Button
            Positioned(
              left: 4,
              top: 80,
              child: _navButton(
                Icons.arrow_back_ios,
                _prevPage,
                disabled: _currentPage == 0,
              ),
            ),

            // Right Button
            Positioned(
              right: 4,
              top: 80,
              child: _navButton(
                Icons.arrow_forward_ios,
                _nextPage,
                disabled: _currentPage == images.length - 1,
              ),
            ),
          ],
        ),
      );
    });
  }

  void _nextPage() {
    final images = Get.find<HomeController>().bannerImages;
    if (_currentPage < images.length - 1) {
      _currentPage++;
      _controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      _currentPage--;
      _controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget _navButton(
    IconData icon,
    VoidCallback onPressed, {
    bool disabled = false,
  }) {
    return IconButton(
      icon: Icon(
        icon,
        size: 30,
        color: disabled ? Colors.grey[400] : AppColors.white,
      ),
      onPressed: disabled ? null : onPressed,
    );
  }
}
