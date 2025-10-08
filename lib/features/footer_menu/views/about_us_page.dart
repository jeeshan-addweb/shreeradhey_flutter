import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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

  String getHeadingContent(List<Block>? blocks, String keyword) {
    if (blocks == null) return '';
    for (var block in blocks) {
      if ((block.name?.toLowerCase().contains("heading") ?? false) &&
          (block.content ?? '').toLowerCase().contains(keyword.toLowerCase())) {
        return block.content ?? '';
      }
    }
    return keyword;
  }

  String getBlockContent(List<Block>? blocks, String headingKeyword) {
    if (blocks == null) return '';
    for (var i = 0; i < blocks.length; i++) {
      final block = blocks[i];
      if ((block.name?.toLowerCase().contains("heading") ?? false) &&
          (block.content ?? '').toLowerCase().contains(
            headingKeyword.toLowerCase(),
          )) {
        if (i + 1 < blocks.length && blocks[i + 1].name == "core/paragraph") {
          return blocks[i + 1].content ?? '';
        }
      }
    }
    return '';
  }

  String getStoryContent(List<Block>? blocks) {
    if (blocks == null) return '';
    for (var block in blocks) {
      if (block.name == "core/paragraph") return block.content ?? '';
    }
    return '';
  }

  List<AwardItem> getAwardItems(List<Block>? blocks) {
    List<AwardItem> awards = [];
    if (blocks == null) return awards;

    bool inAwardsSection = false;
    for (var block in blocks) {
      if ((block.name?.toLowerCase().contains("heading") ?? false) &&
          (block.content ?? '').toLowerCase().contains("award")) {
        inAwardsSection = true;
        continue;
      }

      if (inAwardsSection && block.name == "core/paragraph") {
        awards.add(
          AwardItem(
            imageUrl:
                "https://images.unsplash.com/photo-1507842217343-583bb7270b66?w=800",
            title: block.content ?? '',
          ),
        );
      }

      if (inAwardsSection &&
          (block.name?.toLowerCase().contains("heading") ?? false) &&
          !(block.content ?? '').toLowerCase().contains("award")) {
        break;
      }
    }

    return awards;
  }

  List<String> getGalleryImages(List<Block>? blocks) {
    List<String> images = [];
    if (blocks == null) return images;

    bool inGallerySection = false;
    for (var block in blocks) {
      final nameLower = block.name?.toLowerCase() ?? '';
      final contentLower = (block.content ?? '').toLowerCase();

      // Check if this is a gallery heading
      if ((nameLower.contains("heading") ||
              nameLower.contains("heading-title")) &&
          contentLower.contains("gallery")) {
        inGallerySection = true;
        continue;
      }

      if (inGallerySection) {
        // Extract image URL from core/image blocks
        if (block.name == "core/image" &&
            block.content != null &&
            block.content!.isNotEmpty) {
          images.add(block.content!);
        }

        // Check if we've left the gallery section
        if ((nameLower.contains("heading") ||
                nameLower.contains("heading-title")) &&
            !contentLower.contains("gallery")) {
          break;
        }
      }
    }

    return images;
  }

  // ---------------- UI ----------------
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
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: AboutUsCard(
                        imagePath: AppImages.gir_cow,
                        title: getHeadingContent(blocks, "Our Story"),
                        description: getStoryContent(blocks),
                      ),
                    ),

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

                    const SizedBox(height: 16),
                    Image.asset(AppImages.hand_churned, fit: BoxFit.contain),
                    const SizedBox(height: 32),

                    AwardsAndCertificationsSection(
                      awards: getAwardItems(blocks),
                    ),
                    const SizedBox(height: 24),

                    // ---------------- Gallery ----------------
                    GallerySection(images: getGalleryImages(blocks)),
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

class GallerySection extends StatelessWidget {
  final List<String> images;

  const GallerySection({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Gallery",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return GalleryImageItem(imageUrl: images[index]);
            },
          ),
        ),
      ],
    );
  }
}

class GalleryImageItem extends StatelessWidget {
  final String imageUrl;

  const GalleryImageItem({super.key, required this.imageUrl});

  Future<Uint8List> _downloadSvg(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load SVG: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSvg = imageUrl.toLowerCase().endsWith('.svg');

    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[100],
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child:
            isSvg
                ? FutureBuilder<Uint8List>(
                  future: _downloadSvg(imageUrl),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        color: Colors.grey[200],
                        child: const Center(
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                      );
                    }

                    if (snapshot.hasError || !snapshot.hasData) {
                      print("Error loading SVG: ${snapshot.error}");
                      return Container(
                        color: Colors.grey[200],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.broken_image,
                              size: 32,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Failed to load',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    // Load SVG from bytes
                    return SvgPicture.memory(
                      snapshot.data!,
                      width: 120,
                      height: 120,
                      fit: BoxFit.contain,
                    );
                  },
                )
                : Image.network(
                  imageUrl,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: Colors.grey[200],
                      child: Center(
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            value:
                                loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                          ),
                        ),
                      ),
                    );
                  },
                  errorBuilder: (_, error, __) {
                    print("Error loading image: $error");
                    return Container(
                      color: Colors.grey[200],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.broken_image,
                            size: 32,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Failed to load',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
      ),
    );
  }
}
