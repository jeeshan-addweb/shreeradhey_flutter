import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shree_radhey/features/shop/controller/shop_controller.dart';
import '../../../common/components/custom_snackbar.dart';
import '../../auth/controller/auth_controller.dart';
import '../model/cart_shipping_method_model.dart';
import '../model/get_cart_model.dart';
import '../repo/cart_repo.dart';

class CartController extends GetxController {
  final CartRepo _repo = CartRepo();
  final TextEditingController couponControllerText = TextEditingController();

  var isLoading = false.obs;
  var cart = Rxn<GetCartModel>();
  // dedocated for cart
  var isFetchingCart = false.obs;
  var isUpdatingCart = false.obs;

  var updatingItems = <String, bool>{}.obs;

  var addingItems = <int, bool>{}.obs;

  // Coupon
  var errorMessage = "".obs;
  var coupons = <Coupon>[].obs;
  final appliedCoupon = RxnString();

  var cartCount = 0.obs;

  // Shipping Method
  var isShippingLoading = false.obs;
  var shippingMethod = <AvailableShippingMethodCart>[].obs;
  @override
  void onInit() {
    super.onInit();

    final authController = Get.find<AuthController>();

    // Only fetch when token is available
    ever(authController.token, (tok) {
      if (tok != null && tok.toString().isNotEmpty) {
        fetchCartItems();
      }
    });

    // If token is already present at startup
    if (authController.token.isNotEmpty) {
      // Schedule after build completes to ensure UI can react
      Future.delayed(Duration.zero, () {
        fetchCartItems();
      });
    }
  }

  void clearCart() {
    cart.value = null; // clear local reactive cart object
    cartCount.value = 0;
  }

  void updateCartCount() {
    final count = cart.value?.data?.cart?.contents?.itemCount ?? 0;

    debugPrint(
      "[CartController] itemCount from API → "
      "${cart.value?.data?.cart?.contents?.itemCount}",
    );
    debugPrint(
      "[CartController] nodes length → "
      "${cart.value?.data?.cart?.contents?.nodes?.length}",
    );

    cartCount.value = count;
    debugPrint("[CartController] cartCount updated → $count");
  }

  bool isInCart(int productId) {
    final nodes = cart.value?.data?.cart?.contents?.nodes ?? [];
    final found = nodes.any(
      (node) => node.product?.node?.databaseId == productId,
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
      updateCartCount();
      final appliedCoupons = response.data?.cart?.appliedCoupons;
      if (appliedCoupons != null && appliedCoupons.isNotEmpty) {
        appliedCoupon.value = appliedCoupons.first.code;
        couponControllerText.text = appliedCoupon.value!;
      } else {
        appliedCoupon.value = null;
        couponControllerText.clear();
      }
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

  Future<void> emptyCart() async {
    try {
      isLoading.value = true;

      await _repo.emptyCart();
      clearCart();

      debugPrint("[CartController] Cart emptied successfully");
    } catch (e) {
      debugPrint("[CartController] Failed to empty cart: $e");
    } finally {
      isLoading.value = false;
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
      if (response != null) {
        cart.value = response;
        updateCartCount();
      }

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
      isUpdatingCart.value = true;
      cart.value = await _repo.removeCartItem(key);
      updateCartCount();
      await fetchCartItems();
      final shopController = Get.find<ShopController>();
      shopController.fetchProducts("all");
    } catch (e) {
      print("Error removing item: $e");
    } finally {
      isUpdatingCart.value = false;
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
        await fetchCartItems();
        updateCartCount();
        debugPrint("[CartController] Added product $productId ✅");
        // await fetchCartItems();
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

  Future<void> applyCoupon(String code, BuildContext context) async {
    try {
      if (appliedCoupon.value == code) {
        CustomSnackbars.showSuccess(context, "Coupon already applied");
        return;
      }

      isUpdatingCart.value = true;
      errorMessage.value = "";

      final response = await _repo.applyCoupon(code);

      if (response != null) {
        if (response.cart != null) {
          cart.value = response.cart;
          appliedCoupon.value = code;
          couponControllerText.text = code;
          updateCartCount();
        }

        if (response.message != null) {
          CustomSnackbars.showSuccess(context, response.message!);
        }
      }
    } on OperationException catch (e) {
      // Handle GraphQL exceptions explicitly
      debugPrint("[applyCoupon] GraphQL Error: ${e.graphqlErrors}");

      String message = "Something went wrong";
      if (e.graphqlErrors.isNotEmpty) {
        final errorMsg = e.graphqlErrors.first.message.toLowerCase();
        if (errorMsg.contains("already been applied")) {
          message = "Coupon already applied";
        } else if (errorMsg.contains(
          "cannot be applied because it does not exist",
        )) {
          message = "Coupon is invalid";
        } else {
          message = e.graphqlErrors.first.message;
        }
      }

      // Reset applied coupon safely
      appliedCoupon.value = null;
      couponControllerText.clear();

      // Show snackbar
      CustomSnackbars.showError(context, message);
    } catch (e) {
      errorMessage.value = e.toString();
      debugPrint(e.toString());

      String message = "Something went wrong";
      if (e.toString().contains("already been applied")) {
        message = "Coupon already applied";
      } else if (e.toString().contains(
        "cannot be applied because it does not exist",
      )) {
        message = "Coupon is invalid";
      }

      CustomSnackbars.showError(context, message);
      appliedCoupon.value = null;
    } finally {
      isUpdatingCart.value = false;
    }
  }

  // Remove coupon
  Future<void> removeCoupon(String code, BuildContext context) async {
    try {
      isLoading.value = true;
      errorMessage.value = "";
      final response = await _repo.removeCoupon(code);
      if (response != null) {
        if (response.cart != null) {
          cart.value = response.cart;
          appliedCoupon.value = null;
          couponControllerText.clear();
        }

        if (response.message != null) {
          CustomSnackbars.showSuccess(context, response.message!);
        }
        // await fetchCartItems();
      }
    } catch (e) {
      errorMessage.value = e.toString();
      CustomSnackbars.showError(context, "$e Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchAvailableShippingMethod() async {
    try {
      isShippingLoading.value = true;
      errorMessage.value = '';
      final result = await _repo.getAvailableShippingMethod();
      shippingMethod.assignAll(result);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isShippingLoading.value = false;
    }
  }
}

class Coupon {
  final String code;
  final String? discountAmount;

  Coupon({required this.code, this.discountAmount});
}
