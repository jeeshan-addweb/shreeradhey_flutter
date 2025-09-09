import 'package:graphql_flutter/graphql_flutter.dart';

import '../../data/network/api_client.dart';
import '../model/amazon_review_model.dart';

class CommonFooterRepo {
  final _client = ApiClient().graphQLClient;

  Future<List<AmazonReview>> getAmazonReviews() async {
    const query = r'''
   query GetAmazonReviews {
 amazonReviews {
   id
   user
   user_photo
   text
   rating
   original_rating
   date
 }
}

  ''';

    final result = await _client.query(QueryOptions(document: gql(query)));
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final nodes = result.data?['amazonReviews'] ?? [];

    return (nodes as List)
        .map((e) => AmazonReview.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
