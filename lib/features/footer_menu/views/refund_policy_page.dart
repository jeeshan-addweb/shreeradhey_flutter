import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/components/common_footer.dart';
import '../../../constants/app_colors.dart';
import '../controller/footer_controller.dart';
import '../model/refund_policy_model.dart';

class RefundPolicyPage extends StatefulWidget {
  const RefundPolicyPage({super.key});

  @override
  State<RefundPolicyPage> createState() => _RefundPolicyPageState();
}

class _RefundPolicyPageState extends State<RefundPolicyPage> {
  final controller = Get.put(FooterController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchRefundPolicy();
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

        if (controller.refundPolicy.value == null) {
          return const Center(child: Text("No refund policy available"));
        }

        final refundPolicy = controller.refundPolicy.value?.data?.pageBy;
        final blocks = refundPolicy?.blocks ?? [];

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  refundPolicy?.title ?? "Refund Policy",
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
                        if (block.name == Name.CORE_HEADING) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 8),
                            child: Text(
                              block.content ?? '',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        } else if (block.name == Name.CORE_PARAGRAPH) {
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
