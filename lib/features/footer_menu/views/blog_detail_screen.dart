import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:intl/intl.dart';
import 'package:shree_radhey/features/home/controller/home_controller.dart';

import '../../../common/components/common_footer.dart';
import '../../../constants/app_colors.dart';
import 'component/table_of_content_card.dart';

class BlogDetailScreen extends StatefulWidget {
  final String slug;
  const BlogDetailScreen({super.key, required this.slug});

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  final HomeController controller = Get.find<HomeController>();
  final ScrollController _scrollController = ScrollController();
  final Map<int, GlobalKey> _sectionKeys = {};

  List<Section> extractSections(String htmlContent) {
    final document = html_parser.parse(htmlContent);
    final headings = document.querySelectorAll('h2, h3');

    List<Section> sections = [];
    int counter = 0;

    for (var heading in headings) {
      counter++;
      final id = "section_$counter";
      final title = heading.text.trim();

      // Collect all siblings until the next heading
      StringBuffer bodyBuffer = StringBuffer();
      var next = heading.nextElementSibling;
      while (next != null &&
          !(next.localName == "h2" || next.localName == "h3")) {
        bodyBuffer.write(next.outerHtml);
        next = next.nextElementSibling;
      }

      sections.add(Section(id: id, title: title, body: bodyBuffer.toString()));
    }

    return sections;
  }

  @override
  void initState() {
    super.initState();
    debugPrint("Slug is ${widget.slug}");
    controller.fetchBlogDetail(context, widget.slug);
    // for (int i = 0; i < controller.length; i++) {
    //   _sectionKeys[i] = GlobalKey();
    // }
  }

  void _scrollToSection(int index) {
    final keyContext = _sectionKeys[index]?.currentContext;
    if (keyContext != null) {
      Scrollable.ensureVisible(
        keyContext,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isDetailLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final detail = controller.blogDetail.value?.data?.post;
      if (detail == null) {
        return const Center(child: Text("Product not found"));
      }
      final contentHtml = detail.content;
      final sections = extractSections(contentHtml!);
      return SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    detail.title.toString(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // RichText(
                  //   text: TextSpan(
                  //     style: const TextStyle(
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.w600,
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
                  //         text: "Blog",
                  //         style: TextStyle(color: AppColors.black),
                  //       ),
                  //       TextSpan(
                  //         text: " / ",
                  //         style: TextStyle(color: AppColors.red_CC0003),
                  //       ),
                  //       TextSpan(
                  //         text: detail.title,
                  //         style: TextStyle(color: AppColors.red_CC0003),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(
                          detail.author!.node!.avatar!.url.toString(),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        detail.author?.node?.name ?? "",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  /// Published On
                  Text(
                    detail.date != null
                        ? "Published on - ${DateFormat("MMMM dd, yyyy").format(detail.date!)}"
                        : "",
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),

                  const SizedBox(height: 6),

                  // Minutes Read
                  // Text(
                  //   "${widget.model.readTime} minutes read",
                  //   style: const TextStyle(fontSize: 14, color: Colors.grey),
                  // ),
                  const SizedBox(height: 20),
                  CustomTableOfContent(
                    contents: sections.map((e) => e.title).toList(),
                    onItemTap: (index) {
                      _scrollToSection(index);
                    },
                  ),
                  const SizedBox(height: 20),
                  Image.network(
                    detail.featuredImage!.node!.sourceUrl.toString(),
                  ),
                  const SizedBox(height: 20),
                  Html(
                    data: detail.excerpt ?? "",
                    style: {
                      "body": Style(
                        margin: Margins.zero, // removes default margins
                        padding: HtmlPaddings.zero,
                        fontSize: FontSize(14),
                        color: AppColors.grey_212121,
                      ),
                    },
                  ),

                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(sections.length, (index) {
                      final section = sections[index];
                      _sectionKeys[index] = GlobalKey();
                      return Container(
                        key: _sectionKeys[index],
                        margin: const EdgeInsets.only(bottom: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              section.title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Html(
                              data: section.body,
                              style: {
                                "body": Style(
                                  margin: Margins.zero,
                                  padding: HtmlPaddings.zero,
                                  fontSize: FontSize(15),
                                  color: AppColors.grey_212121,
                                ),
                              },
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            CommonFooter(),
          ],
        ),
      );
    });
  }
}

class Section {
  final String id;
  final String title;
  final String body;

  Section({required this.id, required this.title, required this.body});
}
