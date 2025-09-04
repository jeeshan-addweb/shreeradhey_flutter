import 'package:get/get.dart';

import '../repo/auth_repo.dart';

class AuthController extends GetxController {
  final AuthRepo _repo = AuthRepo();

  var isLoading = false.obs;
  var userData = {}.obs;
  // var token = "".obs;
  Future<Map<String, dynamic>> requestOtp(String phone) async {
    try {
      isLoading.value = true;
      final result = await _repo.requestOtp(phone);

      if (result['success'] == true) {
        return {
          "success": true,
          "message": result['message'] ?? "OTP sent successfully",
        };
      } else {
        return {
          "success": false,
          "message": result['message'] ?? "Something went wrong",
        };
      }
    } catch (e) {
      return {"success": false, "message": "Error: ${e.toString()}"};
    } finally {
      isLoading.value = false;
    }
  }

  Future<Map<String, dynamic>> verifyOtp(String phone, String otp) async {
    try {
      isLoading.value = true;
      final result = await _repo.verifyOtp(phone, otp);

      final success = result['success'] == true;

      return {
        "success": success,
        "message":
            result['message'] ?? (success ? "OTP verified" : "Invalid OTP"),
        "token": result['token'],
        "user": result['user'],
      };
    } catch (e) {
      return {"success": false, "message": "Error: ${e.toString()}"};
    } finally {
      isLoading.value = false;
    }
  }
}
