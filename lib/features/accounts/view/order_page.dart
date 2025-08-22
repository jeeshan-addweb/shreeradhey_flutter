import 'package:flutter/material.dart';

import '../../../common/components/common_footer.dart';
import '../../../constants/app_mock_data.dart';
import 'components/order_card.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          /// Orders List
          ...AppMockData.dummyOrders.map((order) {
            return OrderCard(order: order, onView: () {}, onInvoice: () {});
          }).toList(),
          const SizedBox(height: 40),

          /// Footer
          const CommonFooter(),
        ],
      ),
    );
  }
}
