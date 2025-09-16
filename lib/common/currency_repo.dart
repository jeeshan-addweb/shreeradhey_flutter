import 'package:graphql_flutter/graphql_flutter.dart';

import '../data/network/api_client.dart';

class CurrencyRepo {
  final _client = ApiClient().graphQLClient;

  Future<Map<String, dynamic>?> getCurrencyByCountry(String countryCode) async {
    const String currencyByCountryQuery = r'''
  query GetProductsByCountry($country: String!) {
    currencyByCountry(country: $country) {
      zoneId
      currencyParams {
        code
        symbol
        num_decimals
        decimal_sep
        thousand_sep
        format
      }
    }
  }
''';

    try {
      final QueryOptions options = QueryOptions(
        document: gql(currencyByCountryQuery),
        variables: {"country": countryCode},
      );

      final result = await _client.query(options);

      if (result.hasException) {
        print("GraphQL Exception: ${result.exception.toString()}");
        return null;
      }

      return result.data?["currencyByCountry"];
    } catch (e) {
      print("Error in getCurrencyByCountry: $e");
      return null;
    }
  }
}
