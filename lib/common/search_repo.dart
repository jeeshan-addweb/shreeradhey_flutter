import 'package:graphql_flutter/graphql_flutter.dart';
import '../data/network/api_client.dart';
import '../features/shop/models/api_product_model.dart';

class SearchRepo {
  final _client = ApiClient().graphQLClient;

  Future<List<ProductsNode>> searchProducts(String searchText) async {
    const String searchQuery = r'''
     query SearchProducts($search: String!) {
 products(where: { search: $search }) {
   nodes {
     id
     databaseId
     name
     slug
     sku
     type
     image {
       sourceUrl
       altText
     }
     ... on SimpleProduct {
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
      }}
       databaseId
       currencySymbol
       price
       regularPrice
       salePrice
       bestPrice
       discountPercentage
       isInWishlist
       isInCart
       averageRating
       reviewCount
     }
   }
 }
}

    ''';

    return _fetchProducts(searchQuery, {"search": searchText});
  }

  Future<List<ProductsNode>> _fetchProducts(
    String query,
    Map<String, dynamic> variables,
  ) async {
    final result = await _client.query(
      QueryOptions(document: gql(query), variables: variables),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final nodes = result.data?["products"]?["nodes"] ?? [];
    return (nodes as List).map((e) => ProductsNode.fromJson(e)).toList();
  }
}
