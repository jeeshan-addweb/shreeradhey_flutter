import 'package:get/get.dart';
import 'package:shree_radhey/features/accounts/repo/account_repo.dart';

import '../model/order_detail_model.dart';
import '../model/order_history_model.dart';

class AccountController extends GetxController {
  final AccountRepo _accountrepo = AccountRepo();

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var orders = <OrdersNode>[].obs;
  var orderDetail = Rxn<OrderDetailModel>();

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
}
