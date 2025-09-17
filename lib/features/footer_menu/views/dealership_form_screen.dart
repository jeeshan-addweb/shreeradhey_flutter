import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/components/common_footer.dart';
import '../../../common/components/common_textfield.dart';
import '../../../common/components/gradient_button.dart';
import '../../../constants/app_colors.dart';
import '../controller/footer_controller.dart';

class DealershipFormScreen extends StatefulWidget {
  const DealershipFormScreen({super.key});

  @override
  State<DealershipFormScreen> createState() => _DealershipFormScreenState();
}

class _DealershipFormScreenState extends State<DealershipFormScreen> {
  final FooterController footerController = Get.put(FooterController());
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final nameOfFirmController = TextEditingController();
  final gstController = TextEditingController();
  final address1Controller = TextEditingController();
  final address2Controller = TextEditingController();
  final cityController = TextEditingController();
  final pinCodeController = TextEditingController();
  final countryController = TextEditingController();
  final proprietorController = TextEditingController();
  final mobileController = TextEditingController();
  final contactPersonController = TextEditingController();
  final contactPersonMobileController = TextEditingController();
  final emailController = TextEditingController();
  final brandsController = TextEditingController();
  final turnoverController = TextEditingController();
  final supplyPointsController = TextEditingController();
  final areaOfOperationController = TextEditingController();

  // Radio groups
  String natureOfBusiness = "Counter Sale+distribution";
  String applyingFor = "Distribution";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "We are welcoming Dealers from all over the Globe",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "We would love to have dealers from India and Abroad "
                      "who wish to sell our products. Please fill the form below "
                      "and we will get in touch with you in 72 Hours.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),

                    CommonLabeledTextField(
                      hint: "",
                      label: "Name of Firm*",
                      controller: nameOfFirmController,
                    ),
                    const SizedBox(height: 16),
                    CommonLabeledTextField(
                      hint: "",
                      label: "GST No.* (required)",
                      controller: gstController,
                    ),
                    const SizedBox(height: 16),
                    CommonLabeledTextField(
                      label: "Address Line1*",
                      controller: address1Controller,
                      hint: '',
                    ),
                    const SizedBox(height: 16),
                    CommonLabeledTextField(
                      label: "Address Line2",
                      controller: address2Controller,
                      hint: '',
                    ),
                    const SizedBox(height: 16),
                    CommonLabeledTextField(
                      label: "City*",
                      controller: cityController,
                      hint: '',
                    ),
                    const SizedBox(height: 16),
                    CommonLabeledTextField(
                      label: "Pin Code",
                      hint: '',
                      controller: pinCodeController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    CommonLabeledTextField(
                      hint: '',
                      label: "Country*",
                      controller: countryController,
                    ),
                    const SizedBox(height: 16),
                    CommonLabeledTextField(
                      hint: '',
                      label: "Name of Proprietor/Authorised Signatory*",
                      controller: proprietorController,
                    ),
                    const SizedBox(height: 16),
                    CommonLabeledTextField(
                      hint: '',
                      label: "Mobile Number*",
                      controller: mobileController,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),
                    CommonLabeledTextField(
                      hint: '',
                      label: "Contact Person*",
                      controller: contactPersonController,
                    ),
                    const SizedBox(height: 16),
                    CommonLabeledTextField(
                      label: "Contact Person Mobile Number",
                      controller: contactPersonMobileController,
                      keyboardType: TextInputType.phone,
                      hint: '',
                    ),
                    const SizedBox(height: 16),
                    CommonLabeledTextField(
                      hint: '',
                      label: "Email Address*",
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 20),
                    Text(
                      "BUSINESS DETAILS".toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppColors.grey_65758b,
                      ),
                    ),
                    const SizedBox(height: 10),

                    CommonLabeledTextField(
                      fontSize: 14,
                      label: "Brands Already Selling",
                      controller: brandsController,
                      hint: '',
                    ),

                    const SizedBox(height: 12),
                    const Text("Nature of Business"),
                    Column(
                      children: [
                        RadioListTile(
                          activeColor: AppColors.green_6cad10,
                          dense: true,
                          visualDensity: VisualDensity.compact,
                          value: "Counter Sale+distribution",
                          groupValue: natureOfBusiness,
                          title: const Text("Counter Sale + Distribution"),
                          onChanged: (value) {
                            setState(() => natureOfBusiness = value!);
                          },
                        ),
                        RadioListTile(
                          activeColor: AppColors.green_6cad10,
                          dense: true,
                          visualDensity: VisualDensity.compact,
                          value: "Counter Sale Only",
                          groupValue: natureOfBusiness,
                          title: const Text("Counter Sale Only"),
                          onChanged: (value) {
                            setState(() => natureOfBusiness = value!);
                          },
                        ),
                        RadioListTile(
                          activeColor: AppColors.green_6cad10,
                          dense: true,
                          visualDensity: VisualDensity.compact,
                          value: "Distribution Only",
                          groupValue: natureOfBusiness,
                          title: const Text("Distribution Only"),
                          onChanged: (value) {
                            setState(() => natureOfBusiness = value!);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    CommonLabeledTextField(
                      hint: '',
                      label: "Annual Turnover*",
                      controller: turnoverController,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 16),
                    CommonLabeledTextField(
                      label: "No. of Supply Points",
                      controller: supplyPointsController,
                      keyboardType: TextInputType.number,
                      hint: '',
                    ),

                    const SizedBox(height: 12),
                    const Text("Applying For"),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            activeColor: AppColors.green_6cad10,
                            dense: true,
                            visualDensity: VisualDensity.compact,
                            value: "Distribution",
                            groupValue: applyingFor,
                            title: const Text("Distribution"),
                            onChanged: (value) {
                              setState(() => applyingFor = value!);
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            activeColor: AppColors.green_6cad10,
                            dense: true,
                            visualDensity: VisualDensity.compact,
                            value: "Direct Dealer",
                            groupValue: applyingFor,
                            title: const Text("Direct Dealer"),
                            onChanged: (value) {
                              setState(() => applyingFor = value!);
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    CommonLabeledTextField(
                      hint: '',
                      label: "Area of Operation*",
                      controller: areaOfOperationController,
                    ),

                    const SizedBox(height: 24),

                    Obx(() {
                      return GradientButton(
                        text: "Submit",
                        isLoading: footerController.isLoading.value,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            footerController
                                .submitDealer(
                                  context: context,
                                  firmName: nameOfFirmController.text.trim(),
                                  gstNo: gstController.text.trim(),
                                  addressLine1: address1Controller.text.trim(),
                                  addressLine2: address2Controller.text.trim(),
                                  city: cityController.text.trim(),
                                  pinCode: pinCodeController.text.trim(),
                                  country: countryController.text.trim(),
                                  nameofProp: proprietorController.text.trim(),
                                  mobileNumber: mobileController.text.trim(),
                                  contactPersonName:
                                      contactPersonController.text.trim(),
                                  contactPersonMobile:
                                      contactPersonMobileController.text.trim(),
                                  emailAddress: emailController.text.trim(),
                                  brandsAlreadySelling:
                                      brandsController.text.trim(),
                                  natureOfBusiness: natureOfBusiness,
                                  annualTurnover:
                                      turnoverController.text.trim(),
                                  supplyPoints:
                                      supplyPointsController.text.trim(),
                                  applyingFor: applyingFor,
                                  areaofOperation:
                                      areaOfOperationController.text.trim(),
                                )
                                .then((_) {
                                  nameOfFirmController.clear();
                                  gstController.clear();
                                  address1Controller.clear();
                                  address2Controller.clear();
                                  cityController.clear();
                                  pinCodeController.clear();
                                  countryController.clear();
                                  proprietorController.clear();
                                  mobileController.clear();
                                  contactPersonController.clear();
                                  contactPersonMobileController.clear();
                                  emailController.clear();
                                  brandsController.clear();
                                  turnoverController.clear();
                                  supplyPointsController.clear();
                                  areaOfOperationController.clear();

                                  setState(() {
                                    natureOfBusiness =
                                        "Counter Sale+distribution";
                                    applyingFor = "Distribution";
                                  });

                                  // Reset form state
                                  _formKey.currentState?.reset();
                                });
                          }
                        },
                      );
                    }),
                  ],
                ),
              ),
              SizedBox(height: 40),
              CommonFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
