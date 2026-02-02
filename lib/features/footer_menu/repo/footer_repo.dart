import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shree_radhey/features/footer_menu/model/faq_model.dart';
import 'package:shree_radhey/features/footer_menu/model/privacy_policy_model.dart';
import 'package:shree_radhey/features/footer_menu/model/refund_policy_model.dart';
import 'package:shree_radhey/features/footer_menu/model/shipping_model.dart';
import 'package:shree_radhey/features/footer_menu/model/terms_condition_model.dart';
import 'package:shree_radhey/features/footer_menu/model/wood_press_oil_model.dart';

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

  Future<WoodPressOilModel> fetchWoodPressOil(String slug) async {
    const String query = r'''
   query GetPageSections($slug: ID!) {
  page(id: $slug, idType: URI) {
    title
    sections {
      type
      title
      description
      image
      faqItems {
        question
        answer
      }
      aspects {
        icon
        text
        content
      }
      awards {
        imageUrl
        title
      }
      points
      slides {
        icon
        title
        description
      }

      products {
        ... on SimpleProduct {
          id
        currencySymbol
        price
        regularPricePage
        salePricePage
        bestPrice
        discountPercentage
        isInWishlist
        isInCart
        averageRating
        reviewCount
        image {
         sourceUrl
         altText
       }

        }
      }
    }
  }
}
  ''';

    final result = await _client.query(
      QueryOptions(
        document: gql(query),
        variables: {"slug": slug},
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    debugPrint("Result repo is $result");

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final data = result.data;
    debugPrint("Data repo is $data");

    return WoodPressOilModel.fromJson({"data": result.data});
  }

  Future<Map<String, dynamic>> submitContactForm(
    Map<String, dynamic> input,
  ) async {
    const String mutation = r'''
      mutation SubmitContactForm($input: SubmitContactFormInput!) {
        submitContactForm(input: $input) {
          success
          message
        }
      }
    ''';

    final result = await _client.mutate(
      MutationOptions(document: gql(mutation), variables: {"input": input}),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    return result.data?['submitContactForm'];
  }

  Future<Map<String, dynamic>> submitDealerForm(
    Map<String, dynamic> input,
  ) async {
    const String mutation = r'''
      mutation SubmitDealerForm($input: SubmitDealerFormInput!) {
        submitDealerForm(input: $input) {
          success
          message
        }
      }
    ''';

    final result = await _client.mutate(
      MutationOptions(document: gql(mutation), variables: {"input": input}),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    return result.data?['submitDealerForm'];
  }

  Future<Map<String, dynamic>> subscribeUser(String email) async {
    const String mutation = r'''
      mutation SubmitBrevoForm($email: String!) {
        submitBrevoForm(input: { email: $email }) {
          success
          message
          redirect
        }
      }
    ''';

    final result = await _client.mutate(
      MutationOptions(document: gql(mutation), variables: {"email": email}),
    );

    if (result.hasException) {
      throw result.exception!;
    }

    return result.data?["submitBrevoForm"] ?? {};
  }
}
