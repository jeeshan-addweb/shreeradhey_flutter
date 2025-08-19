import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
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
    {"title": "Rewards Points", "icon": Icons.card_giftcard},
    {"title": "Log out", "icon": Icons.logout},
  ];

  final List<Widget> accountScreens = [
    // DashboardPage(),
    // OrderPage(),
    Center(child: Text("Dashboard Screen")),
    Center(child: Text("Order Screen")),
    Center(child: Text("Addresses Screen")),
    Center(child: Text("Account Details Screen")),
    Center(child: Text("Rewards Points Screen")),
    Center(child: Text("Log out Screen")),
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
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
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
