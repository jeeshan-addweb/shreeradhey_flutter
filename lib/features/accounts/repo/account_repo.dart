import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shree_radhey/features/accounts/model/get_address_model.dart';
import 'package:shree_radhey/features/accounts/model/order_history_model.dart';

import '../../../data/network/api_client.dart';
import '../model/create_order_model.dart';
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

  Future<OrderDetailModel> getOrderDetail(String orderId) async {
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
        variables: {"orderId": orderId.toString()},
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      print("ORDER DETAIL EXCEPTION: ${result.exception}");
      throw Exception(result.exception.toString());
    }
    print("ORDER DETAIL RESPONSE: ${result.data}");
    return OrderDetailModel.fromJson({"data": result.data});
  }

  Future<CreateOrderModel> createOrder(Map<String, dynamic> input) async {
    const mutation = r'''
      mutation CreateOrder($input: CreateOrderInput!) {
        createOrder(input: $input) {
          order {
            orderKey
            status
            total
            lineItems {
              nodes {
                product {
                  node {
                    name
                  }
                }
                total
              }
            }
          }
          orderId
        }
      }
    ''';

    final result = await _client.mutate(
      MutationOptions(document: gql(mutation), variables: {"input": input}),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    return CreateOrderModel.fromJson(result.data!['createOrder']);
  }

  Future<Map<String, dynamic>> saveAddress(Map<String, dynamic> address) async {
    const String mutation = r'''
      mutation SaveAddress($address: AddressInput!) {
        saveAddress(input: { address: $address }) {
          success
          message
          address {
          id
            address_type
            address_label
            first_name
            last_name
            company
            country
            address_1
            address_2
            city
            state
            postcode
            phone
            email
            is_default
          }
        }
      }
    ''';

    final result = await _client.mutate(
      MutationOptions(document: gql(mutation), variables: {"address": address}),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    return result.data?['saveAddress'] ?? {};
  }

  Future<GetAddressModel?> fetchCustomerAddresses() async {
    const String query = r'''
      query {
        customerAddresses {
          id
          address_type
          address_label
          first_name
          last_name
          company
          country
          address_1
          address_2
          city
          state
          postcode
          phone
          email
          is_default
        }
      }
    ''';

    final QueryOptions options = QueryOptions(
      document: gql(query),
      fetchPolicy: FetchPolicy.networkOnly,
    );

    final result = await _client.query(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    return GetAddressModel.fromJson({"data": result.data});
  }

  Future<Map<String, dynamic>> deleteAddress(int id, int userId) async {
    const String mutation = r'''
      mutation DeleteAddress($id: Int!, $user_id: Int!) {
        deleteAddress(input: { id: $id, user_id: $user_id }) {
          success
          message
        }
      }
    ''';

    final result = await _client.mutate(
      MutationOptions(
        document: gql(mutation),
        variables: {"id": id, "user_id": userId},
      ),
    );

    if (result.hasException) throw Exception(result.exception.toString());
    return result.data?['deleteAddress'] ?? {};
  }

  Future<Map<String, dynamic>?> updateCustomer({
    required String firstName,
    required String lastName,
    required String displayName,
    required String email,
  }) async {
    const String mutation = r'''
    mutation UpdateFullCustomer($input: UpdateFullCustomerInput!) {
      updateFullCustomer(input: $input) {
        user {
          id
          databaseId
          firstName
          lastName
          displayName
          email
        }
        message
      }
    }
    ''';

    try {
      final MutationOptions options = MutationOptions(
        document: gql(mutation),
        variables: {
          "input": {
            "firstName": firstName,
            "lastName": lastName,
            "displayName": displayName,
            "email": email,
          },
        },
      );

      final result = await _client.mutate(options);

      if (result.hasException) {
        throw Exception(result.exception.toString());
      }

      return result.data?['updateFullCustomer'];
    } catch (e) {
      print("Error in updateCustomer: $e");
      return null;
    }
  }
}
