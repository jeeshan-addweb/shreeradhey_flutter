import 'package:graphql_flutter/graphql_flutter.dart';

import '../constants/endpoints.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  late GraphQLClient client;

  factory ApiClient() {
    return _instance;
  }

  ApiClient._internal() {
    final HttpLink httpLink = HttpLink(
      Endpoints.baseUrl, // use from endpoints.dart
    );

    client = GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: HiveStore()),
    );
  }

  GraphQLClient get graphQLClient => client;
}
