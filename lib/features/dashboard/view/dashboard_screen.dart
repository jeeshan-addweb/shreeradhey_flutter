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
  int _getIndexFromLocation(String location) {
    if (location.startsWith('/shop')) return 1;
    if (location.startsWith('/deals')) return 2;
    if (location.startsWith('/cart')) return 3;
    if (location.startsWith('/menu')) return 4;
    return 0; // default to Home
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
                  _drawerItem(context, AppImages.contact, "Contact", () {}),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _getIndexFromLocation(
          GoRouterState.of(context).uri.toString(),
        ),
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
