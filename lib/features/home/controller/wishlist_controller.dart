import 'package:get/get.dart';
import '../repo/wishlist_repo.dart';

class WishlistController extends GetxController {
  final WishlistRepo _repo = WishlistRepo();

  var isLoading = false.obs;

  Future<Map<String, dynamic>> addToWishlist(int productId) async {
    try {
      isLoading.value = true;
      final response = await _repo.addToWishlist(productId);
      return {
        "success": response["success"] ?? false,
        "message": response["message"] ?? "Something went wrong",
      };
    } catch (e) {
      return {"success": false, "message": "Error: ${e.toString()}"};
    } finally {
      isLoading.value = false;
    }
  }

  Future<Map<String, dynamic>> removeFromWishlist(int productId) async {
    try {
      isLoading.value = true;
      final response = await _repo.removeFromWishlist(productId);
      return {
        "success": response["success"] ?? false,
        "message": response["message"] ?? "Something went wrong",
      };
    } catch (e) {
      return {"success": false, "message": "Error: ${e.toString()}"};
    } finally {
      isLoading.value = false;
    }
  }
}
