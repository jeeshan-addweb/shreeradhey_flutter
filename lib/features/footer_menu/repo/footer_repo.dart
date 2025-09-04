import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shree_radhey/features/footer_menu/model/faq_model.dart';
import 'package:shree_radhey/features/footer_menu/model/privacy_policy_model.dart';
import 'package:shree_radhey/features/footer_menu/model/refund_policy_model.dart';
import 'package:shree_radhey/features/footer_menu/model/shipping_model.dart';
import 'package:shree_radhey/features/footer_menu/model/terms_condition_model.dart';

import '../../../data/network/api_client.dart';
import '../model/about_us_page_model.dart';

class FooterRepo {
  final _client = ApiClient().graphQLClient;

  Future<AboutUsPageModel> fetchAboutUs() async {
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
    final result = await _client.query(QueryOptions(document: gql(query)));
    debugPrint("Result repo is $result");

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final data = result.data!;
    debugPrint("Data repo is $data");

    return AboutUsPageModel.fromJson({'data': data});
  }

  Future<RefundPolicyModel> fetchRefundPolicy() async {
    final String query = r'''
    query {
      pageBy(uri: "refund-policy") {
   title
   blocks {
     name
     content
   }
 }
    }
  ''';
    final result = await _client.query(QueryOptions(document: gql(query)));
    debugPrint("Result repo is $result");

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final data = result.data!;
    debugPrint("refund repo is $data");

    return RefundPolicyModel.fromJson({'data': data});
  }

  Future<PrivacyPolicyModel> fetchPrivacyPolicy() async {
    final String query = r'''
    query {
      pageBy(uri: "privacy-policy") {
   title
   blocks {
     name
     content
   }
 }
    }
  ''';
    final result = await _client.query(QueryOptions(document: gql(query)));
    debugPrint("Result repo is $result");

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final data = result.data!;
    debugPrint("privacy repo is $data");

    return PrivacyPolicyModel.fromJson({'data': data});
  }

  Future<FaqModel> fetchFAQ() async {
    final String query = r'''
    query {
      pageBy(uri: "faq") {
   title
   blocks {
     name
     content
   }
 }
    }
  ''';
    final result = await _client.query(QueryOptions(document: gql(query)));
    debugPrint("Result repo is $result");

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final data = result.data!;
    debugPrint("faq repo is $data");

    return FaqModel.fromJson({'data': data});
  }

  Future<TermsConditionModel> fetchTermsCondition() async {
    final String query = r'''
    query {
      pageBy(uri: "terms-conditions") {
   title
   blocks {
     name
     content
   }
 }
    }
  ''';
    final result = await _client.query(QueryOptions(document: gql(query)));
    debugPrint("Result repo is $result");

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final data = result.data!;
    debugPrint("faq repo is $data");

    return TermsConditionModel.fromJson({'data': data});
  }

  Future<ShippingModel> fetchShipping() async {
    final String query = r'''
    query {
      pageBy(uri: "shipping-and-delivery-policy") {
   title
   blocks {
     name
     content
   }
 }
    }
  ''';
    final result = await _client.query(QueryOptions(document: gql(query)));
    debugPrint("Result repo is $result");

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final data = result.data!;
    debugPrint("faq repo is $data");

    return ShippingModel.fromJson({'data': data});
  }
}
