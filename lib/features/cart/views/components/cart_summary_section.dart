import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shree_radhey/features/cart/controller/cart_controller.dart';

import '../../../../constants/app_colors.dart';
import '../../../../utils/routes/app_route_path.dart';
import '../../controller/coupon_controller.dart';

class CartSummarySection extends StatelessWidget {
  final String subtotal;
  final String total;

  CartSummarySection({super.key, required this.subtotal, required this.total});
  final couponController = Get.put(CouponController());
  final cartController = Get.find<CartController>();
  final TextEditingController couponControllerText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        CustomPaint(
          size: const Size(double.infinity, 1),
          painter: _DashedLinePainter(color: Colors.grey),
        ),
        const SizedBox(height: 24),

        _PriceRow(title: "Subtotal", amount: "₹$subtotal"),

        const SizedBox(height: 12),
        Divider(height: 24),
        const SizedBox(height: 12),

        // Coupon section
        Text(
          "Enter Discount Coupon:",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.grey_212121,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Obx(() {
            if (cartController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            return Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: TextField(
                      controller: couponControllerText,
                      decoration: InputDecoration(
                        hintText: "Coupon code",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.green_6cad10, AppColors.green_327801],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(4),
                      bottomRight: Radius.circular(4),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      final code = couponControllerText.text.trim();
                      if (code.isNotEmpty) {
                        cartController.applyCoupon(code);
                      }
                    },
                    child: const Text(
                      "Apply",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),

        const SizedBox(height: 12),

        // Obx(() {
        //   final appliedCoupons =
        //       cartController.cart.value?.data?.cart?.appliedCoupons;
        //   if (appliedCoupons == null || appliedCoupons.isEmpty) {
        //     return const SizedBox.shrink();
        //   }

        //   return Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children:
        //         appliedCoupons.map((c) {
        //           return Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Text(
        //                 "Applied Coupon: ${c['code']} - ₹${c['discountAmount']}",
        //               ),
        //               TextButton(
        //                 onPressed: () => cartController.removeCoupon(c['code']),
        //                 child: const Text("Remove"),
        //               ),
        //             ],
        //           );
        //         }).toList(),
        //   );
        // }),
        Obx(() {
          if (couponController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (couponController.errorMessage.isNotEmpty) {
            return Text("Error: ${couponController.errorMessage.value}");
          }
          if (couponController.coupons.isEmpty) {
            return const Text("No coupons available");
          }

          return DropdownButtonFormField<String>(
            hint: const Text("Available Coupons"),
            items:
                couponController.coupons.map((coupon) {
                  return DropdownMenuItem(
                    value: coupon.code,
                    child: Text(
                      "${coupon.code} ",
                      // - ${coupon.amount}${coupon.discountType == "percent" ? "%" : "₹"}",
                    ),
                  );
                }).toList(),
            onChanged: (value) {
              debugPrint("Selected coupon: $value");
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
            ),
          );
        }),

        const SizedBox(height: 12),

        // Shipping
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Text(
                "Shipping",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text(
                    "Free shipping",
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  Text(
                    "Shipping options will be\nupdated during checkout.",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  Text(
                    "Calculate shipping",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFFE51900),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),
        CustomPaint(
          size: const Size(double.infinity, 1),
          painter: _DashedLinePainter(color: Colors.grey),
        ),
        const SizedBox(height: 12),

        _PriceRow(title: "Total", amount: "₹$total"),

        const SizedBox(height: 12),

        // Checkout Button
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.green_6cad10, AppColors.green_327801],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ElevatedButton(
            onPressed: () {
              context.push(AppRoutePath.checkoutScreen);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              minimumSize: const Size.fromHeight(40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              "Checkout",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ],
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
