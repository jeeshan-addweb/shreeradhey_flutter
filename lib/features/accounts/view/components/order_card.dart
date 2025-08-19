import 'package:flutter/material.dart';
import 'package:shree_radhey/constants/app_colors.dart' show AppColors;
import '../../model/order_model.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  final VoidCallback onView;
  final VoidCallback onInvoice;

  const OrderCard({
    super.key,
    required this.order,
    required this.onView,
    required this.onInvoice,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.blue_eef1ed,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Top Row (Order ID + Status)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Order #${order.orderId}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color:
                        order.status.toLowerCase() == "completed"
                            ? Colors.green.shade100
                            : Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    order.status,
                    style: TextStyle(
                      color:
                          order.status.toLowerCase() == "completed"
                              ? Colors.green
                              : Colors.orange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            /// Date
            Text(
              DateFormat("MMMM dd, yyyy").format(order.date),
              style: const TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 6),

            /// Item + Price
            Text(
              "₹${order.totalAmount} for ${order.itemCount} item${order.itemCount > 1 ? 's' : ''}",
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),

            const SizedBox(height: 12),

            /// Buttons Row
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildGradientButton(text: "VIEW", onPressed: onView),
                const SizedBox(width: 10),
                _buildGradientButton(text: "INVOICE", onPressed: onInvoice),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildGradientButton({
  required String text,
  required VoidCallback onPressed,
}) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [AppColors.green_6cad10, AppColors.green_327801],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        minimumSize: const Size(100, 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
