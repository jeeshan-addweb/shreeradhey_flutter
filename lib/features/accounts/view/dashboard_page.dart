import 'package:flutter/material.dart';
import 'package:shree_radhey/common/components/common_footer.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              "From your account dashboard you can view your recent orders, manage your shipping and billing addresses, and edit your password and account details.",
            ),
          ),
          const SizedBox(height: 20),
          const CommonFooter(),
        ],
      ),
    );
  }
}
