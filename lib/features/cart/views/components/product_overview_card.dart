import 'package:flutter/material.dart';
import 'package:shree_radhey/common/components/line_shimmer.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_images.dart';

class ProductOverviewCard extends StatefulWidget {
  final String currencySymbol;
  final String keyValue;
  final String productName;
  final String price;
  final String? imageUrl;
  final int quantity;
  final Function(int) onQuantityChanged;
  final VoidCallback onRemove;

  final String cartSubtotal;
  final String cartTotal;
  final bool isLoading;

  const ProductOverviewCard({
    super.key,
    required this.keyValue,
    required this.currencySymbol,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.onQuantityChanged,
    required this.onRemove,
    required this.cartSubtotal,
    required this.cartTotal,
    this.imageUrl,
    this.isLoading = false,
  });

  @override
  State<ProductOverviewCard> createState() => _ProductOverviewCardState();
}

class _ProductOverviewCardState extends State<ProductOverviewCard> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.quantity;
  }

  @override
  void didUpdateWidget(covariant ProductOverviewCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.quantity != widget.quantity) {
      setState(() {
        quantity = widget.quantity;
      });
    }
  }

  void _incrementQuantity() {
    if (widget.isLoading) return;
    setState(() {
      quantity++;
      widget.onQuantityChanged(quantity);
    });
  }

  void _decrementQuantity() {
    if (widget.isLoading) return;
    if (quantity > 1) {
      setState(() {
        quantity--;
        widget.onQuantityChanged(quantity);
      });
    } else {
      // 👇 instead of going to 0, remove from cart
      widget.onRemove();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Product Overview",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.grey_65758b,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child:
                      widget.imageUrl != null
                          ? Image.network(
                            widget.imageUrl!,
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          )
                          : Image.asset(
                            AppImages.product_image,
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.productName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 6),
                      widget.isLoading
                          ? LineShimmer()
                          : QuantitySelector(
                            quantity: quantity,
                            onIncrement: _incrementQuantity,
                            onDecrement: _decrementQuantity,
                          ),
                      const SizedBox(width: 8),

                      // show small spinner when this item is updating
                      const SizedBox(height: 6),
                      Text(
                        "${widget.currencySymbol}${widget.price}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.blue_2da5f3,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: widget.onRemove,
                  icon: Icon(
                    Icons.close,
                    size: 22,
                    color: AppColors.red_CC0003,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _QuantityBox(
          child: IconButton(
            icon: const Icon(Icons.remove, size: 16),
            onPressed: onDecrement,
          ),
        ),
        const SizedBox(width: 4),
        _QuantityBox(
          child: Text(
            quantity.toString(),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(width: 4),
        _QuantityBox(
          child: IconButton(
            icon: const Icon(Icons.add, size: 16),
            onPressed: onIncrement,
          ),
        ),
      ],
    );
  }
}

// Reusable Box
class _QuantityBox extends StatelessWidget {
  final Widget child;

  const _QuantityBox({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 32,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(6),
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}
