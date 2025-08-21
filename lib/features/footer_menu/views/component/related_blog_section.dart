import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../home/model/blog_model.dart';
import '../../../home/views/components/blog_card.dart';

class RelatedBlogs extends StatelessWidget {
  final List<BlogModel> allBlogs;
  final BlogModel currentBlog;

  const RelatedBlogs({
    super.key,
    required this.allBlogs,
    required this.currentBlog,
  });

  @override
  Widget build(BuildContext context) {
    // Filter blogs: exclude the current one
    final relatedBlogs =
        allBlogs.where((blog) => blog.title != currentBlog.title).toList();

    return Card(
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.42,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                "Related Blogs",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
              ),
            ),
            const SizedBox(height: 8),

            // Scroll inside card
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: relatedBlogs.length,
                itemBuilder: (context, index) {
                  return BlogCard(
                    blogModel: relatedBlogs[index],
                    showDescription: false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
