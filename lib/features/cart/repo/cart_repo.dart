import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../data/network/api_client.dart';
import '../model/add_to_cart_model.dart';

class CartRepo {
  final GraphQLClient client = ApiClient().graphQLClient;

  Future<AddToCartModel> addToCart(int productId, int quantity) async {
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
    return AddToCartModel.fromJson(wrapped);
  }
}
