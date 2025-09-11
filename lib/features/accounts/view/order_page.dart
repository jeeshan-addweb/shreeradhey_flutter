import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../common/components/common_footer.dart';
import '../../../constants/app_mock_data.dart';
import '../../../utils/routes/app_route_path.dart';
import '../controller/account_controller.dart';
import 'components/order_card.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final AccountController accountController = Get.put(AccountController());

  @override
  void initState() {
    super.initState();
    accountController.fetchOrders(); // 🔥 Call API
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (accountController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (accountController.errorMessage.isNotEmpty) {
          return Center(child: Text(accountController.errorMessage.value));
        }

        if (accountController.orders.isEmpty) {
          return const Center(child: Text("No orders found"));
        }
        return ListView(
          padding: EdgeInsets.zero,
          children: [
            /// Orders List
            ...accountController.orders.map((order) {
              return OrderCard(
                order: order,
                onView: () {
                  context.push(
                    AppRoutePath.orderDetailScreen,
                    extra: order.databaseId,
                  );
                },
                onInvoice: () {},
              );
            }).toList(),
            const SizedBox(height: 40),

            /// Footer
            const CommonFooter(),
          ],
        );
      }),
    );
  }
}
