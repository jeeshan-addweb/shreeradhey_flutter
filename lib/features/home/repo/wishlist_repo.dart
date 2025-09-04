import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../data/network/api_client.dart';

class WishlistRepo {
  final GraphQLClient client = ApiClient().graphQLClient;

  Future<Map<String, dynamic>> addToWishlist(int productId) async {
    const String mutation = r'''
      mutation AddToWishlist($productId:  ID!) {
        addToWishlist(input: { productId: $productId }) {
          success
          message
        }
      }
    ''';

    final result = await client.mutate(
      MutationOptions(
        document: gql(mutation),
        variables: {"productId": productId},
      ),
    );
    if (result.hasException) {
      print(result.exception.toString());
      return {"success": false, "message": result.exception.toString()};
    }

    final data = result.data?["addToWishlist"];
    return {
      "success": data?["success"] ?? false,
      "message": data?["message"] ?? "Something went wrong",
    };
  }

  Future<Map<String, dynamic>> removeFromWishlist(int productId) async {
    const String mutation = r'''
      mutation RemoveFromWishlist($productId:  Int!) {
        removeFromWishlist(input: { productId: $productId }) {
          success
          message
        }
      }
    ''';

    final result = await client.mutate(
      MutationOptions(
        document: gql(mutation),
        variables: {"productId": productId},
      ),
    );
    if (result.hasException) {
      print(result.exception.toString());
      return {"success": false, "message": result.exception.toString()};
    }

    final data = result.data?["removeFromWishlist"];
    return {
      "success": data?["success"] ?? false,
      "message": data?["message"] ?? "Something went wrong",
    };
  }
}
