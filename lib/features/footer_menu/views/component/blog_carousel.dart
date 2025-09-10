import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

import '../../../../constants/app_colors.dart';
import '../../../home/model/get_blog_model.dart';

class BlogCarousel extends StatefulWidget {
  final List<NodeElement> blogs;

  const BlogCarousel({super.key, required this.blogs});

  @override
  State<BlogCarousel> createState() => _BlogCarouselState();
}

class _BlogCarouselState extends State<BlogCarousel> {
  late PageController _pageController;
  int _currentPage = 0;
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9);
  }

  void _nextPage() {
    if (_currentPage < widget.blogs.length - 1) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {});
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      _currentPage--;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height:
              _expanded
                  ? MediaQuery.sizeOf(context).height * 0.56
                  : MediaQuery.sizeOf(context).height * 0.5,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // PageView
              PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: widget.blogs.length,
                itemBuilder: (context, index) {
                  final blog = widget.blogs[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            blog.featuredImage?.node?.sourceUrl ?? "",
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Title
                        Text(
                          blog.title ?? "",

                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        // Description with read more
                        AnimatedSize(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: Html(
                            data: blog.excerpt ?? "",
                            style: {
                              "body": Style(
                                margin: Margins.zero,
                                padding: HtmlPaddings.zero,
                                fontSize: FontSize(14),
                                color: AppColors.grey_3C403D,
                                maxLines:
                                    _expanded
                                        ? null
                                        : 2, // won't work directly, so read below
                                textOverflow:
                                    _expanded
                                        ? TextOverflow.visible
                                        : TextOverflow.ellipsis,
                              ),
                            },
                          ),
                        ),

                        if ((blog.excerpt ?? "").length > 80)
                          GestureDetector(
                            onTap: () => setState(() => _expanded = !_expanded),
                            child: Text(
                              _expanded ? "Read less" : "Read more",
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        const SizedBox(height: 6),

                        // Writer + Date + Time
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                blog.author?.node?.name ?? "",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                blog.date != null
                                    ? "${5} min read • ${DateFormat("MMMM dd, yyyy").format(blog.date!)}"
                                    : "",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              // Left Arrow
              Positioned(
                left: 0,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: _prevPage,
                  color: _currentPage > 0 ? Colors.black : Colors.grey.shade400,
                ),
              ),

              // Right Arrow
              Positioned(
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: _nextPage,
                  color:
                      _currentPage < widget.blogs.length - 1
                          ? Colors.black
                          : Colors.grey.shade400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
