import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shree_radhey/common/components/line_shimmer.dart';
import 'package:shree_radhey/common/components/product_shimmer.dart';
import 'package:shree_radhey/features/cart/controller/cart_controller.dart';

import '../../../../constants/app_colors.dart';
import '../../../../utils/routes/app_route_path.dart';
import '../../controller/coupon_controller.dart';

class CartSummarySection extends StatefulWidget {
  final String subtotal;
  final String total;
  final String currencySymbol;

  CartSummarySection({
    super.key,
    required this.subtotal,
    required this.total,
    required this.currencySymbol,
  });

  @override
  State<CartSummarySection> createState() => _CartSummarySectionState();
}

class _CartSummarySectionState extends State<CartSummarySection> {
  final couponController = Get.put(CouponController());

  final cartController = Get.find<CartController>();

  @override
  void initState() {
    super.initState();
    cartController.fetchAvailableShippingMethod();
  }

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

        _PriceRow(
          title: "Subtotal",
          amount: "${widget.currencySymbol}${widget.subtotal}",
        ),

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
              return const LineShimmer(height: 30);
            }
            return Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: TextField(
                      controller: cartController.couponControllerText,
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
                  child: Obx(() {
                    final applied = cartController.appliedCoupon.value;
                    return TextButton(
                      onPressed: () {
                        if (applied != null) {
                          // remove coupon
                          cartController.removeCoupon(applied, context);
                          cartController.couponControllerText.clear();
                        } else {
                          // apply coupon
                          final code =
                              cartController.couponControllerText.text.trim();
                          if (code.isNotEmpty) {
                            cartController.applyCoupon(code, context);
                          }
                        }
                      },
                      child: Text(
                        applied != null ? "Remove" : "Apply",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }),
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
            return const LineShimmer(height: 30);
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
              if (value != null) {
                cartController.applyCoupon(value, context);
              }
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
              child: Obx(() {
                if (cartController.isLoading.value) {
                  return const Text(
                    "Loading shipping options...",
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  );
                }

                if (cartController.errorMessage.isNotEmpty) {
                  return Text(
                    cartController.errorMessage.value,
                    style: const TextStyle(fontSize: 12, color: Colors.red),
                  );
                }

                if (cartController.shippingMethod.isEmpty ||
                    cartController.shippingMethod.first.rates == null ||
                    cartController.shippingMethod.first.rates!.isEmpty) {
                  return const Text(
                    "No shipping methods available",
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  );
                }

                final rate = cartController.shippingMethod.first.rates!.first;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      rate.label ?? "Unknown",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                    // Text(
                    //   rate.cost != null
                    //       ? "₹${rate.cost}" // if cost present
                    //       : "Shipping options will be\nupdated during checkout.",
                    //   textAlign: TextAlign.right,
                    //   style: const TextStyle(fontSize: 12, color: Colors.black54),
                    // ),
                    const Text(
                      "Calculate shipping",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFFE51900),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),

        const SizedBox(height: 12),
        CustomPaint(
          size: const Size(double.infinity, 1),
          painter: _DashedLinePainter(color: Colors.grey),
        ),
        const SizedBox(height: 12),

        _PriceRow(
          title: "Total",
          amount: "${widget.currencySymbol}${widget.total}",
        ),

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
