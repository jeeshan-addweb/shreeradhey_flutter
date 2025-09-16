import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../repo/auth_repo.dart';

class AuthController extends GetxController {
  final AuthRepo _repo = AuthRepo();
  final box = GetStorage(); // local storage

  var isLoading = false.obs;
  var userData = {}.obs;
  var token = "".obs;
  var userId = "".obs;

  Future<void> loadToken() async {
    final savedToken = box.read("auth_token");
    if (savedToken != null && savedToken.toString().isNotEmpty) {
      token.value = savedToken;
    }
  }

  bool get isLoggedIn => token.isNotEmpty;

  Future<void> logout() async {
    token.value = "";
    userData.clear();
    await box.remove("auth_token");
  }

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
      if (success && result['token'] != null) {
        // Save token in memory & storage
        token.value = result['token'];
        userId.value = result['user']['id'];
        box.write("auth_token", result['token']);
        userData.value = result['user'] ?? {};
      }

      return {
        "success": success,
        "message":
            result['message'] ?? (success ? "OTP verified" : "Invalid OTP"),
        "token": result['token'],
        "user": result['user'],
        "userId": result['user']['id'],
      };
    } catch (e) {
      return {"success": false, "message": "Error: ${e.toString()}"};
    } finally {
      isLoading.value = false;
    }
  }

  // Future<Map<String, dynamic>> verifyOtp(String phone, String otp) async {
  //   try {
  //     isLoading.value = true;
  //     final result = await _repo.verifyOtp(phone, otp);

  //     final verifyData = result['data']?['verifyOTP'] ?? {};
  //     final success = verifyData['success'] == true; // ✅ fixed

  //     if (success && verifyData['token'] != null) {
  //       // Save token in memory & storage
  //       token.value = verifyData['token'];
  //       box.write("auth_token", verifyData['token']);
  //       userData.value = verifyData['user'] ?? {};
  //     }

  //     return {
  //       "success": success,
  //       "message":
  //           verifyData['message'] ?? (success ? "OTP verified" : "Invalid OTP"),
  //       "token": verifyData['token'],
  //       "user": verifyData['user'],
  //     };
  //   } catch (e) {
  //     return {"success": false, "message": "Error: ${e.toString()}"};
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  String? getSavedToken() {
    return box.read("auth_token");
  }
}
