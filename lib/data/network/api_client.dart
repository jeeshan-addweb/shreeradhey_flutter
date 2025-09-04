import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../features/auth/controller/auth_controller.dart';
import '../constants/endpoints.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  late GraphQLClient client;

  factory ApiClient() {
    return _instance;
  }

  ApiClient._internal() {
    final AuthLink authLink = AuthLink(
      getToken: () async {
        final authController = Get.find<AuthController>();
        final token = authController.getSavedToken();
        return token != null ? 'Bearer $token' : null;
      },
    );
    final HttpLink httpLink = HttpLink(Endpoints.baseUrl);
    final Link link = authLink.concat(httpLink);

    client = GraphQLClient(
      link: link,
      cache: GraphQLCache(store: InMemoryStore()),
    );
  }

  GraphQLClient get graphQLClient => client;
}
