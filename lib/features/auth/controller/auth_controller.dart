import 'package:get/get.dart';
import '../repo/auth_repo.dart';

class AuthController extends GetxController {
  final AuthRepo _repo = AuthRepo();

  var isLoading = false.obs;
  var userData = {}.obs;

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      final data = await _repo.login(email, password);
      userData.value = data ?? {};
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> requestOtp(String contact) async {
    try {
      isLoading.value = true;
      final success = await _repo.requestOtp(contact);
      if (!success) {
        Get.snackbar("Error", "Failed to send OTP");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOtp(String contact, String otp) async {
    try {
      isLoading.value = true;
      final data = await _repo.verifyOtp(contact, otp);
      if (data != null) {
        // token.value = data['token'];
        // user.value = data['user'];
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
