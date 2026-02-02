import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/components/awards_and_certification_section.dart';
import '../../../common/components/bullet_point.dart';
import '../../../common/components/common_footer.dart';
import '../../../constants/app_colors.dart';
import '../../home/views/components/feature_slider_component.dart';
import '../../shop/views/components/faq_section.dart';
import '../controller/footer_controller.dart';
import 'component/aspect_section.dart';
import 'component/benefits_section.dart';
import 'component/image_title_description_section.dart';
import 'component/title_description_section.dart';

class WoodPressedOilScreen extends StatefulWidget {
  const WoodPressedOilScreen({super.key});

  @override
  State<WoodPressedOilScreen> createState() => _WoodPressedOilScreenState();
}

class _WoodPressedOilScreenState extends State<WoodPressedOilScreen> {
  final controller = Get.put(FooterController());

  /// ✅ flag to ensure we only render first awards section
  bool _awardsRendered = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchWoodPress("wood-pressed-oil");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final page = controller.woodPress.value?.data?.page;
      if (page == null) {
        return const Center(child: Text("No data found"));
      }

      _awardsRendered = false; // reset when rebuilding

      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...?page.sections?.map((section) {
              switch (section.type) {
                case "banner":
                  return Image.network(
                    section.image ?? "",
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                  );

                case "titleDescription":
                  return TitleDescriptionSection(
                    title: section.title ?? "",
                    description: section.description ?? "",
                  );

                case "image_title_description":
                  return ImageTitleDescriptionSection(
                    image: section.image ?? "",
                    title: section.title ?? "",
                    description: section.description ?? "",
                  );

                case "bullet_points":
                  return Column(
                    children: [
                      Text(
                        section.title ?? "",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...(section.points is List
                          ? (section.points as List).map(
                            (p) => BulletPoint(text: p.toString()),
                          )
                          : []),
                    ],
                  );

                case "faq":
                  return FAQSection(
                    faqColor: AppColors.grey_65758b,
                    faqs:
                        section.faqItems
                            ?.map(
                              (f) => {
                                "question": f.question ?? "",
                                "answer": f.answer ?? "",
                              },
                            )
                            .toList() ??
                        [],
                  );

                case "aspects":
                  return AspectsSection(
                    title: section.title ?? "",
                    aspects:
                        section.aspects
                            ?.map(
                              (a) => {
                                "icon": a.icon ?? "",
                                "text": a.text ?? "",
                                "content": a.content ?? "",
                              },
                            )
                            .toList() ??
                        [],
                  );

                case "benefits":
                  return BenefitsSection(
                    benefits:
                        section.aspects
                            ?.map(
                              (a) => {
                                "icon": a.icon ?? "",
                                "title": a.text ?? "",
                                "desc": section.description ?? "",
                              },
                            )
                            .toList() ??
                        [],
                  );

                case "awards":
                  if (_awardsRendered) {
                    // ✅ skip all awards after the first
                    return const SizedBox.shrink();
                  }
                  _awardsRendered = true;
                  return AwardsAndCertificationsSection(
                    awards:
                        section.awards
                            ?.map(
                              (a) => AwardItem(
                                imageUrl: a.imageUrl ?? "",
                                title: a.title ?? "",
                              ),
                            )
                            .toList() ??
                        [],
                  );

                default:
                  return const SizedBox.shrink();
              }
            }),

            const SizedBox(height: 20),
            FeatureSlider(),
            const SizedBox(height: 20),
            CommonFooter(),
          ],
        ),
      );
    });
  }
}
