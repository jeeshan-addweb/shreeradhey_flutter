import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shree_radhey/features/shop/models/product_mapper.dart';
import 'model/ui_product_model.dart';
import 'search_repo.dart';

class SearchProductController extends GetxController {
  final SearchRepo _searchRepo = SearchRepo();

  /// Observables
  var isLoading = false.obs;
  var searchResults = <UiProductModel>[].obs;
  var errorMessage = "".obs;

  /// Search function
  Future<void> searchProducts(String query) async {
    if (query.trim().isEmpty) {
      searchResults.clear();
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = "";
      final results = await Future.wait([_searchRepo.searchProducts(query)]);

      searchResults.assignAll(results[0].map((e) => e.toUiModel()).toList());
    } catch (e) {
      debugPrint("SearchController error: $e");
      errorMessage.value = "Something went wrong. Please try again.";
      searchResults.clear();
    } finally {
      isLoading.value = false;
    }
  }

  /// Helper: clear search
  void clearSearch() {
    searchResults.clear();
    errorMessage.value = "";
  }
}
