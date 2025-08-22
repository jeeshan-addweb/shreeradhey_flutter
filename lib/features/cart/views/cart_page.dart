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
                Text(
                  "Home / Cart}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.red, // like your design's breadcrumb
                  ),
                ),

                ProductSection(
                  firstText: "",
                  firstTextColor: AppColors.black,
                  secondTextColor: AppColors.black,
                  secondText: "You May Be Interested In ...",
                  sectionBgColor: AppColors.white,
                  tagText: "Newly Launch",
                ),

                ProductOverviewCard(),
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
