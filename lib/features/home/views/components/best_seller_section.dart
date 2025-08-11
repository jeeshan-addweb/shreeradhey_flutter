// import 'package:flutter/material.dart';

// import '../../../../common/components/product_card.dart';
// import '../../../../constants/app_colors.dart';
// import '../../../../constants/app_mock_data.dart';

// class BestSellersSection extends StatefulWidget {
//   const BestSellersSection({super.key});

//   @override
//   State<BestSellersSection> createState() => _BestSellersSectionState();
// }

// class _BestSellersSectionState extends State<BestSellersSection> {
//   final ScrollController _scrollController = ScrollController();
//   bool isAtStart = true;
//   bool isAtEnd = false;

//   void scrollLeft() {
//     _scrollController.animateTo(
//       _scrollController.offset - 320,
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }

//   void scrollRight() {
//     _scrollController.animateTo(
//       _scrollController.offset + 320,
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }

//   void _scrollListener() {
//     if (!_scrollController.hasClients) return;

//     final maxScroll = _scrollController.position.maxScrollExtent;
//     final current = _scrollController.offset;

//     setState(() {
//       isAtStart = current <= 0;
//       isAtEnd = current >= maxScroll;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_scrollListener);
//   }

//   @override
//   void dispose() {
//     _scrollController.removeListener(_scrollListener);
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         // Heading
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: RichText(
//             textAlign: TextAlign.center,
//             text: TextSpan(
//               children: [
//                 TextSpan(
//                   text: "BESTSELLERS",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.red_b12704, // Or Colors.red
//                     fontStyle: FontStyle.italic,
//                     fontSize: 28,
//                   ),
//                 ),
//                 const TextSpan(
//                   text: " | PURE JOY IN EVERY PICK",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                     fontSize: 28,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         const SizedBox(height: 16),

//         // Carousel with scroll buttons
//         SizedBox(
//           height: 450,
//           child: ListView.separated(
//             controller: _scrollController,
//             scrollDirection: Axis.horizontal,
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             itemCount: AppMockData.mockProducts.length,
//             separatorBuilder: (_, __) => const SizedBox(width: 12),
//             itemBuilder: (context, index) {
//               final product = AppMockData.mockProducts[index];
//               return SizedBox(width: 270, child: ProductCard(model: product));
//             },
//           ),
//         ),
//         SizedBox(height: 16),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(color: Colors.grey.shade400),
//               ),
//               child: IconButton(
//                 icon: const Icon(Icons.arrow_back_ios, size: 18),
//                 onPressed: isAtStart ? null : scrollLeft,
//               ),
//             ),
//             const SizedBox(width: 16),
//             Container(
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(color: Colors.grey.shade400),
//               ),
//               child: IconButton(
//                 icon: const Icon(Icons.arrow_forward_ios, size: 18),
//                 onPressed: isAtEnd ? null : scrollRight,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
