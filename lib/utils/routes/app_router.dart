import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shree_radhey/constants/app_mock_data.dart';
import 'package:shree_radhey/features/cart/views/my_cart.dart';

import '../../features/auth/view/login_screen.dart';
import '../../features/dashboard/view/dashboard_screen.dart';
import '../../features/home/views/home_page.dart';
import '../../features/shop/views/product_detail_page.dart';
import '../../features/shop/views/shop_page.dart';
import '../../features/wishlist/views/wishlist_screen.dart';
import 'app_route_path.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    // debugLogDiagnostics: true,
    initialLocation: AppRoutePath.login,
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
        ],
      ),
    ],
  );
  static GoRouter get router => _router;
}
