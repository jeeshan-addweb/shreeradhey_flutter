import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shree_radhey/common/components/gradient_button.dart';
import 'package:shree_radhey/features/accounts/controller/account_controller.dart';
import '../../../../constants/app_colors.dart';
import '../model/order_detail_model.dart';

class OrderDetailScreen extends StatefulWidget {
  final int orderId;

  const OrderDetailScreen({super.key, required this.orderId});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final controller = Get.put(AccountController());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchOrderDetail(widget.orderId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final order = controller.orderDetail.value?.data?.order;
        if (order == null) {
          return const Center(child: Text("No details found"));
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 14, color: AppColors.black),
                  children: [
                    const TextSpan(text: "Order "),
                    TextSpan(
                      text: "#${order.orderNumber} ",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(text: "was placed on "),
                    TextSpan(
                      text: DateFormat("MMMM dd, yyyy").format(order.date!),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(text: " and is currently "),
                    TextSpan(
                      text: order.status,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(text: "."),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              /// Updates
              const Text(
                "Order updates",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 6),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("1. "),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          DateFormat(
                            "EEEE dd'th' of MMMM yyyy, hh:mma",
                          ).format(order.date!),
                        ),
                        SizedBox(height: 5),
                        const Text("Order is Confirmed"),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              /// Updates
              const Text(
                "Order details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 20),

              /// Order details table
              Table(
                border: TableBorder.all(color: Colors.grey.shade300),
                columnWidths: const {
                  0: FlexColumnWidth(3),
                  1: FlexColumnWidth(1),
                },
                children: [
                  _tableRow("Product", "Total", isHeader: true),
                  ...order.lineItems!.nodes!.map(
                    (item) => _tableRow(
                      "${item.product?.node?.name} × ${item.quantity}",
                      "₹${item.total}",
                    ),
                  ),
                  _tableRow("Subtotal:", "₹${order.total}"),
                  _tableRow("Shipping:", "Free shipping"),
                  _tableRow("Payment method:", "Cash on delivery"),
                  _tableRow("Total:", "₹${order.total}"),
                  _tableRow("Actions:", "Invoice", isButton: true),
                ],
              ),

              const SizedBox(height: 20),

              /// Billing & Shipping address
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _addressCard("Billing address", order.billing),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _addressCard("Shipping address", order.shipping),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  TableRow _tableRow(
    String left,
    String right, {
    bool isHeader = false,
    bool isButton = false,
  }) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            left,
            style: TextStyle(
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              isButton
                  ? GradientButton(text: "Invoice", onPressed: () {})
                  : Text(
                    right,
                    style: TextStyle(
                      fontWeight:
                          isHeader ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
        ),
      ],
    );
  }

  Widget _addressCard(String title, Ing? address) {
    return Card(
      color: AppColors.white,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            if (address != null) ...[
              Text("${address.firstName ?? ""} ${address.lastName ?? ""}"),
              Text(address.address1 ?? ""),
              if (address.address2?.isNotEmpty == true) Text(address.address2!),
              Text("${address.city ?? ""} ${address.postcode ?? ""}"),
              Text(address.state ?? ""),
              SizedBox(height: 8),
              if (address.phone != null && address.phone!.isNotEmpty)
                Row(
                  children: [
                    Icon(Icons.phone, size: 16),
                    SizedBox(width: 4),
                    Text(address.phone!),
                  ],
                ),
              if (address.email != null && address.email!.isNotEmpty)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.email, size: 16),
                    const SizedBox(width: 4),
                    Expanded(
                      // 👈 constrain text inside row
                      child: Text(
                        address.email!,
                        overflow: TextOverflow.ellipsis, // or wrap
                        maxLines: 2, // allow wrapping
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
            ] else
              const Text("No address available"),
          ],
        ),
      ),
    );
  }
}
