import 'package:get/get.dart';
import 'package:shree_radhey/features/home/model/get_wishlist_model.dart';
import '../repo/wishlist_repo.dart';

class WishlistController extends GetxController {
  final WishlistRepo _repo = WishlistRepo();

  // Demo
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
        response = await _repo.removeFromWishlist(productId);
        wishlistMap[productId] = false;
      } else {
        response = await _repo.addToWishlist(productId);
        wishlistMap[productId] = true;
      }

      // Optionally refresh the wishlist to keep in sync with server
      await fetchWishlist();

      return {
        "success": response["success"] ?? false,
        "message": response["message"] ?? "Something went wrong",
      };
    } catch (e) {
      return {"success": false, "message": "Error: ${e.toString()}"};
    }
  }
}


  // var isLoading = false.obs;
  // var errorMessage = "".obs;
  // var wishlist = <WishlistProduct>[].obs;

  // var isProcessing = false.obs;

  // Future<void> fetchWishlist() async {
  //   try {
  //     isLoading.value = true;
  //     errorMessage.value = '';
  //     final result = await _repo.getWishlist();
  //     wishlist.assignAll(result);
  //   } catch (e) {
  //     errorMessage.value = e.toString();
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  // Future<Map<String, dynamic>> addToWishlist(int productId) async {
  //   try {
  //     isProcessing.value = true;
  //     final response = await _repo.addToWishlist(productId);
  //     await fetchWishlist();
  //     return {
  //       "success": response["success"] ?? false,
  //       "message": response["message"] ?? "Something went wrong",
  //     };
  //   } catch (e) {
  //     return {"success": false, "message": "Error: ${e.toString()}"};
  //   } finally {
  //     isProcessing.value = false;
  //   }
  // }

  // Future<Map<String, dynamic>> removeFromWishlist(int productId) async {
  //   try {
  //     isProcessing.value = true;
  //     final response = await _repo.removeFromWishlist(productId);
  //     await fetchWishlist();
  //     return {
  //       "success": response["success"] ?? false,
  //       "message": response["message"] ?? "Something went wrong",
  //     };
  //   } catch (e) {
  //     return {"success": false, "message": "Error: ${e.toString()}"};
  //   } finally {
  //     isProcessing.value = false;
  //   }
  // }

