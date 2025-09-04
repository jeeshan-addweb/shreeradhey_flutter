import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shree_radhey/features/footer_menu/model/faq_model.dart';
import 'package:shree_radhey/features/footer_menu/model/privacy_policy_model.dart';
import 'package:shree_radhey/features/footer_menu/model/refund_policy_model.dart';
import 'package:shree_radhey/features/footer_menu/model/shipping_model.dart';
import 'package:shree_radhey/features/footer_menu/model/terms_condition_model.dart';
import 'package:shree_radhey/features/footer_menu/repo/footer_repo.dart';

import '../model/about_us_page_model.dart';

class FooterController extends GetxController {
  final FooterRepo _repo = FooterRepo();

  var isLoading = true.obs;
  var aboutUs = Rxn<AboutUsPageModel>();
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
}
