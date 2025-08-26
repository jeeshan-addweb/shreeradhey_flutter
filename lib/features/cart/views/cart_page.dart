import 'package:flutter/material.dart';

import '../../../common/components/common_footer.dart';
import '../../../constants/app_colors.dart';
import '../../home/views/widgets/product_section_widget.dart';
import 'components/product_overview_card.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // so text aligns like your design
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: "Home",
                        style: TextStyle(
                          color: AppColors.grey_3C403D,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: " / ",
                        style: TextStyle(
                          color: AppColors.red_CC0003,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "Cart",
                        style: TextStyle(
                          color: AppColors.red_CC0003,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ProductOverviewCard(),
                SizedBox(height: 20),
                ProductSection(
                  firstText: "",
                  firstTextColor: AppColors.black,
                  secondTextColor: AppColors.black,
                  secondText: "You May Be Interested In ...",
                  sectionBgColor: AppColors.white,
                  tagText: "Newly Launch",
                ),

                // ProductOverviewCard(),
                SizedBox(height: 20),
              ],
            ),
          ),

          CommonFooter(isShow: false),
        ],
      ),
    );
  }
}
