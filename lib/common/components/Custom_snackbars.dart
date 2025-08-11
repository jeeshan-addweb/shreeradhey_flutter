import '../../constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackBar {
  static void snackBarPrimary({
    required BuildContext context,
    required String title,
    String? subtitle,
    Color? color,
    double? bordeRadius,
    EdgeInsets? margin,
    SnackStyle? snackStyle,
    SnackPosition? snackPosition,
  }) {
    // This should be called by an on pressed function
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          title,
          style: TextStyle(color: Colors.white), // font color
        ),
        backgroundColor: AppColors.orange_fe9f43, // background color
        behavior: SnackBarBehavior.floating, // optional: makes it float
        shape: RoundedRectangleBorder(       // optional: adds rounded corners
          borderRadius: BorderRadius.circular(8),
        ),
        duration: Duration(seconds: 3),
      ),
    );


  }

  static void snackBarError(
      {required BuildContext context,
      required String errorText,
      Color? color,
      double? bordeRadius,
      EdgeInsets? margin,
      SnackStyle? snackStyle,
      SnackPosition? snackPosition,
      Widget? icon}) {
    // This should be called by an on pressed function
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          errorText,
          style: TextStyle(color: Colors.white), // font color
        ),
        backgroundColor: AppColors.red_ef4444, // background color
        behavior: SnackBarBehavior.floating, // optional: makes it float
        shape: RoundedRectangleBorder(       // optional: adds rounded corners
          borderRadius: BorderRadius.circular(8),
        ),
        duration: Duration(seconds: 3),
      ),
    );

  }

  static void snackBar(Color backgroundColor, Color textColor, String message) {
    // Get.snackbar(
    //   "", // No default title
    //   message, // No default message
    //   padding: EdgeInsets.all(0), // No extra padding
    //   backgroundColor: backgroundColor,
    //   snackPosition: SnackPosition.TOP,
    //   colorText: textColor,
    //   titleText: Container(
    //     // optional: control height of snackbar
    //     alignment: Alignment.centerLeft,
    //     child: Text(
    //       message,
    //       textAlign: TextAlign.start,
    //       style: TextStyle(
    //         color: AppColors.white,
    //         fontSize: 16,
    //         fontWeight: FontWeight.w500,
    //       ),
    //     ),
    //   ),
    //   messageText: null, // ensures no extra space for subtitle
    // );
    Get.rawSnackbar(
      message: message,
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: backgroundColor,
      margin: EdgeInsets.symmetric(horizontal: 0),
      borderRadius: 12,
      duration: Duration(seconds: 2),
      isDismissible: true,
      snackPosition: SnackPosition.TOP,
      forwardAnimationCurve: Curves.easeOut,
      animationDuration: Duration(milliseconds: 300),
      messageText: Text(
        message,
        style: TextStyle(color: textColor, fontSize: 14),
        textAlign: TextAlign.start,
      ),
    );
  }
}
