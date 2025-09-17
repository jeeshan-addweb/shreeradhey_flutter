import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shree_radhey/features/accounts/controller/account_controller.dart';
import 'package:shree_radhey/features/auth/controller/auth_controller.dart';

import '../../../common/components/common_footer.dart';
import '../../../common/components/common_textfield.dart';
import '../../../common/components/custom_dropdown.dart';
import '../../../common/components/gradient_button.dart';
import '../../../constants/app_colors.dart';
import '../model/address_model.dart';
import 'components/address_card.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final AccountController _accountController = Get.put(AccountController());
  final AuthController _authController = Get.put(AuthController());
  bool _showForm = false;

  // dropdown state
  String? selectedAddressType;
  String? selectedCountry;
  String? selectedState;
  int? _editingAddressId;

  // controllers
  final addressLabelCtrl = TextEditingController();
  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final companyCtrl = TextEditingController();
  final addressLine1Ctrl = TextEditingController();
  final addressLine2Ctrl = TextEditingController();
  final cityCtrl = TextEditingController();
  final postcodeCtrl = TextEditingController();

  @override
  void dispose() {
    addressLabelCtrl.dispose();
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    phoneCtrl.dispose();
    emailCtrl.dispose();
    companyCtrl.dispose();
    addressLine1Ctrl.dispose();
    addressLine2Ctrl.dispose();
    cityCtrl.dispose();
    postcodeCtrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _accountController.getAddresses());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GradientButton(
                    text: 'Add New Address',
                    onPressed: () => setState(() => _showForm = !_showForm),
                  ),
                  const SizedBox(height: 16),

                  if (_showForm) _buildAddressForm(),
                ],
              ),
            ),

            Obx(() {
              if (_accountController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (_accountController.addresses.isEmpty) {
                return const Center(child: Text("No addresses found"));
              }

              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: _accountController.addresses.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final addr = _accountController.addresses[index];
                  debugPrint("Address id is : - ${addr.id}");
                  debugPrint("Auth id  is : - ${_authController.userId}");
                  return AddressCard(
                    address: AddressModel(
                      name: "${addr.firstName} ${addr.lastName}",
                      type: addr.addressType ?? "Other",
                      addressLine1: addr.address1 ?? "",
                      addressLine2: addr.address2 ?? "",
                      city: addr.city ?? "",
                      pinCode: addr.postcode ?? "",
                      isDefault: addr.isDefault == 1,
                    ),
                    onEdit: () {
                      setState(() {
                        _showForm = true;

                        // Pre-fill controllers
                        addressLabelCtrl.text = addr.addressLabel ?? "";
                        firstNameCtrl.text = addr.firstName ?? "";
                        lastNameCtrl.text = addr.lastName ?? "";
                        phoneCtrl.text = addr.phone ?? "";
                        emailCtrl.text = addr.email ?? "";
                        companyCtrl.text = addr.company ?? "";
                        addressLine1Ctrl.text = addr.address1 ?? "";
                        addressLine2Ctrl.text = addr.address2 ?? "";
                        cityCtrl.text = addr.city ?? "";
                        postcodeCtrl.text = addr.postcode ?? "";

                        selectedAddressType = addr.addressType ?? "Shipping";
                        selectedCountry =
                            addr.country == "IN" ? "India" : "USA";
                        selectedState = addr.state ?? "Gujarat";

                        _editingAddressId = addr.id;
                      });
                    },

                    onDelete: () async {
                      if (mounted) {
                        await _accountController.deleteAddress(
                          addr.id!,
                          int.parse(
                            _authController.userId.toString(),
                          ), // convert to int
                          context,
                        );
                      }
                    },
                    onSetDefault: () async {
                      await _accountController.saveOrUpdateAddress({
                        "id": addr.id,
                        "is_default": 1,
                      }, context);
                    },
                  );
                },
              );
            }),
            const CommonFooter(),
          ],
        ),
      ),
    );
  }

  // --- address form widget ---
  Widget _buildAddressForm() {
    return Column(
      children: [
        CustomDropdown(
          label: "Address Type",
          hintText: "Select address type",
          items: const ["Shipping", "Billing"],
          value: selectedAddressType,
          onChanged: (val) => setState(() => selectedAddressType = val),
          validator: (_) => null,
        ),
        const SizedBox(height: 16),

        CommonLabeledTextField(
          label: "Address Label",
          hint: "e.g. Home / Office",
          controller: addressLabelCtrl,
          isRequired: true,
        ),
        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: CommonLabeledTextField(
                label: "First name",
                hint: "Enter first name",
                controller: firstNameCtrl,
                isRequired: true,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CommonLabeledTextField(
                label: "Last name",
                hint: "Enter last name",
                controller: lastNameCtrl,
                isRequired: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        CommonLabeledTextField(
          label: "Phone",
          hint: "Enter phone number",
          controller: phoneCtrl,
          isRequired: true,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 16),

        CommonLabeledTextField(
          label: "Email",
          hint: "Enter email address",
          controller: emailCtrl,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),

        CommonLabeledTextField(
          label: "Company",
          hint: "Company name (optional)",
          controller: companyCtrl,
        ),
        const SizedBox(height: 16),

        CustomDropdown(
          label: "Country",
          hintText: "Select country",
          items: const ["India", "USA", "UK"],
          value: selectedCountry,
          onChanged: (val) => setState(() => selectedCountry = val),
          validator: (_) => null,
        ),
        const SizedBox(height: 16),

        CustomDropdown(
          label: "State",
          hintText: "Select state",
          items: const ["Gujarat", "Maharashtra", "Rajasthan"],
          value: selectedState,
          onChanged: (val) => setState(() => selectedState = val),
          validator: (_) => null,
        ),
        const SizedBox(height: 16),

        CommonLabeledTextField(
          label: "Address Line 1",
          hint: "House number and street name",
          controller: addressLine1Ctrl,
          isRequired: true,
        ),
        const SizedBox(height: 16),

        CommonLabeledTextField(
          label: "Address Line 2",
          hint: "Apartment, suite, unit, etc. (optional)",
          controller: addressLine2Ctrl,
        ),
        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: CommonLabeledTextField(
                label: "City",
                hint: "Enter city",
                controller: cityCtrl,
                isRequired: true,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CommonLabeledTextField(
                label: "Postcode",
                hint: "Enter postcode/zip",
                controller: postcodeCtrl,
                isRequired: true,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        Row(
          children: [
            Expanded(
              child: GradientButton(
                text: 'Save address',
                onPressed: () {
                  final newAddress = {
                    "id": _editingAddressId,
                    "address_type": (selectedAddressType ?? "Shipping"),
                    "address_label": addressLabelCtrl.text.trim(),
                    "first_name": firstNameCtrl.text.trim(),
                    "last_name": lastNameCtrl.text.trim(),
                    "company": companyCtrl.text.trim(),
                    "country":
                        (selectedCountry ?? "India")
                            .substring(0, 2)
                            .toUpperCase(), // e.g. IN
                    "address_1": addressLine1Ctrl.text.trim(),
                    "address_2": addressLine2Ctrl.text.trim(),
                    "city": cityCtrl.text.trim(),
                    "state": (selectedState ?? "").toUpperCase(), // e.g. GJ
                    "postcode": postcodeCtrl.text.trim(),
                    "phone": phoneCtrl.text.trim(),
                    "email": emailCtrl.text.trim(),
                    "is_default": 0,
                  };
                  _accountController.saveOrUpdateAddress(newAddress, context);
                  _cancelForm();
                  _editingAddressId = null;
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GradientButton(text: 'Cancel', onPressed: _cancelForm),
            ),
          ],
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  void _cancelForm() {
    addressLabelCtrl.clear();
    firstNameCtrl.clear();
    lastNameCtrl.clear();
    phoneCtrl.clear();
    emailCtrl.clear();
    companyCtrl.clear();
    addressLine1Ctrl.clear();
    addressLine2Ctrl.clear();
    cityCtrl.clear();
    postcodeCtrl.clear();
    setState(() {
      selectedAddressType = null;
      selectedCountry = null;
      selectedState = null;
      _showForm = false;
    });
  }
}
