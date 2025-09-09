import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/components/custom_snackbar.dart';
import '../model/get_cart_model.dart';
import '../repo/cart_repo.dart';

class CartController extends GetxController {
  final CartRepo _repo = CartRepo();

  var isLoading = false.obs;
  var cart = Rxn<GetCartModel>();
  // dedocated for cart
  var isFetchingCart = false.obs;

  var updatingItems = <String, bool>{}.obs;

  var addingItems = <int, bool>{}.obs;

  // Coupon
  var errorMessage = "".obs;
  var coupons = <Coupon>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCartItems();
  }

  bool isInCart(int productId) {
    final nodes = cart.value?.data?.cart?.contents?.nodes ?? [];
    final found = nodes.any(
      (node) => node.product?.node?.id == productId.toString(),
    );
    debugPrint("[CartController] isInCart($productId) → $found");
    return found;
  }

  Future<void> fetchCartItems({BuildContext? context}) async {
    try {
      isFetchingCart.value = true;
      debugPrint('[CartController] fetchCartItems - starting');
      final response = await _repo.getCartItems();
      cart.value = response;
      debugPrint(
        '[CartController] fetchCartItems - success: items = ${response.data?.cart?.contents?.itemCount ?? 0}',
      );
    } catch (e) {
      debugPrint('[CartController] fetchCartItems - error: $e');
      if (context != null) {
        CustomSnackbars.showError(context, "Failed to fetch cart: $e");
      }
    } finally {
      isFetchingCart.value = false;
      debugPrint('[CartController] fetchCartItems - finished');
    }
  }

  Future<void> updateQuantity(String key, int quantity) async {
    if (key.isEmpty) return;
    try {
      updatingItems[key] = true;
      debugPrint(
        '[CartController] updateQuantity - start key:$key qty:$quantity',
      );
      final response = await _repo.updateCartItem(key, quantity);
      cart.value = response;
      debugPrint('[CartController] updateQuantity - success key:$key');
    } catch (e, st) {
      debugPrint('[CartController] updateQuantity - error: $e\n$st');
      print("Error updating quantity: $e");
    } finally {
      updatingItems[key] = false;
      debugPrint('[CartController] updateQuantity - finished key:$key');
    }
  }

  Future<void> removeItem(String key) async {
    try {
      isLoading.value = true;
      cart.value = await _repo.removeCartItem(key);
    } catch (e) {
      print("Error removing item: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Alternative approach - pass context from UI
  Future<void> addProductToCart(
    int productId,
    int quantity,
    BuildContext context,
  ) async {
    try {
      addingItems[productId] = true;

      final result = await _repo.addToCart(productId, quantity);
      if (result != null) {
        cart.value = result; // refresh cart
        debugPrint("[CartController] Added product $productId ✅");
        await fetchCartItems();
      }

      CustomSnackbars.showSuccess(
        context,
        "Product added to cart successfully!",
      );
    } catch (e) {
      debugPrint("[CartController] Error adding $productId: $e");

      CustomSnackbars.showError(context, "Failed to add product: $e");
    } finally {
      addingItems[productId] = false;
    }
  }

  Future<void> applyCoupon(String code) async {
    try {
      isLoading.value = true;
      errorMessage.value = "";
      final updatedCart = await _repo.applyCoupon(code);
      if (updatedCart != null) {
        cart.value = updatedCart;
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // Remove coupon
  Future<void> removeCoupon(String code) async {
    try {
      isLoading.value = true;
      errorMessage.value = "";
      final updatedCart = await _repo.removeCoupon(code);
      if (updatedCart != null) {
        cart.value = updatedCart;
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}

class Coupon {
  final String code;
  final String? discountAmount;

  Coupon({required this.code, this.discountAmount});
}
