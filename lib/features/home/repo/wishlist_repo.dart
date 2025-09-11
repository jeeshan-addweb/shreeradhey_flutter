import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../data/network/api_client.dart';
import '../model/get_wishlist_model.dart';

class WishlistRepo {
  final GraphQLClient client = ApiClient().graphQLClient;

  Future<List<WishlistProduct>> getWishlist() async {
    const String query = r'''
 query GetWishlistProducts {
 wishlistProducts {
   id
   databaseId
   name
   slug
   uri
   image {
     sourceUrl
     altText
   }
   productCategories {
     nodes {
       name
       slug
     }
   }
   productLabels {
     nodes {
       id
       name
       slug
     }
   }
   currencySymbol
   price
   regularPrice
   salePrice
   bestPrice
   discountPercentage
   averageRating
   reviewCount
 }
}

  ''';
    try {
      final result = await client.query(
        QueryOptions(
          document: gql(query),
          fetchPolicy: FetchPolicy.networkOnly,
        ),
      );

      if (result.hasException) {
        throw result.exception!;
      }

      final data = result.data?['wishlistProducts'] as List<dynamic>?;

      if (data == null) return [];

      return data.map((json) => WishlistProduct.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

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
