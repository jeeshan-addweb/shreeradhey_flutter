import 'package:flutter/material.dart';

import '../../../../common/components/product_card.dart';
import '../../../../common/components/product_shimmer.dart';
import '../../../../common/model/ui_product_model.dart';
import '../../../../constants/app_colors.dart';

class ProductSection extends StatefulWidget {
  final String firstText;
  final Color firstTextColor;
  final String secondText;
  final Color secondTextColor;
  final Color sectionBgColor;
  final String tagText;
  final String? categoryText;
  final bool showShimmer;
  final List<UiProductModel> products; // 👈 only UI models passed

  const ProductSection({
    super.key,
    required this.firstText,
    required this.firstTextColor,
    required this.secondTextColor,
    required this.secondText,
    required this.sectionBgColor,
    required this.tagText,
    this.categoryText,
    required this.products,
    this.showShimmer = false, // 👈 default false
  });

  @override
  State<ProductSection> createState() => _ProductSectionState();
}

class _ProductSectionState extends State<ProductSection> {
  final ScrollController _scrollController = ScrollController();
  // late ShopController controller;
  bool isAtStart = true;
  bool isAtEnd = false;

  void scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 320,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 320,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollListener() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final current = _scrollController.offset;

    setState(() {
      isAtStart = current <= 0;
      isAtEnd = current >= maxScroll;
    });
  }

  @override
  void initState() {
    super.initState();
    // controller = ShopController();
    // controller.fetchProducts(widget.categoryText ?? "All");
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cardHeight = MediaQuery.of(context).size.width * 1.4;
    return Container(
      color: widget.sectionBgColor,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Heading
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: widget.firstText,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: widget.firstTextColor,
                      fontStyle:
                          widget.firstTextColor == AppColors.red_b12704
                              ? FontStyle.italic
                              : FontStyle.normal,
                      fontSize: 28,
                    ),
                  ),
                  TextSpan(
                    text: widget.secondText,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: widget.secondTextColor,
                      fontStyle:
                          widget.secondTextColor == AppColors.red_b12704
                              ? FontStyle.italic
                              : FontStyle.normal,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Carousel
          SizedBox(
            height: cardHeight,
            child: ListView.separated(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount:
                  widget.showShimmer
                      ? 4 // show 4 placeholders
                      : widget.products.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final screenWidth = MediaQuery.of(context).size.width;
                final cardWidth = screenWidth * 0.7;

                return SizedBox(
                  width: cardWidth,
                  child:
                      widget.showShimmer
                          ? const ProductCardShimmer()
                          : ProductCard(model: widget.products[index]),
                );
              },
            ),
          ),
          const SizedBox(height: 20),

          // Scroll Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildArrowButton(Icons.arrow_back_ios, isAtStart, scrollLeft),
              const SizedBox(width: 16),
              _buildArrowButton(Icons.arrow_forward_ios, isAtEnd, scrollRight),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildArrowButton(IconData icon, bool disabled, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: IconButton(
        icon: Icon(icon, size: 18),
        onPressed: disabled ? null : onTap,
      ),
    );
  }
}
