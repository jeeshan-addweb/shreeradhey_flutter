import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../common/components/custom_snackbar.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../utils/routes/app_route_path.dart';
import '../controller/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(AppImages.login_bg, fit: BoxFit.cover),
          ),

          // Centered Card
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 500,
                minHeight: MediaQuery.of(context).size.height * 0.52,
                maxHeight: MediaQuery.of(context).size.height * 0.55,
              ),
              child: Container(
                height: MediaQuery.sizeOf(context).height * 0.50,
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

                      // Mobile Number label
                      const Text(
                        "Mobile Number",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Mobile Number Field with country picker
                      // Mobile Number Field with country picker
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 4),
                              child: CountryCodePicker(
                                onChanged: (code) {},
                                initialSelection: 'IN',
                                favorite: ['+91', 'IN'],
                                showCountryOnly: false,
                                showOnlyCountryWhenClosed: false,
                                alignLeft: false,
                                padding: EdgeInsets.zero,
                              ),
                            ),
                            Container(
                              height: 46,
                              width: 1,
                              color: Colors.grey.shade400,
                            ),
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.phone,
                                controller: phoneController,
                                decoration: const InputDecoration(
                                  hintText: "Enter your mobile number",
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Divider
                      Row(
                        children: const [
                          Expanded(child: Divider()),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            child: Text("or", style: TextStyle(fontSize: 16)),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Email label
                      const Text(
                        "Email Address",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Email Field
                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Enter your email address",
                          hintStyle: TextStyle(color: AppColors.grey_94a3b8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.green_6cad10,
                                AppColors.green_327801,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Obx(() {
                            final controller = Get.find<AuthController>();
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                              ),
                              onPressed:
                                  controller.isLoading.value
                                      ? null // disable button while loading
                                      : () async {
                                        String contact = "";

                                        if (phoneController.text.isNotEmpty) {
                                          contact = phoneController.text;
                                        } else if (emailController
                                            .text
                                            .isNotEmpty) {
                                          contact = emailController.text;
                                        }

                                        if (contact.isNotEmpty) {
                                          final response = await controller
                                              .requestOtp(contact);

                                          final success =
                                              response["success"] as bool? ??
                                              false;
                                          final message =
                                              response["message"] as String? ??
                                              "Failed to send OTP";

                                          if (success) {
                                            CustomSnackbars.showSuccess(
                                              context,
                                              response['message'],
                                            );
                                            context.push(
                                              AppRoutePath.otpScreen,
                                              extra: contact,
                                            );
                                          } else {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(content: Text(message)),
                                            );
                                          }
                                        } else {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                "Please enter phone or email",
                                              ),
                                            ),
                                          );
                                        }
                                      },
                              child:
                                  controller.isLoading.value
                                      ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                      : const Text(
                                        "SUBMIT",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                            );
                          }),
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
          ),
        ],
      ),
    );
  }
}
