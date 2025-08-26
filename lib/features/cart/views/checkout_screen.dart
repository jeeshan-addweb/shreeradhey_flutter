import 'package:flutter/material.dart';

import '../../../common/components/common_footer.dart';
import '../../../common/components/common_textfield.dart';
import '../../../constants/app_colors.dart';
import 'components/payment_method_card.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final streetController = TextEditingController();
  final apartmentController = TextEditingController();
  final cityController = TextEditingController();
  final pinController = TextEditingController();
  final notesController = TextEditingController();
  String? selectedState;
  String? selectedCountry = "India";
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: "Home",
                        style: TextStyle(color: AppColors.black),
                      ),
                      TextSpan(
                        text: " / ",
                        style: TextStyle(color: AppColors.red_CC0003),
                      ),
                      TextSpan(
                        text: "Checkout",
                        style: TextStyle(color: AppColors.red_CC0003),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),
                const Text(
                  "Shipping details",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                // First name & Last name
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

                // Email & Phone
                Row(
                  children: [
                    Expanded(
                      child: CommonLabeledTextField(
                        label: "Email address",
                        hint: "Enter email address",
                        controller: emailController,
                        isRequired: true,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CommonLabeledTextField(
                        label: "Phone",
                        hint: "Enter phone number",
                        controller: phoneController,
                        isRequired: true,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Street address
                CommonLabeledTextField(
                  label: "Street address",
                  hint: "House number and street name",
                  controller: streetController,
                  isRequired: true,
                ),

                CommonLabeledTextField(
                  label: "",
                  hint: "Apartment, suite, unit, etc. (optional)",
                  controller: apartmentController,
                ),
                const SizedBox(height: 16),

                // City & State
                Row(
                  children: [
                    Expanded(
                      child: CommonLabeledTextField(
                        label: "Town / City",
                        hint: "Enter town/city",
                        controller: cityController,
                        isRequired: true,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CommonLabeledDropdown(
                        label: "State",
                        hint: "Select an option",
                        items: ["Gujarat", "Maharashtra", "Delhi", "Rajasthan"],
                        value: selectedState,
                        onChanged: (val) {
                          selectedState = val;
                        },
                        isRequired: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // PIN Code & Country
                Row(
                  children: [
                    Expanded(
                      child: CommonLabeledTextField(
                        label: "PIN Code",
                        hint: "Enter postcode/zip",
                        controller: pinController,
                        isRequired: true,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CommonLabeledDropdown(
                        label: "Country / Region",
                        hint: "Select country",
                        items: ["India", "USA", "UK"],
                        value: selectedCountry,
                        onChanged: (val) {
                          selectedCountry = val;
                        },
                        isRequired: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Order notes
                CommonLabeledTextField(
                  label: "Order notes (optional)",
                  hint:
                      "Notes about your order, e.g. special notes for delivery.",
                  controller: notesController,
                ),
                const SizedBox(height: 16),

                Card(
                  color: AppColors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _PriceRow(title: "Subtotal", amount: "₹4,300.00"),

                        const SizedBox(height: 12),
                        Divider(height: 24, thickness: 3),
                        Text(
                          "Product Overview",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Divider(height: 24, thickness: 2),

                        // Product Row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "SHREERADHEY A2 Gir Cow Ghee 1000ml X 2 (905gm X 2)",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.grey_212121,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),

                            Text(
                              "₹4,300.00",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.grey_212121,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Divider(height: 24, thickness: 2),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "Shipping",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),

                            Text(
                              "Free Shipping",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Divider(height: 24, thickness: 2),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "Total",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),

                            Text(
                              "₹4,300.00",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        PaymentMethodCard(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          CommonFooter(isShow: false),
        ],
      ),
    );
  }
}

// Price Row Widget
class _PriceRow extends StatelessWidget {
  final String title;
  final String amount;

  const _PriceRow({required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.grey_212121,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.grey_212121,
          ),
        ),
      ],
    );
  }
}
