import 'package:flutter/material.dart';

class CustomSnackbars {
  static void showError(BuildContext context, String message) {
    _showSnackBar(context, message, backgroundColor: Colors.red.shade600);
  }

  static void showSuccess(BuildContext context, String message) {
    _showSnackBar(context, message, backgroundColor: Colors.green.shade600);
  }

  static void _showSnackBar(
    BuildContext context,
    String message, {
    required Color backgroundColor,
  }) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      duration: const Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
