import 'dart:convert';

import 'package:flutter/material.dart';

// import '../../features/member/auth/login/controller/login_controller.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../../features/auth/controller/login_controller.dart';

class ApiClient {
  static const baseUrl = 'https://poc-clubmanagement.addwebprojects.com/api';

  static Future<http.Response> get(
    String endpoint, {
    bool tokenRequired = true,
  }) {
    final url = Uri.parse('$baseUrl/$endpoint');

    final LoginController loginController = Get.put(LoginController());
    if (tokenRequired) {
      return http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer ${loginController.authToken.value}',
        },
      );
    } else {
      return http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          // Add Authorization header if needed
        },
      );
    }
  }

  static Future<http.Response> post(
    String endpoint,
    Map<String, dynamic> body, {
    bool tokenRequired = true,
  }) {
    debugPrint('$baseUrl/$endpoint');
    final url = Uri.parse('$baseUrl/$endpoint');
    final LoginController loginController = Get.put(LoginController());

    if (tokenRequired) {
      return http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer 113|Xw6GPhI4NzMvv5twGHSBDcsnAztoZDiIbPDWtP1l6bda2e5e',
          // 'Authorization': 'Bearer ${loginController.authToken.value}',
        },
        body: jsonEncode(body),
      );
    } else {
      return http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          // Add Authorization header if needed
        },
        body: jsonEncode(body),
      );
    }
  }

  static Future<http.Response> delete(
    String endpoint, {
    bool tokenRequired = true,
  }) {
    final url = Uri.parse('$baseUrl/$endpoint');
    final LoginController loginController = Get.put(LoginController());

    if (tokenRequired) {
      return http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer ${loginController.authToken.value}',
        },
      );
    } else {
      return http.delete(url, headers: {'Content-Type': 'application/json'});
    }
  }

  // Similarly, you can add get(), put(), delete() methods here
}
