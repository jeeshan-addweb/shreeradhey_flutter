import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_images.dart';

class ProductOverviewCard extends StatefulWidget {
  final String keyValue;
  final String productName;
  final String price;
  final String? imageUrl;
  final int quantity;
  final Function(int) onQuantityChanged;
  final VoidCallback onRemove;

  final String cartSubtotal;
  final String cartTotal;

  const ProductOverviewCard({
    super.key,
    required this.keyValue,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.onQuantityChanged,
    required this.onRemove,
    required this.cartSubtotal,
    required this.cartTotal,
    this.imageUrl,
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

  void _incrementQuantity() {
    setState(() {
      quantity++;
      widget.onQuantityChanged(quantity);
    });
  }

  void _decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        widget.onQuantityChanged(quantity);
      });
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
                      QuantitySelector(
                        quantity: quantity,
                        onIncrement: _incrementQuantity,
                        onDecrement: _decrementQuantity,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "₹${widget.price}",
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
            // CartSummarySection(
            //   subtotal: widget.cartSubtotal,
            //   total: widget.cartTotal,
            // ),

            // Dashed Divider
            // CustomPaint(
            //   size: const Size(double.infinity, 1),
            //   painter: _DashedLinePainter(color: Colors.grey),
            // ),
            // const SizedBox(height: 24),

            // // Subtotal
            // _PriceRow(title: "Subtotal", amount: "₹4,300.00"),

            // const SizedBox(height: 12),
            // Divider(height: 24),

            // const SizedBox(height: 12),

            // // Coupon Label
            // Text(
            //   "Enter Discount Coupon:",
            //   style: TextStyle(
            //     fontSize: 14,
            //     fontWeight: FontWeight.w400,
            //     color: AppColors.grey_212121,
            //   ),
            // ),
            // const SizedBox(height: 12),

            // // Coupon Code + Apply button combined
            // Container(
            //   decoration: BoxDecoration(
            //     border: Border.all(color: Colors.grey),
            //     borderRadius: BorderRadius.circular(6),
            //   ),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 8),
            //           child: TextField(
            //             decoration: const InputDecoration(
            //               hintText: "Coupon code",
            //               border: InputBorder.none,
            //             ),
            //           ),
            //         ),
            //       ),
            //       Container(
            //         height: 48,
            //         decoration: BoxDecoration(
            //           gradient: LinearGradient(
            //             colors: [
            //               AppColors.green_6cad10,
            //               AppColors.green_327801,
            //             ],
            //             begin: Alignment.topCenter,
            //             end: Alignment.bottomCenter,
            //           ),
            //           borderRadius: const BorderRadius.only(
            //             topRight: Radius.circular(4),
            //             topLeft: Radius.circular(6),
            //             bottomRight: Radius.circular(4),
            //             bottomLeft: Radius.circular(6),
            //           ),
            //         ),
            //         child: TextButton(
            //           onPressed: () {},
            //           child: const Text(
            //             "Apply",
            //             style: TextStyle(color: Colors.white),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            // const SizedBox(height: 12),

            // // Dropdown (Available Coupons)
            // DropdownButtonFormField<String>(
            //   hint: const Text("Availed Coupons"),
            //   items: const [
            //     DropdownMenuItem(value: "coupon1", child: Text("10% OFF")),
            //     DropdownMenuItem(
            //       value: "coupon2",
            //       child: Text("Free Shipping"),
            //     ),
            //   ],
            //   onChanged: (value) {},
            //   decoration: InputDecoration(
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(6),
            //     ),
            //     contentPadding: const EdgeInsets.symmetric(
            //       horizontal: 10,
            //       vertical: 8,
            //     ),
            //   ),
            // ),

            // const SizedBox(height: 12),

            // // Shipping Layout
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     const Expanded(
            //       child: Text(
            //         "Shipping",
            //         style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            //       ),
            //     ),
            //     Expanded(
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.end,
            //         children: [
            //           const Text(
            //             "Free shipping",
            //             style: TextStyle(fontSize: 12, color: Colors.black54),
            //           ),
            //           const Text(
            //             "Shipping options will be\nupdated during checkout.",
            //             textAlign: TextAlign.right,
            //             style: TextStyle(fontSize: 12, color: Colors.black54),
            //           ),
            //           GestureDetector(
            //             onTap: () {},
            //             child: const Text(
            //               "Calculate shipping",
            //               style: TextStyle(
            //                 fontSize: 12,
            //                 color: Color(0xFFE51900),
            //                 fontWeight: FontWeight.w500,
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),

            // const SizedBox(height: 12),
            // CustomPaint(
            //   size: const Size(double.infinity, 1),
            //   painter: _DashedLinePainter(color: Colors.grey),
            // ),

            // const SizedBox(height: 12),

            // // Total
            // _PriceRow(title: "Total", amount: "₹4,300.00"),

            // const SizedBox(height: 12),

            // // Checkout Button
            // Container(
            //   decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //       colors: [AppColors.green_6cad10, AppColors.green_327801],
            //       begin: Alignment.topCenter,
            //       end: Alignment.bottomCenter,
            //     ),
            //     borderRadius: BorderRadius.circular(8),
            //   ),
            //   child: ElevatedButton(
            //     onPressed: () {
            //       context.push(AppRoutePath.checkoutScreen);
            //     },
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.transparent,
            //       shadowColor: Colors.transparent,
            //       minimumSize: const Size.fromHeight(40),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(8),
            //       ),
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Text(
            //           'Checkout',
            //           style: TextStyle(color: AppColors.white, fontSize: 16),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

// Dashed Line Painter
class _DashedLinePainter extends CustomPainter {
  final Color color;
  _DashedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    const dashWidth = 5.0;
    const dashSpace = 3.0;
    double startX = 0;
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = 1;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Quantity Selector Widget
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

// Price Row Widget
class _PriceRow extends StatelessWidget {
  final String title;
  final String amount;

  const _PriceRow({required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
        Text(
          amount,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
