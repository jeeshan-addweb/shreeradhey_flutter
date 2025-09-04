import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/components/common_footer.dart';
import '../../../constants/app_colors.dart';
import '../controller/footer_controller.dart';
import '../model/faq_model.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final controller = Get.put(FooterController());
  int? _expandedIndex;

  @override
  void initState() {
    super.initState();
    controller.fetchFAQ();
  }

  List<FaqItem> parseFaqs(List<Block> blocks) {
    final faqs = <FaqItem>[];

    for (int i = 0; i < blocks.length; i++) {
      final block = blocks[i];

      // Only consider "core/details" as question
      if (block.name == Name.CORE_DETAILS) {
        final question = block.content ?? "";
        String answer = "";

        if (i + 1 < blocks.length &&
            blocks[i + 1].name == Name.CORE_PARAGRAPH) {
          answer = blocks[i + 1].content ?? "";
        }

        faqs.add(FaqItem(question: question, answer: answer));
      }
    }

    return faqs;
  }

  @override
  Widget build(BuildContext context) {
    final blocks = controller.faq.value?.data?.pageBy?.blocks ?? [];
    debugPrint("BLOCK COUNT: ${blocks.length}");
    for (final b in blocks) {
      debugPrint("Block -> name: ${b.name}, content: ${b.content}");
    }

    final faqs = parseFaqs(blocks);
    debugPrint("Parsed FAQs: ${faqs.length}");

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final blocks = controller.faq.value?.data?.pageBy?.blocks ?? [];
        final faqs = parseFaqs(blocks);

        if (faqs.isEmpty) {
          return const Center(child: Text("No FAQs available"));
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 8,
                ),
                child: Text(
                  "FAQ's",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // FAQ list
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 8,
                ),
                child: Column(
                  children: List.generate(faqs.length, (index) {
                    final faq = faqs[index];
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      faq.question,
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

                              // Answer
                              AnimatedCrossFade(
                                firstChild: const SizedBox.shrink(),
                                secondChild: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    faq.answer,
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

              const SizedBox(height: 20),
              const CommonFooter(),
            ],
          ),
        );
      }),
    );
  }
}

class FaqItem {
  final String question;
  final String answer;

  FaqItem({required this.question, required this.answer});
}
