import 'package:flutter/material.dart';

import '../../../common/components/common_footer.dart';
import '../../../common/components/common_textfield.dart';
import '../../../common/components/gradient_button.dart';
import '../../../constants/app_colors.dart';
import 'component/contact_map_section.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header Title
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 40,
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          height: 2,
                          color: AppColors.black,
                        ),
                        const Text(
                          "CONTACT US",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                        Container(
                          width: 40,
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          height: 2,
                          color: AppColors.black,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36.0),
                    child: Text(
                      "Get In Touch With Us !",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.red.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// Form Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonLabeledTextField(
                      label: "First Name",
                      hint: "Enter your first name",
                      controller: firstNameController,
                      isRequired: true,
                    ),
                    const SizedBox(height: 16),
                    CommonLabeledTextField(
                      label: "Last Name",
                      hint: "Enter your last name",
                      controller: lastNameController,
                      isRequired: true,
                    ),
                    const SizedBox(height: 16),
                    CommonEmailTextField(
                      label: "Email*",
                      controller: emailController,
                      hintText: "Enter your email",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email is required";
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return "Enter valid email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CommonPhoneTextField(
                      label: "Phone Number*",
                      controller: phoneController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Phone number required";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CommonLabeledTextField(
                      label: "Message",
                      hint: "Write your message here",
                      controller: messageController,
                      fontSize: 14,
                    ),
                    const SizedBox(height: 24),

                    /// Submit Button
                    GradientButton(
                      text: "Submit",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          /// submit logic here
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Form Submitted")),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 32),
                    ContactMapSection(
                      address:
                          "Khasra no 678, Village Khori, Pushkar, Ajmer – 305021, Rajasthan, India.",
                      email: "srdftpushkar@gmail.com",
                      phone: "+91-98289 64111",
                      latitude: 26.4879,
                      longitude: 74.5505,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            /// Footer
            CommonFooter(),
          ],
        ),
      ),
    );
  }
}
