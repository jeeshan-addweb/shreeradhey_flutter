import 'package:graphql_flutter/graphql_flutter.dart';
import '../../../data/network/api_client.dart';
import '../models/get_product_variant_model.dart';

class ProductVariantRepo {
  final _client = ApiClient().graphQLClient;

  Future<List<ProductsNode>> fetchProductVariants(String category) async {
    const String query = r'''
      query GetShopProducts($category: String!) {
        products(
          first: 16
          where: {
            orderby: { field: DATE, order: DESC }
            category: $category
          }
        ) {
          nodes {
            ... on SimpleProduct {
              id
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
              productSubtitle
              price
              regularPrice
              salePrice
              bestPrice
              discountPercentage
              averageRating
              reviewCount
            }
          }
        }
      }
    ''';

    final result = await _client.query(
      QueryOptions(document: gql(query), variables: {"category": category}),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final List productsJson = result.data?['products']?['nodes'] ?? [];
    return productsJson.map((json) => ProductsNode.fromJson(json)).toList();
  }
}
