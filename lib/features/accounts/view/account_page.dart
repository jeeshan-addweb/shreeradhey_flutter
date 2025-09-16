import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/app_colors.dart';
import '../../../utils/routes/app_route_path.dart';
import '../../auth/controller/auth_controller.dart';
import 'accounts_detail_page.dart';
import 'address_screen.dart';
import 'dashboard_page.dart';
import 'order_page.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> accountTabs = [
    {"title": "Dashboard", "icon": Icons.dashboard},
    {"title": "Orders", "icon": Icons.shopping_bag},
    {"title": "Addresses", "icon": Icons.location_on},
    {"title": "Account details", "icon": Icons.person},
    // {"title": "Rewards Points", "icon": Icons.card_giftcard},
    {"title": "Log out", "icon": Icons.logout},
  ];

  final List<Widget> accountScreens = [
    DashboardPage(),
    OrderPage(),
    AddressScreen(),
    AccountDetailsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header strip
          SizedBox(height: 20, child: Container(color: AppColors.blue_eef1ed)),

          // Top horizontal tabs
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: AppColors.blue_eef1ed,
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: accountTabs.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final tab = accountTabs[index];
                final bool isSelected = selectedIndex == index;

                return GestureDetector(
                  onTap: () async {
                    if (tab["title"] == "Log out") {
                      final shouldLogout = await showDialog<bool>(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              title: const Text("Confirm Logout ??"),
                              content: const Text(
                                "Are you sure you want to log out?",
                              ),
                              actions: [
                                TextButton(
                                  onPressed:
                                      () => Navigator.of(context).pop(false),
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(color: AppColors.black),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed:
                                      () => Navigator.of(context).pop(true),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.green_327801,
                                  ),
                                  child: Text(
                                    "Yes, Logout",
                                    style: TextStyle(color: AppColors.white),
                                  ),
                                ),
                              ],
                            ),
                      );

                      if (shouldLogout == true) {
                        // clear storage & go to login
                        final authController = Get.find<AuthController>();
                        await authController.logout();

                        if (mounted) {
                          context.go(AppRoutePath.login);
                        }
                      }
                    } else {
                      setState(() {
                        selectedIndex = index;
                      });
                    }
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        width: 100,
                        decoration: BoxDecoration(
                          color:
                              isSelected ? Colors.green.shade100 : Colors.white,
                          border: Border.all(
                            color:
                                isSelected
                                    ? Colors.green
                                    : Colors.grey.shade300,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              tab["icon"],
                              color: isSelected ? Colors.green : Colors.grey,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              tab["title"],
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? Colors.green : Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // Selected content fills remaining space
          Expanded(child: accountScreens[selectedIndex]),
        ],
      ),
    );
  }
}
