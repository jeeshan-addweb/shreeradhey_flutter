import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shree_radhey/features/footer_menu/model/faq_model.dart';
import 'package:shree_radhey/features/footer_menu/model/privacy_policy_model.dart';
import 'package:shree_radhey/features/footer_menu/model/refund_policy_model.dart';
import 'package:shree_radhey/features/footer_menu/model/shipping_model.dart';
import 'package:shree_radhey/features/footer_menu/model/terms_condition_model.dart';
import 'package:shree_radhey/features/footer_menu/repo/footer_repo.dart';

import '../../../common/components/custom_snackbar.dart';
import '../model/about_us_page_model.dart';
import '../model/wood_press_oil_model.dart';

class FooterController extends GetxController {
  final FooterRepo _repo = FooterRepo();

  var isLoading = false.obs;
  var aboutUs = Rxn<AboutUsPageModel>();
  var woodPress = Rxn<WoodPressOilModel>();
  var refundPolicy = Rxn<RefundPolicyModel>();
  var privacyPolicy = Rxn<PrivacyPolicyModel>();
  var faq = Rxn<FaqModel>();
  var termsCondition = Rxn<TermsConditionModel>();
  var shipping = Rxn<ShippingModel>();

  Future<void> fetchAboutUs() async {
    try {
      isLoading.value = true;
      final result = await _repo.fetchAboutUs();
      debugPrint("RAW RESPONSE: ${result.toJson()}");
      aboutUs.value = result;
      debugPrint("Result is ${result.data?.pageBy?.toJson()}");
    } catch (e) {
      print("Error fetching About Us: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchRefundPolicy() async {
    try {
      isLoading.value = true;
      final result = await _repo.fetchRefundPolicy();
      debugPrint("RAW RESPONSE: ${result.toJson()}");
      refundPolicy.value = result;
      debugPrint("Result is ${result.data?.pageBy?.toJson()}");
    } catch (e) {
      print("Error fetching refund policy: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchPrivacyPolicy() async {
    try {
      isLoading.value = true;
      final result = await _repo.fetchPrivacyPolicy();
      debugPrint("RAW RESPONSE: ${result.toJson()}");
      privacyPolicy.value = result;
      debugPrint("Result is ${result.data?.pageBy?.toJson()}");
    } catch (e) {
      print("Error fetching privacy policy: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchFAQ() async {
    try {
      isLoading.value = true;
      final result = await _repo.fetchFAQ();
      debugPrint("RAW RESPONSE: ${result.toJson()}");
      faq.value = result;
      debugPrint("Result is ${result.data?.pageBy?.toJson()}");
    } catch (e) {
      print("Error fetching faq: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchTermsCondition() async {
    try {
      isLoading.value = true;
      final result = await _repo.fetchTermsCondition();
      debugPrint("RAW RESPONSE: ${result.toJson()}");
      termsCondition.value = result;
      debugPrint("Result is ${result.data?.pageBy?.toJson()}");
    } catch (e) {
      print("Error fetching t&c: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchShipping() async {
    try {
      isLoading.value = true;
      final result = await _repo.fetchShipping();
      debugPrint("RAW RESPONSE: ${result.toJson()}");
      shipping.value = result;
      debugPrint("Result is ${result.data?.pageBy?.toJson()}");
    } catch (e) {
      print("Error fetching shipping: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> submitContact({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String message,
  }) async {
    try {
      isLoading.value = true;

      final response = await _repo.submitContactForm({
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phone": phone,
        "message": message,
      });

      if (response['success'] == true) {
        CustomSnackbars.showSuccess(
          context,
          response['message'] ?? "Submitted",
        );
      } else {
        CustomSnackbars.showError(context, response['message'] ?? "Failed");
      }
    } catch (e) {
      debugPrint("SubmitContact error: $e");
      CustomSnackbars.showError(context, "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> submitDealer({
    required BuildContext context,
    required String firmName,
    required String gstNo,
    required String addressLine1,
    required String addressLine2,
    required String city,
    required String pinCode,
    required String country,
    required String nameofProp,
    required String mobileNumber,
    required String contactPersonName,
    required String contactPersonMobile,
    required String emailAddress,
    required String brandsAlreadySelling,
    required String natureOfBusiness,
    required String annualTurnover,
    required String supplyPoints,
    required String applyingFor,
    required String areaofOperation,
  }) async {
    try {
      isLoading.value = true;

      final response = await _repo.submitDealerForm({
        "name_of_firm": firmName,
        "gst_no": gstNo,
        "address_line1": addressLine1,
        "address_line2": addressLine2,
        "city": city,
        "pin_code": pinCode,
        "country": country,
        "name_of_prop": nameofProp,
        "mobile_number": mobileNumber,
        "contact_person": contactPersonName,
        "contact_person_mobile": contactPersonMobile,
        "email_address": emailAddress,
        "brands_already_selling": brandsAlreadySelling,
        "nature_of_business": natureOfBusiness,
        "annual_turnover": annualTurnover,
        "supply_points": supplyPoints,
        "applying_for": applyingFor,
        "area_of_operation": areaofOperation,
      });

      if (response['success'] == true) {
        CustomSnackbars.showSuccess(
          context,
          response['message'] ?? "Submitted",
        );
      } else {
        CustomSnackbars.showError(context, response['message'] ?? "Failed");
      }
    } catch (e) {
      debugPrint("SubmitContact error: $e");
      CustomSnackbars.showError(context, "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> subscribe(String email, BuildContext context) async {
    try {
      isLoading.value = true;
      final data = await _repo.subscribeUser(email);

      if (data["success"] == true) {
        CustomSnackbars.showSuccess(context, data['message'] ?? "Submitted");
      } else {
        CustomSnackbars.showError(context, data['message'] ?? "Failed");
      }
    } catch (e) {
      debugPrint("Subscribe error: $e");
      CustomSnackbars.showError(context, "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchWoodPress(String slug) async {
    try {
      isLoading.value = true;
      final result = await _repo.fetchWoodPressOil(slug);
      debugPrint("RAW RESPONSE: ${result.toJson()}");

      woodPress.value = result;

      debugPrint("Page title: ${result.data?.page?.title}");
      debugPrint("Sections count: ${result.data?.page?.sections?.length}");
    } catch (e) {
      debugPrint("Error fetching Wood Press: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
