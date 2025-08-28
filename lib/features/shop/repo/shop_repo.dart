import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../data/network/api_client.dart';
import '../models/api_product_model.dart';
import '../models/product_detail_model.dart';

class ShopRepo {
  final _client = ApiClient().graphQLClient;

  // 1. All Products
  Future<List<ProductsNode>> getAllProducts() async {
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
  Future<List<ProductsNode>> getNewProducts() async {
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
    return (nodes as List).map((e) => ProductsNode.fromJson(e)).toList();
  }

  // 3. Products by Category
  Future<List<ProductsNode>> getProductsByCategory(String categorySlug) async {
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
    return (nodes as List).map((e) => ProductsNode.fromJson(e)).toList();
  }

  // 4. On Sale Products
  Future<List<ProductsNode>> getOnSaleProducts() async {
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
  Future<List<ProductsNode>> _fetchProducts(String query) async {
    final result = await _client.query(QueryOptions(document: gql(query)));
    if (result.hasException) throw Exception(result.exception.toString());

    final nodes = result.data?["products"]?["nodes"] ?? [];
    return (nodes as List).map((e) => ProductsNode.fromJson(e)).toList();
  }

  Future<ProductDetailModel> getProductDetail(String slug) async {
    const String query = '''
     query GetProductDetails(\$slug: ID!) {
     product(id: \$slug, idType: SLUG) {
          id
          databaseId
          name
          slug
          description
          shortDescription
          type
          ... on SimpleProduct {
            productSubtitle
            price
            regularPrice
            salePrice
            bestPrice
            stockStatus
            discountPercentage
            averageRating
            reviewCount
            totalSales
            sku
            dateOnSaleFrom
            dateOnSaleTo
            downloadable
            virtual
            featured
            weight
            faqContent {
              question
              answer
            }
            ratingBreakdown {
              count
              percentage
              star
            }
            image {
              sourceUrl
              altText
            }
            galleryImages {
              nodes {
                sourceUrl
                altText
              }
            }
            attributes {
              nodes {
                name
                label
                options
                visible
                variation
              }
            }
          }
          productCategories {
            nodes {
              name
              slug
            }
          }
          reviews(first: 10) {
            nodes {
              id
              content
              date
              rating
              author {
                node {
                  name
                  avatar {
                    url
                    width
                    height
                  }
                }
              }
            }
          }
          related(first: 8) {
            nodes {
              id
              name
              slug
              ... on SimpleProduct {
                price
                image {
                  sourceUrl
                }
              }
            }
          }
        }
      }
    ''';

    final result = await _client.query(
      QueryOptions(document: gql(query), variables: {'slug': slug}),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    return ProductDetailModel.fromJson(result.data!['product']);
  }
}
