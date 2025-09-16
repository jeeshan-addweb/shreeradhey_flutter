import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/components/common_footer.dart';
import '../../../constants/app_colors.dart';
import '../controller/footer_controller.dart';

class ShippingAndDeliveryPolicyPage extends StatefulWidget {
  const ShippingAndDeliveryPolicyPage({super.key});

  @override
  State<ShippingAndDeliveryPolicyPage> createState() =>
      _ShippingAndDeliveryPolicyPageState();
}

class _ShippingAndDeliveryPolicyPageState
    extends State<ShippingAndDeliveryPolicyPage> {
  final controller = Get.put(FooterController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchShipping();
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

        if (controller.shipping.value == null) {
          return const Center(child: Text("No Shipping  available"));
        }

        final shipping = controller.shipping.value?.data?.pageBy;
        final blocks = shipping?.blocks ?? [];

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  shipping?.title ?? "Shipping POlicy",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Render all blocks in sequence
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      blocks.map((block) {
                        if (block.name == "core/heading") {
                          return Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 8),
                            // child: Text(
                            //   block.content ?? '',
                            //   style: const TextStyle(
                            //     fontSize: 18,
                            //     fontWeight: FontWeight.w600,
                            //   ),
                            // ),
                          );
                        } else if (block.name == "core/paragraph") {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Text(
                              block.content ?? '',
                              style: const TextStyle(fontSize: 14, height: 1.5),
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      }).toList(),
                ),
              ),

              const SizedBox(height: 20),
              const CommonFooter(),
            ],
          ),
        );
      }),
    );
  }
}
