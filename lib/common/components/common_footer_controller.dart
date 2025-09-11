import 'package:get/get.dart';
import 'package:shree_radhey/common/components/common_footer_repo.dart';
import 'package:shree_radhey/common/model/amazon_review_model.dart';

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
