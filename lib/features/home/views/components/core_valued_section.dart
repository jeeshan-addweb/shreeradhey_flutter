import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_colors.dart';
import '../../controller/home_controller.dart';
import 'core_valued_component.dart';

class CoreValuedSection extends StatefulWidget {
  const CoreValuedSection({super.key});

  @override
  State<CoreValuedSection> createState() => _CoreValuedSectionState();
}

class _CoreValuedSectionState extends State<CoreValuedSection> {
  final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Heading
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                const TextSpan(
                  text: "THE SHREE RADHEY COMMITMENT |",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 28,
                  ),
                ),

                TextSpan(
                  text: " CORE\n VALUES",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.red_b12704, // Or Colors.red
                    fontStyle: FontStyle.italic,
                    fontSize: 28,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Carousel with scroll buttons
        Obx(() {
          final commitments = controller.commitments;

          if (controller.isProductsLoading.value && commitments.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(24.0),
              child: CircularProgressIndicator(),
            );
          }

          if (commitments.isEmpty) {
            return const Text("No commitments available");
          }
          return ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,

            itemCount: commitments.length,
            separatorBuilder: (_, __) => const SizedBox(width: 6),
            itemBuilder: (context, index) {
              final coreValueItem = commitments[index];
              return SizedBox(
                width: 270,
                child: CoreValueCard(coreValueModel: coreValueItem),
              );
            },
          );
        }),
      ],
    );
  }
}
