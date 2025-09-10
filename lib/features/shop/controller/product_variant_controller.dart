import 'package:get/get.dart';

import '../models/get_product_variant_model.dart';
import '../repo/product_variant_repo.dart';

class ProductVariantController extends GetxController {
  final ProductVariantRepo _repo = ProductVariantRepo();

  var isLoading = false.obs;
  var productVariants = <ProductsNode>[].obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchProductVariants(catehory);
  // }

  Future<void> fetchProductVariants(String category) async {
    try {
      isLoading.value = true;
      final products = await _repo.fetchProductVariants(category);
      productVariants.assignAll(products);
    } catch (e) {
      print("Error fetching product variants: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
