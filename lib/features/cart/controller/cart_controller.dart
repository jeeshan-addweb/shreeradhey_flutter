import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/components/custom_snackbar.dart';
import '../model/add_to_cart_model.dart';
import '../model/get_cart_model.dart';
import '../repo/cart_repo.dart';

class CartController extends GetxController {
  final CartRepo _repo = CartRepo();

  var isLoading = false.obs;
  var cart = Rxn<GetCartModel>();

  @override
  void onInit() {
    super.onInit();
    fetchCartItems();
  }

  Future<void> fetchCartItems({BuildContext? context}) async {
    try {
      isLoading.value = true;
      final response = await _repo.getCartItems();
      cart.value = response;
    } catch (e) {
      print("Error fetching cart items: $e");
      if (context != null) {
        CustomSnackbars.showError(context, "Failed to fetch cart: $e");
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateQuantity(String key, int quantity) async {
    try {
      isLoading.value = true;
      cart.value = await _repo.updateCartItem(key, quantity);
    } catch (e) {
      print("Error updating quantity: $e");
    } finally {
      isLoading.value = false;
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
      isLoading.value = true;

      cart.value = await _repo.addToCart(productId, quantity);

      CustomSnackbars.showSuccess(
        context,
        "Product added to cart successfully!",
      );
    } catch (e) {
      print("Error adding to cart: $e");
      CustomSnackbars.showError(context, "Failed to add product: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
