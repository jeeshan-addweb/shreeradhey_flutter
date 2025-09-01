import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shree_radhey/features/accounts/view/order_detail_screen.dart';

import '../../constants/app_mock_data.dart';
import '../../features/accounts/model/order_model.dart';
import '../../features/accounts/view/account_page.dart';
import '../../features/auth/view/login_screen.dart';
import '../../features/auth/view/otp_screen.dart';
import '../../features/cart/views/cart_page.dart';
import '../../features/cart/views/checkout_screen.dart';
import '../../features/cart/views/my_cart.dart';
import '../../features/dashboard/view/dashboard_screen.dart';
import '../../features/deals/views/deals_screen.dart';
import '../../features/footer_menu/views/a2_gir_cow_desi_ghee_page.dart';
import '../../features/footer_menu/views/about_us_page.dart';
import '../../features/footer_menu/views/best_seller_screen.dart';
import '../../features/footer_menu/views/blog_detail_screen.dart';
import '../../features/footer_menu/views/blog_listing_screen.dart';
import '../../features/footer_menu/views/contact_us_screen.dart';
import '../../features/footer_menu/views/dealership_form_screen.dart';
import '../../features/footer_menu/views/faq_screen.dart';
import '../../features/footer_menu/views/privacy_policy_page.dart';
import '../../features/footer_menu/views/refund_policy_page.dart';
import '../../features/footer_menu/views/shipping_and_delivery_policy_page.dart';
import '../../features/footer_menu/views/terms_and_condition_page.dart';
import '../../features/footer_menu/views/wood_pressed_oil_screen.dart';
import '../../features/home/model/blog_model.dart';
import '../../features/home/views/home_page.dart';
import '../../features/shop/views/product_detail_page.dart';
import '../../features/shop/views/shop_page.dart';
import '../../features/wishlist/views/wishlist_screen.dart';
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
      GoRoute(
        name: 'otpScreen',
        path: AppRoutePath.otpScreen,
        builder: (BuildContext context, GoRouterState state) {
          final contact = state.extra as String;
          return OtpScreen(contact: contact);
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
          final extra = state.extra;
          bool hideNav = false;

          if (extra is Map<String, dynamic>) {
            hideNav = extra['hideNav'] == true;
          }
          return DashboardScreen(child: child, showBottomNav: !hideNav);
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
            name: 'deals',
            path: AppRoutePath.dealsScreen,
            builder: (BuildContext context, GoRouterState state) {
              return DealsScreen();
            },
          ),
          GoRoute(
            name: 'productdetail',
            path: AppRoutePath.productDetail,
            builder: (BuildContext context, GoRouterState state) {
              final slug = (state.extra as Map)['slug'] as String;
              return ProductDetailPage(slug: slug);
            },
          ),

          // GoRoute(
          //   name: 'productdetail',
          //   path: AppRoutePath.productDetail,
          //   builder: (BuildContext context, GoRouterState state) {
          //     final slug = state.extra as String; // cast properly
          //     return ProductDetailPage(slug: slug);
          //   },
          // ),
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

          GoRoute(
            name: 'checkoutScreen',
            path: AppRoutePath.checkoutScreen,
            builder: (BuildContext context, GoRouterState state) {
              return CheckoutScreen();
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
          GoRoute(
            name: 'woodpressedoilScreen',
            path: AppRoutePath.woodpressedoilScreen,
            builder: (BuildContext context, GoRouterState state) {
              return WoodPressedOilScreen();
            },
          ),
          GoRoute(
            name: 'dealershipFormScreen',
            path: AppRoutePath.dealershipFormScreen,
            builder: (BuildContext context, GoRouterState state) {
              return DealershipFormScreen();
            },
          ),
          GoRoute(
            name: 'contactUsScreen',
            path: AppRoutePath.contactUsScreen,
            builder: (BuildContext context, GoRouterState state) {
              return ContactUsScreen();
            },
          ),
          GoRoute(
            name: 'aboutUsPage',
            path: AppRoutePath.aboutUsPage,
            builder: (BuildContext context, GoRouterState state) {
              return AboutUsPage();
            },
          ),
          GoRoute(
            name: 'refundPolicyPage',
            path: AppRoutePath.refundPolicyPage,
            builder: (BuildContext context, GoRouterState state) {
              return RefundPolicyPage();
            },
          ),
          GoRoute(
            name: 'bestSellerScreen',
            path: AppRoutePath.bestSellerScreen,
            builder: (BuildContext context, GoRouterState state) {
              return BestSellerScreen();
            },
          ),
          GoRoute(
            name: 'privacyPolicyPage',
            path: AppRoutePath.privacyPolicyPage,
            builder: (BuildContext context, GoRouterState state) {
              return PrivacyPolicyPage();
            },
          ),
          GoRoute(
            name: 'termsAndConditionsPage',
            path: AppRoutePath.termsAndConditionsPage,
            builder: (BuildContext context, GoRouterState state) {
              return TermsAndConditionPage();
            },
          ),
          GoRoute(
            name: 'shippingAndDeliveryPolicyPage',
            path: AppRoutePath.shippingAndDeliveryPolicyPage,
            builder: (BuildContext context, GoRouterState state) {
              return ShippingAndDeliveryPolicyPage();
            },
          ),
          GoRoute(
            name: 'bloglistingScreen',
            path: AppRoutePath.bloglistingScreen,
            builder: (BuildContext context, GoRouterState state) {
              return BlogListingScreen();
            },
          ),
          GoRoute(
            path: AppRoutePath.blogdetailScreen,
            builder: (context, state) {
              final blog = state.extra as BlogModel;

              return BlogDetailScreen(model: blog);
            },
          ),

          // Accounts
          GoRoute(
            name: 'accountPage',
            path: AppRoutePath.accountPage,
            builder: (BuildContext context, GoRouterState state) {
              return AccountPage();
            },
          ),
          GoRoute(
            name: 'orderDetailScreen',
            path: AppRoutePath.orderDetailScreen,
            builder: (BuildContext context, GoRouterState state) {
              final order = state.extra as OrderModel; // 👈 retrieve model
              return OrderDetailScreen(order: order);
            },
          ),
        ],
      ),
    ],
  );
  static GoRouter get router => _router;
}
