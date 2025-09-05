import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/components/custom_snackbar.dart';
import '../model/add_to_cart_model.dart';
import '../repo/cart_repo.dart';

class CartController extends GetxController {
  final CartRepo _repo = CartRepo();

  var isLoading = false.obs;
  var cart = Rxn<AddToCartModel>();

  // Alternative approach - pass context from UI
  Future<void> addProductToCart(
    int productId,
    int quantity,
    BuildContext context,
  ) async {
    try {
      isLoading.value = true;
      final response = await _repo.addToCart(productId, quantity);
      cart.value = response;

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
