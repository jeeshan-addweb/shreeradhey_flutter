import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shree_radhey/features/accounts/model/order_history_model.dart';

import '../../../data/network/api_client.dart';
import '../model/order_detail_model.dart';

class AccountRepo {
  final _client = ApiClient().graphQLClient;

  Future<Orders> getCustomerOrders({int first = 10, String? after}) async {
    const query = r'''
      query GetCustomerOrders($first: Int = 10, $after: String) {
        customer {
          orders(first: $first, after: $after) {
            pageInfo {
              hasNextPage
              endCursor
            }
            nodes {
              id
              databaseId
              orderNumber
              date
              status
              total
              shippingTotal
              paymentMethodTitle
              transactionId
              customerNote
              lineItems {
                nodes {
                  databaseId
                  quantity
                  total
                  subtotal
                  product {
                    node {
                      name
                      slug
                      sku
                      ... on SimpleProduct {
                        price
                        regularPrice
                        salePrice
                      }
                    }
                  }
                }
              }
              billing {
                firstName
                lastName
                address1
                address2
                city
                state
                postcode
                country
                email
                phone
              }
              shipping {
                firstName
                lastName
                address1
                address2
                city
                state
                postcode
                country
              }
            }
          }
        }
      }
    ''';

    final result = await _client.query(
      QueryOptions(
        document: gql(query),
        variables: {'first': first, 'after': after},
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      throw result.exception!;
    }
    final data = result.data!;
    debugPrint("Orders Data: $data");

    return Orders.fromJson(data['customer']['orders']);
  }

  Future<OrderDetailModel> getOrderDetail(int orderId) async {
    const query = r'''
query GetOrderDetails($orderId: ID!) {
  order(id: $orderId, idType: DATABASE_ID) {
    orderNumber
    databaseId
    date
    status
    total
    shippingTotal
    paymentMethodTitle
    transactionId
    customerNote
    lineItems {
      nodes {
        databaseId
        quantity
        total
        subtotal
        product {
          node {
            name
            slug
            sku
            ... on SimpleProduct {
              price
              regularPrice
              salePrice
            }
          }
        }
      }
    }
    billing {
      firstName
      lastName
      address1
      address2
      city
      state
      postcode
      country
      email
      phone
    }
    shipping {
      firstName
      lastName
      address1
      address2
      city
      state
      postcode
      country
    }
  }
}
''';

    final result = await _client.query(
      QueryOptions(
        document: gql(query),
        variables: {"orderId": orderId},
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    return OrderDetailModel.fromJson({"data": result.data});
  }
}
