import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shree_radhey/common/model/ui_product_model.dart';
import 'package:shree_radhey/features/shop/models/product_mapper.dart';
import '../../../common/components/custom_snackbar.dart';
import '../models/api_product_model.dart';
import '../models/product_detail_model.dart';
import '../repo/shop_repo.dart';

class ShopController extends GetxController {
  final ShopRepo _repo = ShopRepo();

  var products = <UiProductModel>[].obs;
  var isLoading = false.obs;
  var error = "".obs;

  var isDetailLoading = false.obs;
  var productDetail = Rxn<ProductDetailModel>();

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
      isDetailLoading.value = true;
      productDetail.value = await _repo.getProductDetail(slug);
      debugPrint("detail : ${productDetail.value?.data?.toJson()}");
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
