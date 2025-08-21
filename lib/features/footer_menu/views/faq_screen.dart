import 'package:flutter/material.dart';
import 'package:shree_radhey/common/components/common_footer.dart';

import '../../../constants/app_colors.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  int? _expandedIndex;
  final List<Map<String, String>> _faqs = [
    {
      "question": "How can I Place an Order on Your Website?",
      "answer":
          "To place an order, browse products, add them to your cart, and proceed to checkout.",
    },
    {
      "question": "What are the Shipping Charges?",
      "answer":
          "Shipping charges vary depending on your location and the total weight of your order.",
    },
    {
      "question": "How Long will it take to Receive My Order?",
      "answer":
          "Delivery usually takes between 3 to 7 working days depending on your location.",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
            child: Text(
              "FAQ's",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          // FAQ list
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
            child: Column(
              children: List.generate(_faqs.length, (index) {
                final faq = _faqs[index];
                final isExpanded = _expandedIndex == index;

                return Card(
                  color: AppColors.white,
                  elevation: isExpanded ? 4 : 1,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _expandedIndex = isExpanded ? null : index;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Question row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  faq["question"]!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color:
                                        isExpanded
                                            ? AppColors.red_CC0003
                                            : AppColors.black,
                                  ),
                                ),
                              ),
                              Icon(
                                isExpanded ? Icons.remove : Icons.add,
                                color:
                                    isExpanded
                                        ? AppColors.red_CC0003
                                        : AppColors.black,
                              ),
                            ],
                          ),

                          // Answer section
                          AnimatedCrossFade(
                            firstChild: const SizedBox.shrink(),
                            secondChild: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                faq["answer"]!,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.grey_212121,
                                ),
                              ),
                            ),
                            crossFadeState:
                                isExpanded
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                            duration: const Duration(milliseconds: 200),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: 20),
          CommonFooter(),
        ],
      ),
    );
  }
}
