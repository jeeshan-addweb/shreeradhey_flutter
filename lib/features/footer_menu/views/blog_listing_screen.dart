import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_mock_data.dart';
import '../../../utils/routes/app_route_path.dart';
import '../../home/controller/home_controller.dart';
import '../../home/model/get_blog_model.dart';
import 'component/blog_carousel.dart';

class BlogListingScreen extends StatefulWidget {
  const BlogListingScreen({super.key});

  @override
  State<BlogListingScreen> createState() => _BlogListingScreenState();
}

class _BlogListingScreenState extends State<BlogListingScreen> {
  final HomeController controller = Get.find<HomeController>();

  String selectedFilter = "All";
  String searchQuery = "";
  final _hCtrl = ScrollController();

  @override
  void dispose() {
    _hCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Filtered blogs
    final filteredBlogs =
        AppMockData.blogItems.where((blog) {
          final matchesFilter =
              selectedFilter == "All" || blog.title.contains(selectedFilter);
          final matchesSearch =
              blog.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
              blog.description.toLowerCase().contains(
                searchQuery.toLowerCase(),
              );
          return matchesFilter && matchesSearch;
        }).toList();

    if (controller.isBlogsLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.hasError.value) {
      return Center(child: Text("Error: ${controller.errorMessage}"));
    }

    if (controller.blogs.isEmpty) {
      return const Center(child: Text("No blogs available"));
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Blog", style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: "Home ",
                      style: TextStyle(color: AppColors.black),
                    ),
                    TextSpan(
                      text: "/ ",
                      style: TextStyle(color: AppColors.red_CC0003),
                    ),
                    TextSpan(
                      text: "Blog",
                      style: TextStyle(color: AppColors.red_CC0003),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              BlogCarousel(blogs: controller.blogs),

              const SizedBox(height: 16),

              /// --- Filter + Search ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Dropdown
                    DropdownButtonFormField<String>(
                      value: selectedFilter,
                      decoration: const InputDecoration(
                        labelText: "Filter By",
                        border: OutlineInputBorder(),
                      ),
                      items:
                          ["All", "Health", "Recipes", "Tips"]
                              .map(
                                (item) => DropdownMenuItem(
                                  value: item,
                                  child: Text(item),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        setState(() => selectedFilter = value ?? "All");
                      },
                    ),
                    const SizedBox(height: 12),

                    // Search
                    TextField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: "Search...",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() => searchQuery = value);
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// --- Vertical Blog List ---
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.blogs.length,
                separatorBuilder: (_, __) => const SizedBox(height: 20),
                itemBuilder: (context, index) {
                  // final blog = filteredBlogs[index];
                  final blog = controller.blogs[index];
                  return _VerticalBlogCard(blog: blog);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VerticalBlogCard extends StatefulWidget {
  final NodeElement blog;
  const _VerticalBlogCard({required this.blog});

  @override
  State<_VerticalBlogCard> createState() => _VerticalBlogCardState();
}

class _VerticalBlogCardState extends State<_VerticalBlogCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {
          context.push(
            AppRoutePath.blogdetailScreen,
            extra: {'slug': widget.blog.slug},
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.grey_94a3b8),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Image.network(
                  widget.blog.featuredImage?.node?.sourceUrl ?? "",
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              // Title + Description
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.blog.author?.node?.name ?? "",
                          style: TextStyle(
                            fontSize: 13.5,
                            color: AppColors.grey_3C403D,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          widget.blog.date != null
                              ? DateFormat(
                                "MMMM dd, yyyy",
                              ).format(widget.blog.date!)
                              : "",

                          style: TextStyle(
                            fontSize: 13.5,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.blog.title ?? "",
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Html(
                      data: widget.blog.excerpt ?? "",
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
                    if ((widget.blog.excerpt ?? "").length > 80)
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
