import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shree_radhey/features/home/model/get_blog_model.dart';

import '../../../../constants/app_colors.dart';
import '../../model/blog_model.dart';

class BlogCard extends StatefulWidget {
  final NodeElement blogModel;
  final bool showDescription;
  const BlogCard({
    super.key,
    required this.blogModel,
    this.showDescription = true,
  });

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: Image.network(
                widget.blogModel.featuredImage!.node!.sourceUrl ?? "",
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 5),

            // Text
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.blogModel.title ?? "",
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),

                    if (widget.showDescription) ...[
                      Html(
                        data: widget.blogModel.excerpt ?? "",
                        style: {
                          "body": Style(
                            margin: Margins.zero, // removes default margins
                            padding: HtmlPaddings.zero,
                            fontSize: FontSize(12),
                            color: AppColors.grey_212121,
                            maxLines: 2,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
