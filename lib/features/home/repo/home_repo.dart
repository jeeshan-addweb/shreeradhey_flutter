import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../data/network/api_client.dart';
import '../model/get_blog_model.dart';

class HomeRepo {
  final _client = ApiClient().graphQLClient;

  final String query = r'''
   query GetLatestPosts($first: Int, $after: String) {
 posts(first: $first, after: $after, where: { orderby: { field: DATE, order: DESC } }) {
   pageInfo {
     hasNextPage
     endCursor
   }
   nodes {
     id
     title
     uri
     date
     excerpt
     featuredImage {
       node {
         sourceUrl
         altText
       }
     }
   }
 }
}
  ''';

  Future<GetBlogModel> fetchBlogs({int first = 10, String? after}) async {
    final result = await _client.query(
      QueryOptions(
        document: gql(query),
        variables: {'first': first, if (after != null) 'after': after},
      ),
    );

    debugPrint("Blog Result: $result");

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final data = result.data!;
    debugPrint("Blog Data: $data");

    // Pass the complete response that matches your model structure
    return GetBlogModel.fromJson({'data': data});
  }

  Future<GetBlogModel> loadMoreBlogs({
    required String cursor,
    int first = 10,
  }) async {
    return fetchBlogs(first: first, after: cursor);
  }
}
