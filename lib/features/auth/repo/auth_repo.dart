import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../../data/network/api_client.dart';

class AuthRepo {
  final GraphQLClient client = ApiClient().graphQLClient;

  Future<Map<String, dynamic>> requestOtp(String username) async {
    const String mutation = r'''
    mutation RequestOTP($username: String!) {
    requestOTP(input: { username: $username }) {
      success
      message
    }
  }
    ''';

    final result = await client.mutate(
      MutationOptions(
        document: gql(mutation),
        variables: {"username": username},
      ),
    );

    if (result.hasException) {
      print(result.exception.toString());
      return {"success": false, "message": result.exception.toString()};
    }

    final data = result.data?["requestOTP"];
    return {
      "success": data?["success"] ?? false,
      "message": data?["message"] ?? "Something went wrong",
    };
  }

  Future<Map<String, dynamic>> verifyOtp(String username, String otp) async {
    const String mutation = r'''
    mutation VerifyOtp($username: String!, $otp: String!) {
      verifyOTP(input: { username: $username, otp: $otp }) {
        success
        message
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
        variables: {"username": username, "otp": otp},
      ),
    );

    if (result.hasException) {
      // show only the GraphQL error message in snackbar
      final errorMessage =
          result.exception?.graphqlErrors.isNotEmpty == true
              ? result.exception!.graphqlErrors.first.message
              : result.exception.toString();

      Get.snackbar("OTP Error", errorMessage);
      return {
        "success": false,
        "message": errorMessage,
        "token": null,
        "user": null,
      };
    }

    final data = result.data?['verifyOTP'];
    return {
      "success": data?['success'] ?? false,
      "message": data?['message'] ?? "Something went wrong",
      "token": data?['token'],
      "user": data?['user'],
    };
  }
}
