import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shree_radhey/features/home/model/blog_detail_model.dart';
import 'package:shree_radhey/features/shop/models/product_mapper.dart';

import '../../../common/components/custom_snackbar.dart';
import '../../../common/model/ui_product_model.dart';
import '../../shop/repo/shop_repo.dart';
import '../model/get_blog_model.dart';
import '../repo/home_repo.dart';

class HomeController extends GetxController {
  final ShopRepo _repo = ShopRepo();
  final HomeRepo _homerepo = HomeRepo();

  var allProducts = <UiProductModel>[].obs;
  var newProducts = <UiProductModel>[].obs;
  var gheeProducts = <UiProductModel>[].obs;
  var oilProducts = <UiProductModel>[].obs;
  var comboProducts = <UiProductModel>[].obs;

  var isProductsLoading = false.obs;
  var error = "".obs;

  var isLoadingMore = false.obs;
  var blogs = <NodeElement>[].obs;
  var pageInfo = Rxn<PageInfo>();
  var hasError = false.obs;
  var errorMessage = ''.obs;
  var isBlogsLoading = false.obs;

  var isDetailLoading = false.obs;
  var blogDetail = Rxn<BlogDetailModel>();
  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchBlogs();
  // }

  Future<void> fetchHomeData() async {
    try {
      isProductsLoading.value = true;
      error.value = "";

      // fetch in parallel for performance
      final results = await Future.wait([
        _repo.getAllProducts(),
        _repo.getNewProducts(),
        _repo.getProductsByCategory("ghee"),
        _repo.getProductsByCategory("oil"),
        _repo.getProductsByCategory("combo"),
      ]);

      allProducts.assignAll(results[0].map((e) => e.toUiModel()).toList());
      newProducts.assignAll(results[1].map((e) => e.toUiModel()).toList());
      gheeProducts.assignAll(results[2].map((e) => e.toUiModel()).toList());
      oilProducts.assignAll(results[3].map((e) => e.toUiModel()).toList());
      comboProducts.assignAll(results[4].map((e) => e.toUiModel()).toList());
    } catch (e) {
      error.value = e.toString();
    } finally {
      isProductsLoading.value = false;
    }
  }

  Future<void> fetchBlogs() async {
    try {
      hasError.value = false;
      isBlogsLoading.value = true;

      final result = await _homerepo.fetchBlogs();

      if (result.data?.posts?.nodes != null) {
        blogs.value = result.data!.posts!.nodes!;
        pageInfo.value = result.data!.posts!.pageInfo;
        debugPrint("Fetched ${blogs.length} blogs");
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
      debugPrint("Error fetching blogs: $e");
    } finally {
      isBlogsLoading.value = false;
    }
  }

  Future<void> loadMoreBlogs() async {
    if (isLoadingMore.value || pageInfo.value?.hasNextPage != true) return;

    try {
      isLoadingMore.value = true;

      final result = await _homerepo.loadMoreBlogs(
        cursor: pageInfo.value!.endCursor!,
      );

      if (result.data?.posts?.nodes != null) {
        blogs.addAll(result.data!.posts!.nodes!);
        pageInfo.value = result.data!.posts!.pageInfo;
        debugPrint(
          "Loaded ${result.data!.posts!.nodes!.length} more blogs. Total: ${blogs.length}",
        );
      }
    } catch (e) {
      debugPrint("Error loading more blogs: $e");
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<void> refreshBlogs() async {
    blogs.clear();
    pageInfo.value = null;
    await fetchBlogs();
  }

  Future<void> fetchBlogDetail(BuildContext context, String slug) async {
    try {
      isDetailLoading.value = true;
      blogDetail.value = await _homerepo.getBlogDetail(slug);
      debugPrint("detail : ${blogDetail.value?.data?.toJson()}");
      //  = detail;
    } catch (e) {
      debugPrint("haalo error");
      CustomSnackbars.showError(context, "Something went wrong: $e");
      debugPrint("eRROR IS $e");
    } finally {
      isDetailLoading.value = false;
    }
  }
}
