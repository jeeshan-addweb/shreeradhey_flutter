import 'package:get/get.dart';
import '../models/product_model.dart';
import '../repo/shop_repo.dart';

class ShopController extends GetxController {
  final ShopRepo _repo = ShopRepo();

  var products = <ProductModel>[].obs;
  var isLoading = false.obs;
  var error = "".obs;

  Future<void> fetchProducts(String category) async {
    try {
      isLoading.value = true;
      error.value = "";
      List<ProductModel> data = [];

      switch (category) {
        case "All":
          data = await _repo.getAllProducts();
          break;
        case "New":
          data = await _repo.getNewProducts();
          break;
        case "Ghee":
          data = await _repo.getProductsByCategory("ghee");
          break;
        case "Oil":
          data = await _repo.getProductsByCategory("oil");
          break;
        case "Combo":
          data = await _repo.getProductsByCategory("combo");
          break;
        case "On Sale":
          data = await _repo.getOnSaleProducts();
          break;
      }

      products.assignAll(data);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
