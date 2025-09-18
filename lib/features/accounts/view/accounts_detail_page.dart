import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/components/common_footer.dart';
import '../../../common/components/common_textfield.dart';
import '../../../common/components/gradient_button.dart';
import '../../../constants/app_colors.dart';
import '../controller/account_controller.dart';

class AccountDetailsPage extends StatefulWidget {
  const AccountDetailsPage({super.key});

  @override
  State<AccountDetailsPage> createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final displayNameController = TextEditingController();
  final emailController = TextEditingController();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final accountController = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Obx(() {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// First & Last Name (Side by Side)
                    Row(
                      children: [
                        Expanded(
                          child: CommonLabeledTextField(
                            label: "First name",
                            hint: "Enter first name",
                            controller: firstNameController,
                            isRequired: true,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CommonLabeledTextField(
                            label: "Last name",
                            hint: "Enter last name",
                            controller: lastNameController,
                            isRequired: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    /// Display Name
                    CommonLabeledTextField(
                      label: "Display name",
                      hint: "Enter display name",
                      controller: displayNameController,
                      isRequired: true,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "This will be how your name will be displayed in the account section and in reviews.",
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 16),

                    /// Email Address
                    CommonEmailTextField(
                      controller: emailController,
                      label: "Email address",
                      hintText: "Enter email",
                    ),
                    const SizedBox(height: 24),

                    /// Password Section
                    // Text(
                    //   "Password change",
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.w700,
                    //     fontSize: 16,
                    //     color: AppColors.grey_212121,
                    //   ),
                    // ),
                    // const SizedBox(height: 12),

                    // CommonPasswordTextField(
                    //   controller: currentPasswordController,
                    //   label: "Current password (leave blank to leave unchanged)",
                    // ),
                    // const SizedBox(height: 16),

                    // CommonPasswordTextField(
                    //   controller: newPasswordController,
                    //   label: "New password (leave blank to leave unchanged)",
                    // ),
                    // const SizedBox(height: 16),

                    // CommonPasswordTextField(
                    //   controller: confirmPasswordController,
                    //   label: "Confirm new password",
                    // ),
                    // const SizedBox(height: 24),

                    // /// Save Changes Button
                    accountController.isLoading.value
                        ? const CircularProgressIndicator()
                        : GradientButton(
                          text: "Save Changes",
                          onPressed: () {
                            accountController
                                .updateCustomer(
                                  firstName: firstNameController.text.trim(),
                                  lastName: lastNameController.text.trim(),
                                  displayName:
                                      displayNameController.text.trim(),
                                  email: emailController.text.trim(),
                                )
                                .then((_) {
                                  firstNameController.clear();
                                  lastNameController.clear();
                                  displayNameController.clear();
                                  emailController.clear();
                                });
                          },
                        ),

                    Obx(
                      () => Center(
                        child: Text(
                          accountController.updateMessage.value,
                          style: const TextStyle(color: Colors.green),
                        ),
                      ),
                    ),
                    // Container(
                    //   width: double.infinity,
                    //   decoration: BoxDecoration(
                    //     gradient: LinearGradient(
                    //       colors: [
                    //         AppColors.green_6cad10,
                    //         AppColors.green_327801,
                    //       ],
                    //       begin: Alignment.topCenter,
                    //       end: Alignment.bottomCenter,
                    //     ),
                    //     borderRadius: BorderRadius.circular(8),
                    //   ),
                    //   child: ElevatedButton(
                    //     onPressed: () {
                    //       // TODO: Add save functionality
                    //     },
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: Colors.transparent,
                    //       shadowColor: Colors.transparent,
                    //       padding: const EdgeInsets.symmetric(vertical: 14),
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(8),
                    //       ),
                    //     ),
                    //     child: const Text(
                    //       "Save changes",
                    //       style: TextStyle(color: Colors.white, fontSize: 16),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),

              /// Footer
              const CommonFooter(),
            ],
          ),
        );
      }),
    );
  }
}
