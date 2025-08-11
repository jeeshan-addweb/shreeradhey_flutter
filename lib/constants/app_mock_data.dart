import '../common/model/product_model.dart';
import '../features/home/model/blog_model.dart';
import '../features/home/model/client_review.dart';
import '../features/home/model/core_value_model.dart';
import 'app_images.dart';

class AppMockData {
  static List<ClientReview> reviews = [
    ClientReview(
      name: 'amren',
      date: '16 February 2025',
      rating: 4.5,
      comment:
          'The ghee bottles were packed very nicely. Arrived without any damage.The ghee bottles were packed very nicely. Arrived without any damage.The ghee bottles were packed very nicely. Arrived without any damage.The ghee bottles were packed very nicely. Arrived without any damage.The ghee bottles were packed very nicely. Arrived without any damage.The ghee bottles were packed very nicely. Arrived without any damage.The ghee bottles were packed very nicely. Arrived without any damage.The ghee bottles were packed very nicely. Arrived without any damage.The ghee bottles were packed very nicely. Arrived without any damage.The ghee bottles were packed very nicely. Arrived without any damage.',
      profileImage: AppImages.person,
    ),
    ClientReview(
      name: 'nikhil',
      date: '16 February 2025',
      rating: 4.5,
      comment:
          'The ghee bottles were packed very nicely. Arrived without any damage.',
      profileImage: AppImages.person,
    ),
    // Add more...
  ];

  static List<ProductModel> mockProducts = [
    ProductModel(
      imageUrl: AppImages.product_image,
      title: 'SHREERADHEY A2 gir cow ghee\n(1L Pet Bottle Pack of 2)',
      subtitle: 'Combo, Ghee',
      rating: 4.7,
      reviewCount: 109,
      price: 110,
      oldPrice: 145,
      couponPrice: 94,
      tagText: "Best Seller",
    ),
    ProductModel(
      imageUrl: AppImages.product_image,
      title: 'SHREERADHEY Ghee (1L Pet Bottle)',
      subtitle: 'Ghee',
      rating: 4.4,
      reviewCount: 82,
      price: 68,
      oldPrice: 70,
      couponPrice: 55,
      tagText: "Best Seller",
    ),
    // Add more...
  ];

  static List<CoreValueModel> coreValueItems = [
    CoreValueModel(
      imagePath: AppImages.core_value_one,
      title: "Origin",
      description:
          "Delivering naturally sourced ingredients straight from farms",
    ),
    CoreValueModel(
      imagePath: AppImages.core_value_two,
      title: "Heritage",
      description: "Embracing timeless practices passed through generations",
    ),
    CoreValueModel(
      imagePath: AppImages.core_value_three,
      title: "Integrity",
      description: "Ensuring full clarity with verified quality checks",
    ),
    CoreValueModel(
      imagePath: AppImages.core_value_four,
      title: "Impact",
      description: "Uplifting village communities through jobs and practices",
    ),
    // Add more...
  ];

  static List<BlogModel> blogItems = [
    BlogModel(
      imagePath: AppImages.product_image_blog,
      title: 'Health Benefits Of Using A2 Ghee In Raksha Bandhan Sweets',
      description:
          'Raksha Bandhan is more than just a festival – it’s a celebration of love, traditions, and togetherness.',
    ),
    BlogModel(
      imagePath: AppImages.product_image_blog,
      title: 'How To Use Desi Ghee For Cold And Cough',
      description:
          'A2 Desi ghee, especially when sourced from native cow milk, using traditional methods, is a time-tested remedy.',
    ),
    BlogModel(
      imagePath: AppImages.product_image_blog,
      title: 'How To Choose The Best A2 Cow Ghee In India',
      description:
          'In recent years, A2 cow ghee has gained significant popularity among health-conscious individuals.',
    ),
    BlogModel(
      imagePath: AppImages.product_image_blog,
      title: 'Health Benefits Of Including A2 Cow Ghee In Your Monsoon Diet',
      description:
          'The monsoon season is known for cool breezes, fresh rains, and comforting hot meals, often enhanced with desi ghee.',
    ),
  ];
}
