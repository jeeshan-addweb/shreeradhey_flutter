import 'package:get/get.dart';
import 'package:shree_radhey/features/cart/model/get_available_coupon_model.dart';

import '../repo/coupon_repo.dart';

class CouponController extends GetxController {
  final CouponRepo _repo = CouponRepo();

  var coupons = <AvailableCoupon>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCoupons();
  }

  Future<void> fetchCoupons() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final result = await _repo.getAvailableCoupons();
      coupons.assignAll(result);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
