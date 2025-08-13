import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants/app_mock_data.dart';
import '../../features/auth/view/login_screen.dart';
import '../../features/cart/views/cart_page.dart';
import '../../features/cart/views/my_cart.dart';
import '../../features/dashboard/view/dashboard_screen.dart';
import '../../features/footer_menu/views/a2_gir_cow_desi_ghee_page.dart';
import '../../features/footer_menu/views/faq_screen.dart';
import '../../features/home/views/home_page.dart';
import '../../features/shop/views/product_detail_page.dart';
import '../../features/shop/views/shop_page.dart';
import '../../features/wishlist/views/wishlist_screen.dart';
import 'app_route_path.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    // debugLogDiagnostics: true,
    initialLocation: AppRoutePath.cartPage,
    routes: [
      GoRoute(
        name: 'login',
        path: AppRoutePath.login,
        builder: (BuildContext context, GoRouterState state) {
          return LoginScreen();
        },
      ),

      GoRoute(
        name: 'mycart',
        path: AppRoutePath.myCart,
        builder: (BuildContext context, GoRouterState state) {
          return MyCart(cartItems: AppMockData.mockProducts);
        },
      ),
      // 🧭 MEMBER SHELL ROUTE (Main App with Bottom Nav)
      ShellRoute(
        builder: (context, state, child) {
          return DashboardScreen(child: child);
        },
        routes: [
          //Home flow
          GoRoute(
            name: 'home',
            path: AppRoutePath.homeScreen,
            builder: (BuildContext context, GoRouterState state) {
              return HomePage();
            },
          ),
          GoRoute(
            name: 'shop',
            path: AppRoutePath.shopScreen,
            builder: (BuildContext context, GoRouterState state) {
              return ShopPage();
            },
          ),
          GoRoute(
            name: 'productdetail',
            path: AppRoutePath.productDetail,
            builder: (BuildContext context, GoRouterState state) {
              return ProductDetailPage();
            },
          ),

          GoRoute(
            name: 'wishlist',
            path: AppRoutePath.wishlistScreen,
            builder: (BuildContext context, GoRouterState state) {
              return WishlistScreen();
            },
          ),

          GoRoute(
            name: 'cartPage',
            path: AppRoutePath.cartPage,
            builder: (BuildContext context, GoRouterState state) {
              return CartPage();
            },
          ),

          // Footer Menu
          GoRoute(
            name: 'faqScreen',
            path: AppRoutePath.faqScreen,
            builder: (BuildContext context, GoRouterState state) {
              return FaqScreen();
            },
          ),
          GoRoute(
            name: 'a2girCowDesiGheePage',
            path: AppRoutePath.a2girCowDesiGheePage,
            builder: (BuildContext context, GoRouterState state) {
              return A2GirCowDesiGheePage();
            },
          ),
        ],
      ),
    ],
  );
  static GoRouter get router => _router;
}
