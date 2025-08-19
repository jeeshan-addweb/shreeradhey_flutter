import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';

class FAQSection extends StatefulWidget {
  final List<Map<String, String>> faqs;
  final Color faqColor;

  const FAQSection({super.key, required this.faqs, required this.faqColor});

  @override
  State<FAQSection> createState() => _FAQSectionState();
}

class _FAQSectionState extends State<FAQSection> {
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.faqs.length, (index) {
        final faq = widget.faqs[index];
        final isExpanded = _expandedIndex == index;

        return Card(
          color: AppColors.white,
          elevation: isExpanded ? 4 : 1,
          margin: const EdgeInsets.symmetric(vertical: 6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                                    : widget.faqColor,
                          ),
                        ),
                      ),
                      Icon(
                        isExpanded ? Icons.remove : Icons.add,
                        color:
                            isExpanded ? AppColors.red_CC0003 : AppColors.black,
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
    );
  }
}
