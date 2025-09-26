import 'package:get/get.dart';
import 'package:shree_radhey/features/home/model/get_wishlist_model.dart';
import '../repo/wishlist_repo.dart';

class WishlistController extends GetxController {
  final WishlistRepo _repo = WishlistRepo();
  RxMap<int, bool> wishlistMap = <int, bool>{}.obs;

  var isLoading = false.obs;
  var wishlist = <WishlistProduct>[].obs;

  Future<void> fetchWishlist() async {
    try {
      isLoading.value = true;
      final result = await _repo.getWishlist();
      wishlist.assignAll(result);

      // Update map
      wishlistMap.clear();
      for (var product in result) {
        wishlistMap[product.databaseId!] = true;
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<Map<String, dynamic>> toggleWishlist(int productId) async {
    try {
      bool isCurrentlyWishlisted = wishlistMap[productId] == true;

      Map<String, dynamic> response;

      if (isCurrentlyWishlisted) {
        wishlistMap[productId] = false;
        wishlist.removeWhere((p) => p.databaseId == productId);
        response = await _repo.removeFromWishlist(productId);
        if (!(response["success"] ?? false)) {
          wishlistMap[productId] = true;
          await fetchWishlist();
        }
      } else {
        wishlistMap[productId] = true;
        response = await _repo.addToWishlist(productId);
        if (!(response["success"] ?? false)) {
          wishlistMap[productId] = false;
          await fetchWishlist();
        } else {}
      }

      return {
        "success": response["success"] ?? false,
        "message": response["message"] ?? "Something went wrong",
      };
    } catch (e) {
      return {"success": false, "message": "Error: ${e.toString()}"};
    }
  }
}
