import 'package:flutter/material.dart';

import '../../../../common/components/product_card.dart';
import '../../../../constants/app_mock_data.dart';

class ProductSection extends StatefulWidget {
  final String firstText;
  final Color firstTextColor;
  final String secondText;
  final Color secondTextColor;
  final Color sectionBgColor;
  final String tagText;

  const ProductSection({
    super.key,
    required this.firstText,
    required this.firstTextColor,
    required this.secondTextColor,
    required this.secondText,
    required this.sectionBgColor,
    required this.tagText,
  });

  @override
  State<ProductSection> createState() => _ProductSectionState();
}

class _ProductSectionState extends State<ProductSection> {
  final ScrollController _scrollController = ScrollController();
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
                      fontStyle: FontStyle.italic,
                      fontSize: 28,
                    ),
                  ),
                  TextSpan(
                    text: widget.secondText,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: widget.secondTextColor,
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
            height: MediaQuery.sizeOf(context).height * 0.54,
            child: ListView.separated(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: AppMockData.mockProducts.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final product = AppMockData.mockProducts[index].copyWith(
                  tagText: widget.tagText,
                );
                return SizedBox(width: 270, child: ProductCard(model: product));
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
