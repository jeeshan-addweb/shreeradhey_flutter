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
  var errorMessage = ''.obs;
  var orders = <OrdersNode>[].obs;
  var orderDetail = Rxn<OrderDetailModel>();

  var addresses = <CustomerAddress>[].obs;

  var updateMessage = ''.obs;
  @override
  void onInit() {
    super.onInit();
    getAddresses();
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

  Future<void> fetchOrderDetail(int orderId) async {
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
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String address,
    required String city,
    required String state,
    required String postcode,
    required String country,
    String? customerNote,
    bool billToDifferent = false,
    String paymentMethod = "cod",
    required BuildContext context,
  }) async {
    try {
      isLoading.value = true;

      // final authController = Get.find<AuthController>();
      // final customerId = authController.; // depends on your Auth flow

      final cartController = Get.find<CartController>();

      final items =
          cartController.cart.value?.data?.cart?.contents?.nodes ?? [];
      final lineItems =
          items
              .map(
                (n) => {
                  "productId": int.parse(
                    n.product?.node?.databaseId.toString() ?? "0",
                  ),
                  "quantity": n.quantity,
                },
              )
              .toList();

      final input = {
        "customerId": 975,
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
                  "firstName": firstName,
                  "lastName": lastName,
                  "address1": address,
                  "city": city,
                  "state": state,
                  "postcode": postcode,
                  "country": country,
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

      CustomSnackbars.showSuccess(
        context,
        "Order #${result.data?.createOrder?.orderId} created!",
      );
    } catch (e) {
      debugPrint("[CartController] Checkout failed: $e");
      CustomSnackbars.showError(context, "Error ${e.toString()}");
    } finally {
      isLoading.value = false;
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
