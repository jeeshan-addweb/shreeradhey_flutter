import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../data/network/api_client.dart';
import '../model/about_us_page_model.dart';

class FooterRepo {
  final _client = ApiClient().graphQLClient;
  final String query = r'''
    query {
      pageBy(uri: "about-us") {
        title
        blocks {
          name
          content
        }
      }
    }
  ''';

  Future<AboutUsPageModel> fetchAboutUs() async {
    final result = await _client.query(QueryOptions(document: gql(query)));
    debugPrint("Result repo is $result");

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final data = result.data!;
    debugPrint("Data repo is $data");

    return AboutUsPageModel.fromJson({'data': data});
  }
}
