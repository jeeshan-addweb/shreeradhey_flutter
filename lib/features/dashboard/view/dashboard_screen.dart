import 'package:flutter/material.dart';

import '../../../common/components/custom_app_bar.dart';
import '../../../common/components/custom_bottom_navigation_bar.dart';
import '../../../constants/app_images.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/routes/app_route_path.dart';

class DashboardScreen extends StatefulWidget {
  final Widget child;
  const DashboardScreen({super.key, required this.child});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _getIndexFromLocation(BuildContext context) {
    final uri = GoRouterState.of(context).uri.toString();
    final extra = GoRouterState.of(context).extra;
    if (uri.startsWith('/shop')) {
      if (extra is int) {
        if (extra == 5) return 2;
        return 1;
      }
      return 1;
    }
    if (uri.startsWith('/cart')) return 3;
    if (uri.startsWith('/menu')) return 4;
    return 0;
  }

  bool _isDrawerOpen = false;

  void _toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    const double topBarHeight = kToolbarHeight + 90; // matches your app bar
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          /// Main column layout
          Column(
            children: [
              CustomAppBar(
                isDrawerOpen: _isDrawerOpen,
                onMenuTap: _toggleDrawer,
              ),
              Expanded(child: widget.child),
            ],
          ),

          /// Custom sliding drawer
          AnimatedPositioned(
            duration: Duration(milliseconds: 250),
            top: topBarHeight,
            left: _isDrawerOpen ? 0 : -250, // hide when closed
            bottom: 0,
            child: Container(
              width: 250,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _drawerItem(
                    context,
                    AppImages.best_seller,
                    "Best Sellers",
                    () {},
                  ),
                  _drawerItem(context, AppImages.ghee, "A2 Ghee", () {
                    context.push(AppRoutePath.a2girCowDesiGheePage);
                  }),
                  _drawerItem(context, AppImages.oil, "Wood Pressed Oils", () {
                    context.push(AppRoutePath.woodpressedoilScreen);
                  }),
                  _drawerItem(context, AppImages.shop, "Shop", () {}),
                  _drawerItem(context, AppImages.contact, "Contact", () {
                    context.push(AppRoutePath.contactUsScreen);
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _getIndexFromLocation(context),
        onTap: (index) {
          switch (index) {
            case 0:
              context.go(AppRoutePath.homeScreen);
              break;
            case 1:
              context.go(AppRoutePath.shopScreen, extra: 0); // Shop
              break;
            case 2:
              context.go(AppRoutePath.shopScreen, extra: 5); // Deals
              break;
            case 3:
              context.go(AppRoutePath.cartPage);
              break;
            case 4:
              // context.go(AppRoutePath.moreScreen);
              break;
          }
        },
      ),
    );
  }

  Widget _drawerItem(
    BuildContext context,
    String icon,
    String title,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Image.asset(icon, height: 23, width: 23),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
      onTap: () {
        setState(() {
          _isDrawerOpen = false;
        });
        onTap();
      },
    );
  }
}
