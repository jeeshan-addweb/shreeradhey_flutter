import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../data/network/api_client.dart';
import '../models/product_model.dart';

class ShopRepo {
  final _client = ApiClient().graphQLClient;

  // 1. All Products
  Future<List<ProductModel>> getAllProducts() async {
    const query = r'''
      query GetShopProducts {
        products(first: 16, where: {orderby: {field: DATE, order: DESC}}) {
          nodes {
            ... on SimpleProduct {
              id
              name
              slug
              uri
              image { sourceUrl altText }
              productCategories { nodes { name slug } }
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
    return _fetchProducts(query);
  }

  // 2. Newly Launched Products
  Future<List<ProductModel>> getNewProducts() async {
    const query = r'''
      query GetProductsByProductLabel {
        productLabel(id: "new-arrivals", idType: SLUG) {
          products(first: 12, where: {orderby: {field: DATE, order: DESC}}) {
            nodes {
              id
              name
              slug
              uri
              image { sourceUrl altText }
              productCategories { nodes { name slug } }
              ... on SimpleProduct {
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
      }
    ''';

    final result = await _client.query(QueryOptions(document: gql(query)));
    if (result.hasException) throw Exception(result.exception.toString());

    final nodes = result.data?["productLabel"]?["products"]?["nodes"] ?? [];
    return (nodes as List).map((e) => ProductModel.fromJson(e)).toList();
  }

  // 3. Products by Category
  Future<List<ProductModel>> getProductsByCategory(String categorySlug) async {
    final query = r'''
      query GetShopProducts($category: String) {
        products(
          first: 16
          where: { orderby: { field: DATE, order: DESC }, category: $category }
        ) {
          nodes {
            ... on SimpleProduct {
              id
              name
              slug
              uri
              image { sourceUrl altText }
              productCategories { nodes { name slug } }
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
      QueryOptions(document: gql(query), variables: {"category": categorySlug}),
    );
    if (result.hasException) throw Exception(result.exception.toString());

    final nodes = result.data?["products"]?["nodes"] ?? [];
    return (nodes as List).map((e) => ProductModel.fromJson(e)).toList();
  }

  // 4. On Sale Products
  Future<List<ProductModel>> getOnSaleProducts() async {
    const query = r'''
      query GetShopProducts {
        products(
          first: 16
          where: { orderby: { field: DATE, order: DESC }, onSale: true }
        ) {
          nodes {
            ... on SimpleProduct {
              id
              name
              slug
              uri
              image { sourceUrl altText }
              productCategories { nodes { name slug } }
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
    return _fetchProducts(query);
  }

  // Common fetcher
  Future<List<ProductModel>> _fetchProducts(String query) async {
    final result = await _client.query(QueryOptions(document: gql(query)));
    if (result.hasException) throw Exception(result.exception.toString());

    final nodes = result.data?["products"]?["nodes"] ?? [];
    return (nodes as List).map((e) => ProductModel.fromJson(e)).toList();
  }
}
