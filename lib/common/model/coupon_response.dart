import '../../features/cart/model/get_cart_model.dart';

class CouponResponse {
  final GetCartModel? cart;
  final String? message;

  CouponResponse({this.cart, this.message});
}
