import 'package:get_storage/get_storage.dart';
import 'package:shree_radhey/features/cart/controller/cart_controller.dart';
import 'package:shree_radhey/features/home/controller/wishlist_controller.dart';

import 'data/network/shared_pref/shared_preference_helper.dart';
import 'features/auth/controller/auth_controller.dart';
import 'utils/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  final wishlistController = Get.put(WishlistController());
  final authController = Get.put(AuthController());
  final cartController = Get.put(CartController());

  await authController.loadToken();

  if (authController.isLoggedIn) {
    await wishlistController.fetchWishlist();
    await cartController.fetchCartItems();
  }

  runApp(MyApp(authController: authController));
}

class MyApp extends StatelessWidget {
  final AuthController authController;
  MyApp({super.key, required this.authController});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp.router(
        title: 'Shree Radhey',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white), // global color
          ),
          primarySwatch: Colors.red,
          fontFamily: 'Inter', // 👈 Set Inter as the global font
          textTheme: TextTheme(
            bodyLarge: TextStyle(fontWeight: FontWeight.w400),
            bodyMedium: TextStyle(fontWeight: FontWeight.w400),
            titleLarge: TextStyle(fontWeight: FontWeight.w700),
          ),
          // textTheme: GoogleFonts.robotoTextTheme(),
        ),
        routerDelegate: AppRouter.router.routerDelegate,
        routeInformationParser: AppRouter.router.routeInformationParser,
        routeInformationProvider: AppRouter.router.routeInformationProvider,
      );
    });
  }
}
