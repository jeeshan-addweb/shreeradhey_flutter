import 'package:flutter/material.dart';
import 'package:shree_radhey/constants/app_images.dart';

class EmptyWishlistView extends StatelessWidget {
  const EmptyWishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Example: Lottie animation (use a nice cart animation JSON)
            // Lottie.asset('assets/animations/empty_cart.json', height: 200),

            // Or use a static image if you don't want lottie
            Image.asset(AppImages.empty_wishlist, height: 200),

            const SizedBox(height: 20),

            // const Text(
            //   "No products added to the wishlist",
            //   style: TextStyle(
            //     fontSize: 18,
            //     fontWeight: FontWeight.w600,
            //     color: Colors.black54,
            //   ),
            // ),

            // const SizedBox(height: 10),
            Text(
              "Looks like you haven’t added anything yet.",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),

            // const SizedBox(height: 30),
            // GradientButton(
            //   text: "Continue Shopping",
            //   onPressed: () {
            //     context.push(AppRoutePath.shopScreen);
            //   },
            // ),

            // ElevatedButton(
            //   onPressed: () {
            //     // Navigate to shop/home
            //     context.push(AppRoutePath.shopScreen);
            //   },
            //   style: ElevatedButton.styleFrom(
            //     padding: const EdgeInsets.symmetric(
            //       horizontal: 24,
            //       vertical: 12,
            //     ),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(8),
            //     ),
            //   ),
            //   child: const Text(
            //     "Continue Shopping",
            //     style: TextStyle(fontSize: 16),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
