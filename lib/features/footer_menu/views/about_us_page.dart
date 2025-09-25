import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/components/awards_and_certification_section.dart';
import '../../../common/components/common_footer.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../controller/footer_controller.dart';
import '../model/about_us_page_model.dart';
import 'component/about_us_infolist_section.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  final controller = Get.put(FooterController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchAboutUs();
    });
  }

  // Helper method to get content by block type
  String getBlockContent(List<Block>? blocks, String blockName) {
    if (blocks == null) return '';

    for (var block in blocks) {
      if (block.name == Name.CORE_PARAGRAPH &&
          blocks.indexOf(block) > 0 &&
          blocks[blocks.indexOf(block) - 1].name == Name.CORE_HEADING) {
        var headingIndex = blocks.indexOf(block) - 1;
        var heading = blocks[headingIndex].content ?? '';

        if (heading.toLowerCase().contains(blockName.toLowerCase())) {
          return block.content ?? '';
        }
      }
    }
    return '';
  }

  // Helper method to get heading content
  String getHeadingContent(List<Block>? blocks, String headingName) {
    if (blocks == null) return '';

    for (var block in blocks) {
      if (block.name == Name.CORE_HEADING &&
          (block.content ?? '').toLowerCase().contains(
            headingName.toLowerCase(),
          )) {
        return block.content ?? '';
      }
    }
    return headingName; // fallback
  }

  // Helper method to get the first paragraph (story content)
  String getStoryContent(List<Block>? blocks) {
    if (blocks == null) return '';

    for (var block in blocks) {
      if (block.name == Name.CORE_PARAGRAPH) {
        return block.content ?? '';
      }
    }
    return '';
  }

  // Helper method to get award items from blocks
  List<AwardItem> getAwardItems(List<Block>? blocks) {
    List<AwardItem> awards = [];
    if (blocks == null) return awards;

    bool inAwardsSection = false;
    for (var block in blocks) {
      if (block.name == Name.CORE_HEADING &&
          (block.content ?? '').toLowerCase().contains('award')) {
        inAwardsSection = true;
        continue;
      }

      if (inAwardsSection && block.name == Name.CORE_PARAGRAPH) {
        awards.add(
          AwardItem(
            imageUrl:
                "https://images.unsplash.com/photo-1507842217343-583bb7270b66?w=800",
            title: block.content ?? '',
          ),
        );
      }

      // Stop when we hit another heading (not awards related)
      if (inAwardsSection &&
          block.name == Name.CORE_HEADING &&
          !(block.content ?? '').toLowerCase().contains('award')) {
        break;
      }
    }

    // Fallback awards if none found
    if (awards.isEmpty) {
      awards = [
        AwardItem(
          imageUrl:
              "https://images.unsplash.com/photo-1507842217343-583bb7270b66?w=800",
          title: "ISO 9001 Certification",
        ),
        AwardItem(
          imageUrl:
              "https://images.unsplash.com/photo-1521791136064-7986c2920216?w=800",
          title: "Best Organic Brand 2024",
        ),
      ];
    }

    return awards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.aboutUs.value == null) {
          return const Center(child: Text("No data available"));
        }

        final aboutUs = controller.aboutUs.value?.data?.pageBy;
        final blocks = aboutUs?.blocks;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Breadcrumb
                    // RichText(
                    //   text: TextSpan(
                    //     style: const TextStyle(
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.w500,
                    //     ),
                    //     children: [
                    //       TextSpan(
                    //         text: "Home",
                    //         style: TextStyle(color: AppColors.black),
                    //       ),
                    //       TextSpan(
                    //         text: " / ",
                    //         style: TextStyle(color: AppColors.red_CC0003),
                    //       ),
                    //       TextSpan(
                    //         text: aboutUs?.title ?? "About Us",
                    //         style: TextStyle(color: AppColors.red_CC0003),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    // Main About Us Card
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: AboutUsCard(
                        imagePath: AppImages.gir_cow,
                        title: getHeadingContent(blocks, "Our Story"),
                        description: getStoryContent(blocks),
                      ),
                    ),

                    // Dynamic Info List Section
                    AboutUsInfoListSection(
                      items: [
                        AboutUsInfoItem(
                          iconPath: AppImages.cart,
                          title: getHeadingContent(blocks, "Our Beliefs"),
                          description: getBlockContent(blocks, "Our Beliefs"),
                        ),
                        AboutUsInfoItem(
                          iconPath: AppImages.cart,
                          title: getHeadingContent(blocks, "100% Natural"),
                          description: getBlockContent(blocks, "100% Natural"),
                        ),
                        AboutUsInfoItem(
                          iconPath: AppImages.cart,
                          title: getHeadingContent(blocks, "Our Promise"),
                          description: getBlockContent(blocks, "Our Promise"),
                        ),
                      ],
                    ),

                    SizedBox(height: 16),
                    Image.asset(AppImages.hand_churned, fit: BoxFit.contain),
                    SizedBox(height: 32),

                    // Dynamic Awards Section
                    AwardsAndCertificationsSection(
                      awards: getAwardItems(blocks),
                    ),
                  ],
                ),
              ),
              CommonFooter(),
            ],
          ),
        );
      }),
    );
  }
}

class AboutUsCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const AboutUsCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              height: 180,
              width: double.infinity,
            ),
          ),

          // Inner container with Title & Description
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.grey_212121,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
