import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/model/ui_product_model.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../utils/routes/app_route_path.dart';
import 'widgets/build_better_choice_section.dart';
import 'widgets/build_cart_item.dart';
import 'widgets/build_offer_card.dart';

class MyCart extends StatelessWidget {
  final List<UiProductModel> cartItems;

  const MyCart({super.key, required this.cartItems});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.blue_eef1ed,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              // Price
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Text(
                  "₹4300.00",
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              // Button takes rest of the space
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.green_6cad10, AppColors.green_327801],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,

        title: const Text(
          "Your Cart",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close, size: 28, color: AppColors.grey_212121),
            onPressed: () => context.go(AppRoutePath.homeScreen),
          ),
        ],
      ),
      body: Column(
        children: [
          // Fixed Banner
          Image.asset(
            AppImages.product_page_image,
            width: double.infinity,
            height: 180,
            fit: BoxFit.cover,
          ),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),

                  // Cart Items
                  ...cartItems.map((item) => buildCartItem(item)).toList(),

                  const SizedBox(height: 20),

                  // Offers Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Available Offers For You",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.grey_212121,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  buildOfferCard(
                    "Warm up your shopping cart with SHREE15",
                    "SHREE15",
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Big Deals on Better Choices!",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        foreground:
                            Paint()
                              ..shader = LinearGradient(
                                colors: [Color(0xFF327800), Color(0xFFE51900)],
                              ).createShader(
                                const Rect.fromLTWH(0, 0, 200, 70),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 250, // Adjust according to your card height
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: cartItems.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return buildBetterChoiceSection(
                          item,
                          context,
                        ); // your existing card builder
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildCartItem(ProductModel item) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //     child: Padding(
  //       padding: const EdgeInsets.all(12),
  //       child: Row(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           // Product Image
  //           ClipRRect(
  //             borderRadius: BorderRadius.circular(8),
  //             child: Image.asset(
  //               item.imageUrl,
  //               width: 100,
  //               height: 100,
  //               fit: BoxFit.cover,
  //             ),
  //           ),
  //           const SizedBox(width: 12),

  //           // Product Info
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   item.title,
  //                   style: const TextStyle(
  //                     fontSize: 16,
  //                     fontWeight: FontWeight.w700,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 4),
  //                 Text(
  //                   item.subtitle,
  //                   style: const TextStyle(
  //                     fontSize: 14,
  //                     color: Colors.grey,
  //                     fontWeight: FontWeight.w600,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 4),
  //                 Row(
  //                   children: [
  //                     Icon(
  //                       Icons.star,
  //                       color: AppColors.orange_f29102,
  //                       size: 16,
  //                     ),
  //                     const SizedBox(width: 4),
  //                     Text(
  //                       "${item.rating}",
  //                       style: TextStyle(
  //                         fontSize: 14,
  //                         fontWeight: FontWeight.w400,
  //                         color: AppColors.grey_212121,
  //                       ),
  //                     ),
  //                     const SizedBox(width: 4),
  //                     Text(
  //                       "| ${item.reviewCount} Reviews",
  //                       style: TextStyle(
  //                         fontSize: 14,
  //                         fontWeight: FontWeight.w400,
  //                         color: AppColors.grey_212121,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 4),
  //                 Row(
  //                   children: [
  //                     Text(
  //                       "₹${item.price}",
  //                       style: TextStyle(
  //                         fontSize: 20,
  //                         color: AppColors.blue_2da5f3,
  //                         fontWeight: FontWeight.w700,
  //                       ),
  //                     ),
  //                     const SizedBox(width: 6),
  //                     Text(
  //                       "₹${item.oldPrice}",
  //                       style: const TextStyle(
  //                         fontSize: 14,

  //                         decoration: TextDecoration.lineThrough,
  //                       ),
  //                     ),
  //                     const SizedBox(width: 6),
  //                   ],
  //                 ),
  //                 Text(
  //                   "(${item.discountPercent?.toStringAsFixed(0)}%)",
  //                   style: TextStyle(
  //                     fontSize: 14,
  //                     color: AppColors.grey_212121,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 4),
  //                 Row(
  //                   children: [
  //                     Text(
  //                       'Best Price \$${item.couponPrice.toStringAsFixed(0)}',
  //                       style: TextStyle(
  //                         color: AppColors.green_327801,
  //                         fontWeight: FontWeight.w600,
  //                         fontSize: 16,
  //                       ),
  //                     ),
  //                     const SizedBox(width: 4),
  //                     Text(
  //                       'with coupon',
  //                       style: TextStyle(
  //                         color: AppColors.grey_212121,
  //                         fontSize: 16,
  //                       ),
  //                     ),
  //                   ],
  //                 ),

  //                 const SizedBox(height: 8),

  //                 // Quantity + Delete
  //                 Row(
  //                   children: [
  //                     Container(
  //                       decoration: BoxDecoration(
  //                         border: Border.all(color: Colors.grey.shade300),
  //                         borderRadius: BorderRadius.circular(4),
  //                       ),
  //                       child: Row(
  //                         children: [
  //                           IconButton(
  //                             icon: const Icon(Icons.remove, size: 18),
  //                             onPressed: () {},
  //                           ),

  //                           const Text("1"),
  //                           IconButton(
  //                             icon: const Icon(Icons.add, size: 18),
  //                             onPressed: () {},
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     const Spacer(),
  //                     IconButton(
  //                       icon: Icon(
  //                         Icons.delete_outline_outlined,
  //                         color: AppColors.red_CC0003,
  //                       ),
  //                       onPressed: () {},
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildBetterChoiceSection(ProductModel item, BuildContext context) {
  //   double cardWidth = MediaQuery.of(context).size.width * 0.95;
  //   return Container(
  //     width: cardWidth,
  //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         // Product Image
  //         ClipRRect(
  //           borderRadius: BorderRadius.circular(8),
  //           child: Image.asset(
  //             item.imageUrl,
  //             width: 100,
  //             height: 100,
  //             fit: BoxFit.cover,
  //           ),
  //         ),
  //         const SizedBox(width: 12),

  //         // Product Info
  //         Flexible(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 item.title,
  //                 style: const TextStyle(
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.w700,
  //                 ),
  //               ),
  //               const SizedBox(height: 4),
  //               Text(
  //                 item.subtitle,
  //                 style: const TextStyle(
  //                   fontSize: 14,
  //                   color: Colors.grey,
  //                   fontWeight: FontWeight.w600,
  //                 ),
  //               ),
  //               const SizedBox(height: 4),
  //               Row(
  //                 children: [
  //                   Icon(Icons.star, color: AppColors.orange_f29102, size: 16),
  //                   const SizedBox(width: 4),
  //                   Text(
  //                     "${item.rating}",
  //                     style: TextStyle(
  //                       fontSize: 14,
  //                       fontWeight: FontWeight.w400,
  //                       color: AppColors.grey_212121,
  //                     ),
  //                   ),
  //                   const SizedBox(width: 4),
  //                   Text(
  //                     "| ${item.reviewCount} Reviews",
  //                     style: TextStyle(
  //                       fontSize: 14,
  //                       fontWeight: FontWeight.w400,
  //                       color: AppColors.grey_212121,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(height: 4),
  //               Row(
  //                 children: [
  //                   Text(
  //                     "₹${item.price}",
  //                     style: TextStyle(
  //                       fontSize: 20,
  //                       color: AppColors.blue_2da5f3,
  //                       fontWeight: FontWeight.w700,
  //                     ),
  //                   ),
  //                   const SizedBox(width: 6),
  //                   Text(
  //                     "₹${item.oldPrice}",
  //                     style: const TextStyle(
  //                       fontSize: 14,

  //                       decoration: TextDecoration.lineThrough,
  //                     ),
  //                   ),
  //                   const SizedBox(width: 6),
  //                 ],
  //               ),
  //               Text(
  //                 "(${item.discountPercent?.toStringAsFixed(0)}%)",
  //                 style: TextStyle(fontSize: 14, color: AppColors.grey_212121),
  //               ),
  //               const SizedBox(height: 4),
  //               Row(
  //                 children: [
  //                   Text(
  //                     'Best Price \$${item.couponPrice.toStringAsFixed(0)}',
  //                     style: TextStyle(
  //                       color: AppColors.green_327801,
  //                       fontWeight: FontWeight.w600,
  //                       fontSize: 15,
  //                     ),
  //                   ),
  //                   const SizedBox(width: 4),
  //                   Text(
  //                     'with coupon',
  //                     style: TextStyle(
  //                       color: AppColors.grey_212121,
  //                       fontSize: 15,
  //                     ),
  //                   ),
  //                   SizedBox(width: 5),
  //                   GestureDetector(
  //                     onTap: () {
  //                       // TODO: Handle coupon apply action
  //                     },
  //                     child: Container(
  //                       padding: const EdgeInsets.symmetric(
  //                         vertical: 5,
  //                         horizontal: 20,
  //                       ),
  //                       decoration: BoxDecoration(
  //                         gradient: LinearGradient(
  //                           colors: [
  //                             AppColors.green_6cad10,
  //                             AppColors.green_327801,
  //                           ],
  //                           begin: Alignment.topCenter,
  //                           end: Alignment.bottomCenter,
  //                         ),
  //                         borderRadius: BorderRadius.circular(8),
  //                       ),
  //                       child: const Center(
  //                         child: Text(
  //                           "Add",
  //                           style: TextStyle(
  //                             color: Colors.white,
  //                             fontWeight: FontWeight.w600,
  //                             fontSize: 16,
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),

  //               const SizedBox(height: 8),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  //   Widget _buildOfferCard(String offerText, String couponCode) {
  //     return Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 30),
  //       child: Container(
  //         decoration: BoxDecoration(color: AppColors.pink_fffced),

  //         child: Padding(
  //           padding: const EdgeInsets.all(12),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 offerText,
  //                 style: const TextStyle(
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.w700,
  //                 ),
  //               ),
  //               const SizedBox(height: 8),
  //               Container(
  //                 // width: double.infinity,
  //                 padding: const EdgeInsets.symmetric(
  //                   horizontal: 16,
  //                   vertical: 6,
  //                 ),
  //                 decoration: BoxDecoration(
  //                   border: Border.all(color: Colors.green),
  //                   borderRadius: BorderRadius.circular(6),
  //                   color: Colors.white,
  //                 ),
  //                 child: Row(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     Text(
  //                       couponCode,
  //                       style: const TextStyle(
  //                         fontWeight: FontWeight.w700,
  //                         fontSize: 16,
  //                       ),
  //                     ),
  //                     const SizedBox(width: 6),
  //                     const Icon(Icons.copy_sharp, size: 16, color: Colors.green),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  // }
}
