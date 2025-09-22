import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/components/common_footer.dart';
import '../../../common/components/common_textfield.dart';
import '../../../common/components/razorpay_payment_screen.dart';
import '../../../constants/app_colors.dart';
import '../../accounts/controller/account_controller.dart';
import '../controller/cart_controller.dart';
import 'components/payment_method_card.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final CartController cartController = Get.find<CartController>();
  bool billToDifferent = false;

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
  String? selectedCountry = "IN";

  final billingFirstNameController = TextEditingController();
  final billingLastNameController = TextEditingController();
  final billingEmailController = TextEditingController();
  final billingPhoneController = TextEditingController();
  final billingStreetController = TextEditingController();
  final billingApartmentController = TextEditingController();
  final billingCityController = TextEditingController();
  final billingPinController = TextEditingController();
  String? billingSelectedState;
  String? billingSelectedCountry = "IN";

  Widget _buildAddressForm({
    required TextEditingController firstNameController,
    required TextEditingController lastNameController,
    required TextEditingController emailController,
    required TextEditingController phoneController,
    required TextEditingController streetController,
    required TextEditingController apartmentController,
    required TextEditingController cityController,
    required TextEditingController pinController,
    required String? selectedState,
    required String? selectedCountry,
    required ValueChanged<String?> onStateChanged,
    required ValueChanged<String?> onCountryChanged,
    bool showNotes = true,
    TextEditingController? notesController,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // First + Last name
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

        // Email + Phone
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

        // City + State
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
                onChanged: onStateChanged,
                isRequired: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Pin + Country
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
                items: ["IN", "US", "UK"],
                value: selectedCountry,
                onChanged: onCountryChanged,
                isRequired: true,
              ),
            ),
          ],
        ),
        if (showNotes) ...[
          const SizedBox(height: 16),
          CommonLabeledTextField(
            label: "Order notes (optional)",
            hint: "Notes about your order, e.g. special notes for delivery.",
            controller: notesController!,
          ),
        ],
      ],
    );
  }

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
                const SizedBox(height: 32),
                Row(
                  children: [
                    Checkbox(
                      value: billToDifferent,
                      onChanged: (val) {
                        setState(() {
                          billToDifferent = val ?? false;
                        });
                      },
                    ),
                    const Text(
                      "Bill to a different address?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                const Text(
                  "Shipping details",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildAddressForm(
                  firstNameController: firstNameController,
                  lastNameController: lastNameController,
                  emailController: emailController,
                  phoneController: phoneController,
                  streetController: streetController,
                  apartmentController: apartmentController,
                  cityController: cityController,
                  pinController: pinController,
                  selectedState: selectedState,
                  selectedCountry: selectedCountry,
                  onStateChanged: (val) => setState(() => selectedState = val),
                  onCountryChanged:
                      (val) => setState(() => selectedCountry = val),
                  showNotes: true,
                  notesController: notesController,
                ),
                if (billToDifferent) ...[
                  const SizedBox(height: 24),
                  const Text(
                    "Billing details",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildAddressForm(
                    firstNameController: billingFirstNameController,
                    lastNameController: billingLastNameController,
                    emailController: billingEmailController,
                    phoneController: billingPhoneController,
                    streetController: billingStreetController,
                    apartmentController: billingApartmentController,
                    cityController: billingCityController,
                    pinController: billingPinController,
                    selectedState: billingSelectedState,
                    selectedCountry: billingSelectedCountry,
                    onStateChanged:
                        (val) => setState(() => billingSelectedState = val),
                    onCountryChanged:
                        (val) => setState(() => billingSelectedCountry = val),
                    showNotes: false,
                  ),
                ],

                // First name & Last name
                // Row(
                //   children: [
                //     Expanded(
                //       child: CommonLabeledTextField(
                //         label: "First name",
                //         hint: "Enter first name",
                //         controller: firstNameController,
                //         isRequired: true,
                //       ),
                //     ),
                //     const SizedBox(width: 12),
                //     Expanded(
                //       child: CommonLabeledTextField(
                //         label: "Last name",
                //         hint: "Enter last name",
                //         controller: lastNameController,
                //         isRequired: true,
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 16),

                // Row(
                //   children: [
                //     Expanded(
                //       child: CommonLabeledTextField(
                //         label: "Email address",
                //         hint: "Enter email address",
                //         controller: emailController,
                //         isRequired: true,
                //         keyboardType: TextInputType.emailAddress,
                //       ),
                //     ),
                //     const SizedBox(width: 12),
                //     Expanded(
                //       child: CommonLabeledTextField(
                //         label: "Phone",
                //         hint: "Enter phone number",
                //         controller: phoneController,
                //         isRequired: true,
                //         keyboardType: TextInputType.phone,
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 16),

                // CommonLabeledTextField(
                //   label: "Street address",
                //   hint: "House number and street name",
                //   controller: streetController,
                //   isRequired: true,
                // ),

                // CommonLabeledTextField(
                //   label: "",
                //   hint: "Apartment, suite, unit, etc. (optional)",
                //   controller: apartmentController,
                // ),
                // const SizedBox(height: 16),

                // Row(
                //   children: [
                //     Expanded(
                //       child: CommonLabeledTextField(
                //         label: "Town / City",
                //         hint: "Enter town/city",
                //         controller: cityController,
                //         isRequired: true,
                //       ),
                //     ),
                //     const SizedBox(width: 12),
                //     Expanded(
                //       child: CommonLabeledDropdown(
                //         label: "State",
                //         hint: "Select an option",
                //         items: ["Gujarat", "Maharashtra", "Delhi", "Rajasthan"],
                //         value: selectedState,
                //         onChanged: (val) {
                //           selectedState = val;
                //         },
                //         isRequired: true,
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 16),

                // Row(
                //   children: [
                //     Expanded(
                //       child: CommonLabeledTextField(
                //         label: "PIN Code",
                //         hint: "Enter postcode/zip",
                //         controller: pinController,
                //         isRequired: true,
                //         keyboardType: TextInputType.number,
                //       ),
                //     ),
                //     const SizedBox(width: 12),
                //     Expanded(
                //       child: CommonLabeledDropdown(
                //         label: "Country / Region",
                //         hint: "Select country",
                //         items: ["IN", "US", "UK"],
                //         value: selectedCountry,
                //         onChanged: (val) {
                //           selectedCountry = val;
                //         },
                //         isRequired: true,
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 16),

                // CommonLabeledTextField(
                //   label: "Order notes (optional)",
                //   hint:
                //       "Notes about your order, e.g. special notes for delivery.",
                //   controller: notesController,
                // ),
                const SizedBox(height: 32),
                Obx(() {
                  final cart = cartController.cart.value?.data?.cart;
                  final nodes = cart?.contents?.nodes ?? [];

                  if (cartController.isFetchingCart.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (nodes.isEmpty) {
                    return const Center(child: Text("Your cart is empty."));
                  }
                  return Card(
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
                          _PriceRow(
                            title: "Subtotal",
                            amount: "${cart?.currencySymbol}${cart?.subtotal}",
                          ),

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
                          ...nodes.map((item) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${item.product?.node?.name ?? ""}  x ${item.quantity ?? 1}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.grey_212121,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "${cart?.currencySymbol}${item.product?.node?.price}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.grey_212121,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
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
                                "${cart?.currencySymbol}${cart?.total}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                          PaymentMethodCard(
                            onPlaceOrder: (paymentMethod) async {
                              final controller = Get.put(AccountController());
                              if (paymentMethod == "razorpay") {
                                final paymentId = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) => RazorpayPaymentScreen(
                                          amount: 500.0,
                                          name:
                                              "${firstNameController.text} ${lastNameController.text}",
                                          email: emailController.text,
                                          phone: phoneController.text,
                                          onSuccess: (paymentId) {
                                            // After payment, call checkout with Razorpay method
                                            controller.checkout(
                                              context: context,
                                              firstName:
                                                  firstNameController.text,
                                              lastName: lastNameController.text,
                                              email: emailController.text,
                                              phone: phoneController.text,
                                              address: streetController.text,
                                              city: cityController.text,
                                              state: selectedState ?? "",
                                              postcode: pinController.text,
                                              country: selectedCountry ?? "IN",
                                              customerNote:
                                                  notesController.text,
                                              billToDifferent: billToDifferent,
                                              shippingFirstName:
                                                  billingFirstNameController
                                                      .text,
                                              shippingLastName:
                                                  billingLastNameController
                                                      .text,
                                              shippingAddress:
                                                  billingStreetController.text,
                                              shippingCity:
                                                  billingCityController.text,
                                              shippingState:
                                                  billingSelectedState,
                                              shippingPostcode:
                                                  billingPinController.text,
                                              shippingCountry:
                                                  billingSelectedCountry,
                                              paymentMethod: "razorpay",
                                            );
                                          },
                                        ),
                                  ),
                                );
                              } else {
                                controller.checkout(
                                  context: context,
                                  firstName: firstNameController.text,
                                  lastName: lastNameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  address: streetController.text,
                                  city: cityController.text,
                                  state: selectedState ?? "",
                                  postcode: pinController.text,
                                  country: selectedCountry ?? "IN",
                                  customerNote: notesController.text,
                                  billToDifferent: billToDifferent,
                                  shippingFirstName:
                                      billingFirstNameController.text,
                                  shippingLastName:
                                      billingLastNameController.text,
                                  shippingAddress: billingStreetController.text,
                                  shippingCity: billingCityController.text,
                                  shippingState: billingSelectedState,
                                  shippingPostcode: billingPinController.text,
                                  shippingCountry: billingSelectedCountry,
                                  paymentMethod: paymentMethod,
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }),
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
