import 'dart:async';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../common/model/coupon_response.dart';
import '../../../data/network/api_client.dart';
import '../model/cart_shipping_method_model.dart';
import '../model/get_cart_model.dart';

class CartRepo {
  final GraphQLClient client = ApiClient().graphQLClient;

  Future<GetCartModel> getCartItems() async {
    const String query = r'''
     query GetCartItems {
  cart {
    currencySymbol
    subtotal
    total
    discountTotal
    discountTax
    shippingTotal
    totalTax
    chosenShippingMethods
    availableShippingMethods {
      rates {
        id
        label
        cost
      }
    }
    fees {
      name
      total
    }
    appliedCoupons {
      code
      discountAmount
    }
    contents {
      itemCount
      nodes {
        key
        quantity
        subtotal
        total
        product {
          node {
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
  }
}
    ''';
    try {
      debugPrint('[CartRepo] getCartItems - starting query...');
      final stopwatch = Stopwatch()..start();

      // give it a longer timeout than default (5s)
      final result = await client
          .query(
            QueryOptions(
              document: gql(query),
              fetchPolicy: FetchPolicy.networkOnly,
            ),
          )
          .timeout(const Duration(seconds: 20));

      stopwatch.stop();
      debugPrint(
        '[CartRepo] getCartItems - completed in ${stopwatch.elapsedMilliseconds} ms',
      );

      if (result.hasException) {
        debugPrint(
          '[CartRepo] getCartItems - GraphQL Exception: ${result.exception}',
        );
        throw Exception(result.exception.toString());
      }

      final wrapped = {"data": result.data};
      debugPrint(
        '[CartRepo] getCartItems - data present: ${result.data != null}',
      );
      return GetCartModel.fromJson(wrapped);
    } on TimeoutException catch (e) {
      debugPrint('[CartRepo] getCartItems - TimeoutException: $e');
      rethrow;
    } catch (e, st) {
      debugPrint('[CartRepo] getCartItems - Unexpected error: $e\n$st');
      rethrow;
    }
  }

  // Update Quantity
  Future<GetCartModel> updateCartItem(String key, int quantity) async {
    const String mutation = r'''
    mutation UpdateCartItem($key: ID!, $quantity: Int!) {
      updateItemQuantities(input: { items: [{ key: $key, quantity: $quantity }] }) {
        cart {
          contents {
            nodes {
              key
              quantity
              subtotal
              total
              product {
                node {
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
                    price
                    regularPrice
                    salePrice
                  }
                }
              }
            }
          }
          subtotal
          total
          totalTax
          shippingTotal
        }
      }
    }
    ''';

    final result = await client.mutate(
      MutationOptions(
        document: gql(mutation),
        variables: {"key": key, "quantity": quantity},
      ),
    );

    try {
      debugPrint(
        '[CartRepo] updateCartItem - key:$key quantity:$quantity - starting',
      );
      final result = await client
          .mutate(
            MutationOptions(
              document: gql(mutation),
              variables: {"key": key, "quantity": quantity},
            ),
          )
          .timeout(const Duration(seconds: 20));

      debugPrint(
        '[CartRepo] updateCartItem - completed in mutation; hasException=${result.hasException}',
      );

      if (result.hasException) {
        debugPrint(
          '[CartRepo] updateCartItem - GraphQL Exception: ${result.exception}',
        );
        throw Exception(result.exception.toString());
      }

      // mutation returns updateItemQuantities -> contains cart
      return GetCartModel.fromJson({
        "data": result.data?["updateItemQuantities"],
      });
    } on TimeoutException catch (e) {
      debugPrint('[CartRepo] updateCartItem - TimeoutException: $e');
      rethrow;
    } catch (e, st) {
      debugPrint('[CartRepo] updateCartItem - Unexpected error: $e\n$st');
      rethrow;
    }
  }

  // Remove Item
  Future<GetCartModel> removeCartItem(String key) async {
    const String mutation = r'''
    mutation RemoveCartItem($key: ID!) {
      removeItemsFromCart(input: { keys: [$key] }) {
        cart {
          contents {
            nodes {
              key
              quantity
              subtotal
              total
              product {
                node {
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
                    price
                    regularPrice
                    salePrice
                  }
                }
              }
            }
          }
          subtotal
          total
          totalTax
          shippingTotal
        }
      }
    }
    ''';

    final result = await client.mutate(
      MutationOptions(document: gql(mutation), variables: {"key": key}),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    return GetCartModel.fromJson({"data": result.data?["removeItemsFromCart"]});
  }

  Future<GetCartModel> addToCart(int productId, int quantity) async {
    const String mutation = r'''
    mutation AddToCart($productId: Int!, $quantity: Int!) {
      addToCart(input: { productId: $productId, quantity: $quantity }) {
        cart {
          contents {
            itemCount
            nodes {
              key
              quantity
              subtotal
              total
              product {
                node {
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
                    price
                    regularPrice
                    salePrice
                  }
                }
              }
            }
          }
          subtotal
          total
          shippingTotal
          totalTax
          chosenShippingMethods
          availableShippingMethods {
            rates {
              id
              label
              cost
            }
          }
        }
      }
    }
    ''';

    final result = await client.mutate(
      MutationOptions(
        document: gql(mutation),
        variables: {"productId": productId, "quantity": quantity},
      ),
    );

    if (result.hasException) {
      print(result.exception.toString());
      throw Exception(result.exception.toString());
    }
    final wrapped = {"data": result.data};
    // final data = result.data?["addToCart"];
    // print("Raw response: ${result.data}");
    // if (data == null) {
    //   throw Exception("No data returned from addToCart mutation");
    // }
    return GetCartModel.fromJson(wrapped);
  }

  Future<CouponResponse?> applyCoupon(String code) async {
    const String mutation = r'''
      mutation ApplyCoupon($code: String!) {
        applyCoupon(input: {code: $code}) {
          cart {
            subtotal
            total
            discountTotal
            appliedCoupons {
              code
              discountAmount
            }
            contents {
              itemCount
              nodes {
                key
                quantity
                product {
                  node {
                    name
                    ... on SimpleProduct {
                      price
                    }
                  }
                }
              }
            }
          }
          message

          applied {
            code
          }
        }
      }
    ''';

    final result = await client.mutate(
      MutationOptions(document: gql(mutation), variables: {"code": code}),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
    final data = result.data?['applyCoupon'];
    if (data == null) return null;

    final cartData = data['cart'];
    final message = data['message'];

    return CouponResponse(
      cart:
          cartData != null
              ? GetCartModel.fromJson({
                "data": {"cart": cartData},
              })
              : null,
      message: message,
    );
  }

  // Remove coupon
  Future<CouponResponse?> removeCoupon(String code) async {
    const String mutation = r'''
      mutation RemoveCoupon($codes: [String!]!) {
        removeCoupons(input: {codes: $codes}) {
        message

          cart {
            subtotal
            total
            discountTotal
            appliedCoupons {
              code
              discountAmount
            }
            contents {
              itemCount
              nodes {
                key
                quantity
                product {
                  node {
                    name
                    ... on SimpleProduct {
                      price
                    }
                  }
                }
              }
            }
          }
        }
      }
    ''';

    final result = await client.mutate(
      MutationOptions(
        document: gql(mutation),
        variables: {
          "codes": [code],
        },
      ),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
    final data = result.data?['removeCoupons'];
    if (data == null) return null;

    final cartData = data['cart'];
    final message = data['message'];

    return CouponResponse(
      cart:
          cartData != null
              ? GetCartModel.fromJson({
                "data": {"cart": cartData},
              })
              : null,
      message: message,
    );
  }

  // Shipping method

  Future<List<AvailableShippingMethodCart>> getAvailableShippingMethod() async {
    const String query = r'''
 query GetCartShippingMethods {
 cart {
   availableShippingMethods {
     rates {
       id
       label
       cost
     }
   }
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

      final data =
          result.data?['cart']?['availableShippingMethods'] as List<dynamic>?;

      if (data == null) return [];

      return data
          .map((json) => AvailableShippingMethodCart.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
