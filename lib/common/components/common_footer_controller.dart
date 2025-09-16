import 'package:get/get.dart';

import '../model/amazon_review_model.dart';
import 'common_footer_repo.dart';

class CommonFooterController extends GetxController {
  final CommonFooterRepo _repo = CommonFooterRepo();
  var amazonReviews = <AmazonReview>[].obs;
  var isAmazonReviewLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    fetchAmazonReviews();
  }

  Future<void> fetchAmazonReviews() async {
    try {
      isAmazonReviewLoading.value = true;
      final result = await _repo.getAmazonReviews();

      amazonReviews.addAll(result);
    } catch (e) {
      print("Amazon reviews fetch error: $e");
      amazonReviews.clear();
    } finally {
      isAmazonReviewLoading.value = false;
    }
  }
}
