import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../data/network/api_client.dart';
import '../model/add_to_cart_model.dart';
import '../model/get_cart_model.dart';

class CartRepo {
  final GraphQLClient client = ApiClient().graphQLClient;

  Future<GetCartModel> getCartItems() async {
    const String query = r'''
      query GetCartItems {
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
    ''';

    final result = await client.query(
      QueryOptions(document: gql(query), fetchPolicy: FetchPolicy.networkOnly),
    );

    if (result.hasException) {
      print("Error fetching cart: ${result.exception.toString()}");
      throw Exception(result.exception.toString());
    }

    final wrapped = {"data": result.data};
    return GetCartModel.fromJson(wrapped);
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

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    return GetCartModel.fromJson({
      "data": result.data?["updateItemQuantities"],
    });
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
}
