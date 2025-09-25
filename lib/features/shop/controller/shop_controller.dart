import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shree_radhey/common/model/ui_product_model.dart';
import 'package:shree_radhey/features/shop/models/get_review_by_products_model.dart';
import 'package:shree_radhey/features/shop/models/product_mapper.dart';
import '../../../common/components/custom_snackbar.dart';
import '../models/api_product_model.dart';
import '../models/product_detail_model.dart';
import '../repo/shop_repo.dart';
import 'product_variant_controller.dart';

class ShopController extends GetxController {
  final ShopRepo _repo = ShopRepo();

  var products = <UiProductModel>[].obs;
  var isLoading = false.obs;
  var error = "".obs;

  var isDetailLoading = false.obs;
  var isVariantLoading = false.obs;
  var productDetail = Rxn<ProductDetailModel>();

  var reviews = <NodeElement>[].obs;
  var isReviewLoading = false.obs;
  var hasMoreReviews = true.obs;
  var reviewCursor = "".obs;

  var isSubmitting = false.obs;

  var deliveryData = Rxn<Map<String, dynamic>>();
  void resetDelivery() {
    deliveryData.value = null;
    error.value = "";
    isLoading.value = false;
  }

  Future<void> fetchProducts(String category) async {
    try {
      isLoading.value = true;
      error.value = "";
      List<ProductsNode> apiData = [];

      switch (category) {
        case "All":
          apiData = await _repo.getAllProducts();
          break;
        case "New":
          apiData = await _repo.getNewProducts();
          break;
        case "Ghee":
          apiData = await _repo.getProductsByCategory("ghee");
          break;
        case "Oil":
          apiData = await _repo.getProductsByCategory("oil");
          break;
        case "Combo":
          apiData = await _repo.getProductsByCategory("combo");
          break;
        case "On Sale":
          apiData = await _repo.getOnSaleProducts();
          break;
        case "Best Seller":
          apiData = await _repo.getBestSellerProducts();
          break;
      }

      products.assignAll(apiData.map((e) => e.toUiModel()).toList());
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchProductDetail(BuildContext context, String slug) async {
    try {
      isVariantLoading.value = true;
      isLoading.value = true;
      final detail = await _repo.getProductDetail(slug);
      productDetail.value = detail;

      // 🔑 Auto-select the matching variant
      final variants = Get.find<ProductVariantController>().productVariants;
      final index = variants.indexWhere(
        (v) => v.slug == detail.data?.product?.slug, // or databaseId
      );
      if (index != -1) {
        Get.find<ProductVariantController>().setSelectedVariant(index);
      }
    } finally {
      isLoading.value = false;
      isVariantLoading.value = false;
    }
  }

  Future<void> fetchProductReviews(String slug, {bool loadMore = false}) async {
    try {
      if (!loadMore) {
        isReviewLoading.value = true;
        reviews.clear();
        reviewCursor.value = "";
        hasMoreReviews.value = true;
      }

      final result = await _repo.getProductReviews(
        productSlug: slug,
        first: 5,
        after: loadMore ? reviewCursor.value : null,
      );

      reviews.addAll(result);

      // handle pagination
      final pageInfo = result.isNotEmpty ? result.last : null;
    } catch (e) {
      print("Review fetch error: $e");
    } finally {
      isReviewLoading.value = false;
    }
  }

  Future<void> submitReview({
    required BuildContext context,
    required String productId,
    required String author,
    required String email,
    required String content,
    required int rating,
  }) async {
    try {
      isSubmitting.value = true;
      final res = await _repo.addReview(
        productId: productId,
        author: author,
        email: email,
        content: content,
        rating: rating,
      );

      if (res['success'] == true) {
        CustomSnackbars.showSuccess(context, "Review submitted successfully!");
      } else {
        CustomSnackbars.showError(
          context,
          "Failed to submit review. Try again!",
        );
      }
    } catch (e) {
      debugPrint("Error $e");
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> checkDelivery(int postcode) async {
    try {
      isLoading.value = true;
      error.value = "";
      deliveryData.value = null;

      final data = await _repo.getDeliveryEstimate(postcode);
      deliveryData.value = data;
    } catch (e) {
      error.value = e.toString().replaceAll("Exception:", "").trim();
    } finally {
      isLoading.value = false;
    }
  }
}
