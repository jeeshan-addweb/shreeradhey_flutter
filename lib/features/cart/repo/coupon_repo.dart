import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shree_radhey/features/cart/model/get_available_coupon_model.dart';

import '../../../data/network/api_client.dart';

class CouponRepo {
  final GraphQLClient client = ApiClient().graphQLClient;

  Future<List<AvailableCoupon>> getAvailableCoupons() async {
    const String getAvailableCouponsQuery = r'''
    query GetAvailableCoupons {
      availableCoupons {
        id
        code
        amount
        discountType
        expiryDate
        usageLimit
        usageCount
        description
      }
    }
  ''';
    try {
      final result = await client.query(
        QueryOptions(
          document: gql(getAvailableCouponsQuery),
          fetchPolicy: FetchPolicy.networkOnly,
        ),
      );

      if (result.hasException) {
        throw result.exception!;
      }

      final data = result.data?['availableCoupons'] as List<dynamic>?;

      if (data == null) return [];

      return data.map((json) => AvailableCoupon.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
