import 'package:graphql_flutter/graphql_flutter.dart';
import '../../../data/network/api_client.dart';

class AuthRepo {
  final GraphQLClient client = ApiClient().graphQLClient;

  Future<Map<String, dynamic>?> login(String email, String password) async {
    const String query = r'''
      mutation Login($email: String!, $password: String!) {
        login(email: $email, password: $password) {
          token
          user {
            id
            name
          }
        }
      }
    ''';

    final result = await client.mutate(
      MutationOptions(
        document: gql(query),
        variables: {"email": email, "password": password},
      ),
    );

    if (result.hasException) {
      throw result.exception!;
    }

    return result.data?['login'];
  }

  Future<bool> requestOtp(String contact) async {
    const String mutation = r'''
      mutation RequestOtp($contact: String!) {
        requestOtp(contact: $contact) {
          success
          message
        }
      }
    ''';

    final result = await client.mutate(
      MutationOptions(document: gql(mutation), variables: {"contact": contact}),
    );

    if (result.hasException) throw result.exception!;
    return result.data?['requestOtp']['success'] ?? false;
  }

  Future<Map<String, dynamic>?> verifyOtp(String contact, String otp) async {
    const String mutation = r'''
      mutation VerifyOtp($contact: String!, $otp: String!) {
        verifyOtp(contact: $contact, otp: $otp) {
          token
          user {
            id
            name
            email
          }
        }
      }
    ''';

    final result = await client.mutate(
      MutationOptions(
        document: gql(mutation),
        variables: {"contact": contact, "otp": otp},
      ),
    );

    if (result.hasException) throw result.exception!;
    return result.data?['verifyOtp'];
  }
}
