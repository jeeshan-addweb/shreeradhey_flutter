import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import '../../../common/components/custom_snackbar.dart';
import '../../../constants/app_images.dart';
import '../../../utils/routes/app_route_path.dart';
import '../controller/auth_controller.dart';

class OtpScreen extends StatefulWidget {
  final String contact;
  const OtpScreen({super.key, required this.contact});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final pinController = TextEditingController();
  int _secondsRemaining = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _secondsRemaining = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  @override
  void dispose() {
    pinController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(AppImages.login_bg, fit: BoxFit.cover),
          ),

          // Centered Card
          Center(
            child: Container(
              height: MediaQuery.sizeOf(context).height * 0.40,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    const Text(
                      "Log In",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // OTP sent text
                    Text(
                      "OTP sent to ${widget.contact}",
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 20),

                    // OTP Input
                    Center(
                      child: Pinput(
                        controller: pinController,
                        length: 6,
                        showCursor: true,
                        onCompleted: (pin) async {
                          final controller = Get.find<AuthController>();
                          final response = await controller.verifyOtp(
                            widget.contact,
                            pinController.text.trim(),
                          );

                          final success = response["success"] as bool? ?? false;
                          final message =
                              response["message"] as String? ?? "Invalid OTP";

                          if (success) {
                            CustomSnackbars.showSuccess(context, message);
                            context.go(
                              AppRoutePath.homeScreen,
                            ); // ✅ only on success
                          } else {
                            CustomSnackbars.showError(
                              context,
                              message,
                            ); // ❌ stay on same screen
                          }
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Resend OTP
                    _secondsRemaining > 0
                        ? Text(
                          "Resend OTP in $_secondsRemaining sec",
                          style: const TextStyle(color: Colors.grey),
                        )
                        : TextButton(
                          onPressed: () {
                            _startTimer();
                          },
                          child: const Text(
                            "Resend OTP",
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                        ),
                    const SizedBox(height: 20),

                    // T&C text
                    const Text.rich(
                      TextSpan(
                        text: "By proceeding, you are agreeing to our ",
                        style: TextStyle(fontSize: 14),
                        children: [
                          TextSpan(
                            text: "T&C",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(text: " and "),
                          TextSpan(
                            text: "Privacy policy",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Obx(() {
            return controller.isLoading.value
                ? Container(
                  color: Colors.black45,
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                )
                : const SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}
