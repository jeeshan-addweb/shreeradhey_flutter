import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shree_radhey/features/shop/models/get_review_by_products_model.dart';

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
       databaseId
       isInWishlist
       isInCart
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
   }
}

    ''';
    return _fetchProducts(query);
  }

  // 2. Newly Launched Products
  Future<List<ProductsNode>> getNewProducts() async {
    const query = r'''
     query GetProductsByProductLabel {
 productLabel(id: "newly-launch", idType: SLUG) {
   name
   slug
   products(first: 12, where: {orderby: {field: DATE, order: DESC}}) {
     nodes {
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
       ... on SimpleProduct {
       databaseId
isInWishlist
isInCart
         price
         regularPrice
         salePrice
         bestPrice
         discountPercentage
         currencySymbol
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
              databaseId
              isInWishlist
              isInCart
              uri
              image { sourceUrl altText }
              productCategories { nodes { name slug } }
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
              databaseId
              isInWishlist
              isInCart
              uri
              image { sourceUrl altText }
              productCategories { nodes { name slug } }
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
    String query = '''
    query GetProductDetails {
    product(id: "$slug" , idType: SLUG) {
    id
    databaseId
    name
    slug
    description
    shortDescription
    type
    ... on SimpleProduct {
      productSubtitle
      isInWishlist
      isInCart
      price
      regularPrice
      salePrice
      bestPrice
      currencySymbol
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
     productLabels {
       nodes {
         id
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

    debugPrint("result.data : ${result.data}");

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    if (result.data != null) {
      debugPrint("haalo");
      ProductDetailModel productDetailModel = ProductDetailModel.fromJson({
        "data": result.data,
      });
      debugPrint("productDetailModel : ${productDetailModel.data}");
      return productDetailModel;
    } else {
      throw Exception("No Data Found");
    }
  }

  Future<List<NodeElement>> getProductReviews({
    String? productSlug,
    int? first,
    String? after,
  }) async {
    final variables = {
      "productSlug": productSlug,
      "first": first,
      "after": after,
    };
    const query = r'''
    query GetProductReviews($productSlug: ID!, $first: Int!, $after: String) {
      product(id: $productSlug, idType: SLUG) {
        reviews(first: $first, after: $after, where: { orderby: COMMENT_DATE, order: DESC }) {
          pageInfo {
            hasNextPage
            endCursor
          }
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
                }
              }
            }
          }
        }
      }
    }
  ''';

    final result = await _client.query(
      QueryOptions(
        document: gql(query),
        variables: variables,
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final nodes = result.data?['product']?['reviews']?['nodes'] ?? [];
    return (nodes as List)
        .map((e) => NodeElement.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Map<String, dynamic>> addReview({
    required String productId,
    required String author,
    required String email,
    required String content,
    required int rating,
  }) async {
    const String mutation = r'''
      mutation AddReview(
        $productId: ID!,
        $author: String!,
        $email: String!,
        $content: String!,
        $rating: Int!
      ) {
        createProductReview(
          input: {
            productId: $productId,
            author: $author,
            email: $email,
            content: $content,
            rating: $rating
          }
        ) {
          success
          commentId
        }
      }
    ''';

    final result = await _client.mutate(
      MutationOptions(
        document: gql(mutation),
        variables: {
          "productId": productId,
          "author": author,
          "email": email,
          "content": content,
          "rating": rating,
        },
      ),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    return result.data?['createProductReview'] ?? {};
  }

  Future<List<ProductsNode>> getBestSellerProducts() async {
    const query = r'''
     query GetProductsByProductLabel {
productLabel(id: "best-seller", idType: SLUG) {
name
slug
products(first: 12, where: {orderby: {field: DATE, order: DESC}}) {
  nodes {
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
    ... on SimpleProduct {
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
}
    ''';

    final result = await _client.query(QueryOptions(document: gql(query)));
    if (result.hasException) throw Exception(result.exception.toString());

    final nodes = result.data?["productLabel"]?["products"]?["nodes"] ?? [];
    return (nodes as List).map((e) => ProductsNode.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>> getDeliveryEstimate(int postcode) async {
    const String query = r'''
      query GetPostcodeData($postcode: Int!) {
        postcodeData(postcode: $postcode) {
          postcode
          city
          state
          country
          latitude
          longitude
          address
          estimatedDelivery
        }
      }
    ''';

    final result = await _client.query(
      QueryOptions(document: gql(query), variables: {"postcode": postcode}),
    );

    if (result.hasException) {
      throw Exception(
        result.exception?.graphqlErrors.first.message ?? "Something went wrong",
      );
    }

    return result.data?["postcodeData"] as Map<String, dynamic>;
  }
}
