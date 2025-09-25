import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shree_radhey/features/cart/controller/cart_controller.dart';
import 'package:shree_radhey/features/home/controller/home_controller.dart';

import '../../../common/components/common_footer.dart';
import '../../../constants/app_colors.dart';
import '../../home/views/widgets/product_section_widget.dart';
import 'components/cart_summary_section.dart';
import 'components/product_overview_card.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartController cartController = Get.put(CartController());
  final HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cartController.fetchCartItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final nodes =
          cartController.cart.value?.data?.cart?.contents?.nodes ?? [];
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // RichText(
                  //   text: TextSpan(
                  //     style: const TextStyle(
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.w500,
                  //     ),
                  //     children: [
                  //       TextSpan(
                  //         text: "Home",
                  //         style: TextStyle(
                  //           color: AppColors.grey_3C403D,
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //       TextSpan(
                  //         text: " / ",
                  //         style: TextStyle(
                  //           color: AppColors.red_CC0003,
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //       TextSpan(
                  //         text: "Cart",
                  //         style: TextStyle(
                  //           color: AppColors.red_CC0003,
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (cartController.isFetchingCart.value) ...[
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: SizedBox(
                              height: 36,
                              width: 36,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                      ] else if (nodes.isNotEmpty) ...[
                        ...nodes
                            .map(
                              (item) => Column(
                                children: [
                                  ProductOverviewCard(
                                    currencySymbol:
                                        cartController
                                            .cart
                                            .value
                                            ?.data
                                            ?.cart
                                            ?.currencySymbol ??
                                        "",
                                    isLoading:
                                        cartController.updatingItems[item
                                            .key!] ??
                                        false,
                                    cartTotal:
                                        cartController
                                            .cart
                                            .value!
                                            .data!
                                            .cart!
                                            .total ??
                                        "0",
                                    cartSubtotal:
                                        cartController
                                            .cart
                                            .value!
                                            .data!
                                            .cart!
                                            .subtotal ??
                                        "0",
                                    keyValue: item.key!,
                                    productName: item.product!.node!.name ?? "",
                                    quantity: item.quantity ?? 1,
                                    price: item.product!.node!.price ?? "0",
                                    imageUrl:
                                        item.product!.node!.image?.sourceUrl,
                                    onQuantityChanged:
                                        (qty) => cartController.updateQuantity(
                                          item.key!,
                                          qty,
                                        ),
                                    onRemove:
                                        () => cartController.removeItem(
                                          item.key!,
                                        ),
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            )
                            .toList(),

                        if (cartController.cart.value?.data?.cart != null)
                          CartSummarySection(
                            currencySymbol:
                                cartController
                                    .cart
                                    .value
                                    ?.data
                                    ?.cart
                                    ?.currencySymbol ??
                                "",
                            subtotal:
                                cartController
                                    .cart
                                    .value!
                                    .data!
                                    .cart!
                                    .subtotal ??
                                "0",
                            total:
                                cartController.cart.value!.data!.cart!.total ??
                                "0",
                          ),
                      ] else ...[
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text("Your cart is empty."),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 20),
                  cartController.cart.value?.data?.cart != null
                      ? SizedBox.shrink()
                      : ProductSection(
                        firstText: "",
                        firstTextColor: AppColors.black,
                        secondTextColor: AppColors.black,
                        secondText: "You May Be Interested In ...",
                        sectionBgColor: AppColors.white,
                        tagText: "Newly Launch",
                        products: controller.allProducts,
                      ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            CommonFooter(isShow: false),
          ],
        ),
      );
    });
  }
}
