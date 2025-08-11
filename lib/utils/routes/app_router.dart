import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/view/login_screen.dart';
import '../../features/dashboard/view/dashboard_screen.dart';
import '../../features/home/views/home_page.dart';
import '../../features/shop/views/product_detail_page.dart';
import '../../features/shop/views/shop_page.dart';
import 'app_route_path.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    // debugLogDiagnostics: true,
    initialLocation: AppRoutePath.homeScreen,
    routes: [
      GoRoute(
        name: 'login',
        path: AppRoutePath.login,
        builder: (BuildContext context, GoRouterState state) {
          return LoginScreen();
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
        ],
      ),
    ],
  );
  static GoRouter get router => _router;
}
