import 'package:flutter/material.dart';

import '../../../constants/app_images.dart';
import '../../home/model/blog_model.dart';

class BlogDetailScreen extends StatefulWidget {
  final BlogModel model;
  const BlogDetailScreen({super.key, required this.model});

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.model.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
            const Divider(),
          ],
        ),
      ),
    );
  }
}
