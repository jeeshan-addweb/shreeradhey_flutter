import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shree_radhey/features/footer_menu/repo/footer_repo.dart';

import '../model/about_us_page_model.dart';

class FooterController extends GetxController {
  final FooterRepo _repo = FooterRepo();

  var isLoading = true.obs;
  var aboutUs = Rxn<AboutUsPageModel>();

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
}
