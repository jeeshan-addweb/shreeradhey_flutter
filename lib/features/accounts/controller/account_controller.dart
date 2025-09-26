import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/components/custom_snackbar.dart';
import '../../cart/controller/cart_controller.dart';
import '../model/get_address_model.dart';
import '../model/order_detail_model.dart';
import '../model/order_history_model.dart';
import '../repo/account_repo.dart';

class AccountController extends GetxController {
  final AccountRepo _accountrepo = AccountRepo();

  var isLoading = false.obs;
  var isCheckOutLoading = false.obs;
  var errorMessage = ''.obs;
  var orders = <OrdersNode>[].obs;
  var orderDetail = Rxn<OrderDetailModel>();

  var addresses = <CustomerAddress>[].obs;

  var updateMessage = ''.obs;
  @override
  void onInit() {
    super.onInit();
    getAddresses();

    // 👇 This will run every time your `addresses` list changes
    ever(addresses, (_) {
      debugPrint("📦 Addresses loaded: ${addresses.length}");
      for (var a in addresses) {
        debugPrint(
          "- id: ${a.id}, type: ${a.addressType}, isDefault: ${a.isDefault}",
        );
      }
      debugPrint("👉 Default shipping: $defaultShippingAddress");
      debugPrint("👉 Default billing: $defaultBillingAddress");
    });
  }

  CustomerAddress? get defaultShippingAddress {
    try {
      return addresses.firstWhere(
        (a) => (a.addressType?.toLowerCase() == "shipping") && a.isDefault == 1,
      );
    } catch (_) {
      // fallback: return first shipping address if exists
      return addresses.firstWhereOrNull(
        (a) => a.addressType?.toLowerCase() == "shipping",
      );
    }
  }

  CustomerAddress? get defaultBillingAddress {
    try {
      return addresses.firstWhere(
        (a) => (a.addressType?.toLowerCase() == "billing") && a.isDefault == 1,
      );
    } catch (_) {
      // fallback: return first billing address if exists
      return addresses.firstWhereOrNull(
        (a) => a.addressType?.toLowerCase() == "billing",
      );
    }
  }

  Future<void> fetchOrders({int first = 10, String? after}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final response = await _accountrepo.getCustomerOrders(
        first: first,
        after: after,
      );
      orders.assignAll(response.nodes ?? []);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchOrderDetail(String orderId) async {
    try {
      isLoading.value = true;
      final data = await _accountrepo.getOrderDetail(orderId);

      orderDetail.value = data;
    } catch (e) {
      print("Error fetching order details: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkout({
    // Billing
    required int customerId,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String address,
    required String city,
    required String state,
    required String postcode,
    required String country,
    // Optional note
    String? customerNote,
    // Shipping (only if different)
    String? shippingFirstName,
    String? shippingLastName,
    String? shippingAddress,
    String? shippingCity,
    String? shippingState,
    String? shippingPostcode,
    String? shippingCountry,
    bool billToDifferent = false,
    String? paymentMethod,
    required BuildContext context,
  }) async {
    try {
      isCheckOutLoading.value = true;

      final cartController = Get.find<CartController>();
      await cartController.fetchCartItems();

      final items =
          cartController.cart.value?.data?.cart?.contents?.nodes ?? [];

      final lineItems =
          items
              .where(
                (n) => n.product?.node?.databaseId != null,
              ) // skip invalid products
              .map(
                (n) => {
                  "productId": n.product?.node!.databaseId!,
                  "quantity": n.quantity ?? 1,
                },
              )
              .toList();

      if (lineItems.isEmpty) {
        CustomSnackbars.showError(context, "Cart has no valid products");
        isCheckOutLoading.value = false;
        return;
      }

      final input = {
        "customerId": customerId,
        "customerNote": customerNote ?? "",
        "paymentMethod": paymentMethod,
        "paymentMethodTitle":
            paymentMethod == "cod" ? "Cash on Delivery" : "Razorpay",
        "isPaid": paymentMethod != "cod",
        "status": "PROCESSING",
        "coupons": [],
        "billing": {
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "phone": phone,
          "address1": address,
          "city": city,
          "state": state,
          "postcode": postcode,
          "country": country,
        },
        "shipping":
            billToDifferent
                ? {
                  "firstName": shippingFirstName ?? firstName,
                  "lastName": shippingLastName ?? lastName,
                  "address1": shippingAddress ?? address,
                  "city": shippingCity ?? city,
                  "state": shippingState ?? state,
                  "postcode": shippingPostcode ?? postcode,
                  "country": shippingCountry ?? country,
                }
                : {
                  "firstName": firstName,
                  "lastName": lastName,
                  "address1": address,
                  "city": city,
                  "state": state,
                  "postcode": postcode,
                  "country": country,
                },
        "lineItems": lineItems,
      };

      final result = await _accountrepo.createOrder(input);
      debugPrint(
        "[CartController] Order Created → ${result.data?.createOrder?.orderId}",
      );
      await cartController.emptyCart();

      CustomSnackbars.showSuccess(context, "Order created!");
    } on TimeoutException {
      debugPrint(
        "[CartController] Order likely created but response timed out",
      );
      CustomSnackbars.showSuccess(
        context,
        "Your order is being processed. Please check Orders page.",
      );
    } catch (e) {
      debugPrint("[CartController] Checkout failed: $e");
      WidgetsBinding.instance.addPostFrameCallback((_) {
        CustomSnackbars.showError(context, "Checkout failed:");
      });
    } finally {
      isCheckOutLoading.value = false;
    }
  }

  Future<void> saveOrUpdateAddress(
    Map<String, dynamic> address,
    BuildContext context,
  ) async {
    try {
      isLoading.value = true;
      final response = await _accountrepo.saveAddress(address);

      if (response['success'] == true) {
        if (context.mounted) {
          CustomSnackbars.showSuccess(
            context,
            response['message'] ?? "Address saved",
          );
        }
        await getAddresses();
      } else {
        if (context.mounted) {
          CustomSnackbars.showError(
            context,
            response['message'] ?? "Could not save address",
          );
        }
      }
    } catch (e) {
      debugPrint("SaveOrUpdateAddress  Error: $e");
      if (context.mounted) {
        CustomSnackbars.showError(context, "Something went wrong");
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getAddresses() async {
    try {
      isLoading.value = true;
      final response = await _accountrepo.fetchCustomerAddresses();
      addresses.value = response?.data?.customerAddresses ?? [];
    } catch (e) {
      debugPrint("Error, ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteAddress(int id, int userId, BuildContext context) async {
    try {
      isLoading.value = true;
      final response = await _accountrepo.deleteAddress(id, userId);

      if (response['success'] == true) {
        if (context.mounted) {
          CustomSnackbars.showSuccess(
            context,
            response['message'] ?? "Address deleted",
          );
        }
        await getAddresses();
      } else {
        if (context.mounted) {
          CustomSnackbars.showError(
            context,
            response['message'] ?? "Could not delete",
          );
        }
      }
    } catch (e) {
      debugPrint("DeleteAddress Error: $e");
      if (context.mounted) {
        CustomSnackbars.showError(context, "Something went wrong");
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateCustomer({
    required String firstName,
    required String lastName,
    required String displayName,
    required String email,
  }) async {
    try {
      isLoading.value = true;

      final result = await _accountrepo.updateCustomer(
        firstName: firstName,
        lastName: lastName,
        displayName: displayName,
        email: email,
      );

      if (result != null) {
        updateMessage.value =
            result['message'] ?? "Profile updated successfully!";
      } else {
        updateMessage.value = "Failed to update profile.";
      }
    } catch (e) {
      updateMessage.value = "Error: $e";
    } finally {
      isLoading.value = false;
    }
  }
}
