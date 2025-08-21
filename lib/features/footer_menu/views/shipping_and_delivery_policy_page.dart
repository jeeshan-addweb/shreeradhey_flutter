import 'package:flutter/material.dart';

import '../../../common/components/common_footer.dart';

class ShippingAndDeliveryPolicyPage extends StatefulWidget {
  const ShippingAndDeliveryPolicyPage({super.key});

  @override
  State<ShippingAndDeliveryPolicyPage> createState() =>
      _ShippingAndDeliveryPolicyPageState();
}

class _ShippingAndDeliveryPolicyPageState
    extends State<ShippingAndDeliveryPolicyPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [Text("Shipping and Delivery Policy Content")],
            ),
          ),
          SizedBox(height: 20),
          CommonFooter(),
        ],
      ),
    );
  }
}
