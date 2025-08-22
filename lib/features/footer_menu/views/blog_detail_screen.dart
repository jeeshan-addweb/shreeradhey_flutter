import 'package:flutter/material.dart';

import '../../../common/components/common_footer.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_mock_data.dart';
import '../../home/model/blog_model.dart';
import '../model/blog_section._model.dart';
import 'component/related_blog_section.dart';
import 'component/table_of_content_card.dart';

class BlogDetailScreen extends StatefulWidget {
  final BlogModel model;
  const BlogDetailScreen({super.key, required this.model});

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  final Map<int, GlobalKey> _sectionKeys = {};
  final List<BlogSectionModel> _sections = [
    BlogSectionModel(
      title: "Why A2 Ghee is Perfect for Festive Cooking?",
      description:
          "Raksha Bandhan are festivals with roots in the old traditions and A2 ghee becomes a part...",
    ),
    BlogSectionModel(
      title: "Popular Raksha Bandhan Sweets You Can Make with A2 Ghee",
      description:
          "Desi ghee sweets are not only for health, but also about...",
    ),
    BlogSectionModel(
      title: "Top Health Benefits of Using A2 Ghee in Raksha Bandhan Sweets",
      description:
          "According to Ayurveda, this is a pure and nourishing ingredient...",
    ),
    BlogSectionModel(
      title: "Homemade Sweets with A2 Ghee: A Better Choice Than Store-Bought",
      description: "No matter whether it is laddoo, barfi or halwa, A2 ghee...",
    ),
    BlogSectionModel(
      title: "Final Thoughts",
      description:
          "Using A2 Ghee for festivals ensures purity, tradition, and health...",
    ),
  ];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _sections.length; i++) {
      _sectionKeys[i] = GlobalKey();
    }
  }

  void _scrollToSection(int index) {
    final keyContext = _sectionKeys[index]!.currentContext;
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
                  widget.model.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Home / ",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const Text(
                      "Blog",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        "/ ${widget.model.title}",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundImage: AssetImage(AppImages.profile),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      widget.model.writerName ?? "",
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
                  "Published on - ${widget.model.date}",
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 6),

                /// Minutes Read
                Text(
                  "${widget.model.readTime} minutes read",
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),

                const SizedBox(height: 20),
                TableOfContentCard(
                  contents: _sections.map((e) => e.title).toList(),
                  onItemTap: _scrollToSection,
                ),
                const SizedBox(height: 20),
                RelatedBlogs(
                  allBlogs: AppMockData.blogItems,
                  currentBlog: widget.model,
                ),
                const SizedBox(height: 20),

                for (int i = 0; i < _sections.length; i++)
                  Container(
                    key: _sectionKeys[i],
                    margin: const EdgeInsets.only(bottom: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _sections[i].title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _sections[i].description,
                          style: const TextStyle(fontSize: 14, height: 1.5),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          CommonFooter(),
        ],
      ),
    );
  }
}
