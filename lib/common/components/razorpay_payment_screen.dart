import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayPaymentScreen extends StatefulWidget {
  final double amount; // in INR (Razorpay expects paise, so multiply by 100)
  final String name;
  final String email;
  final String phone;
  final Function(String paymentId)? onSuccess; // callback after success

  const RazorpayPaymentScreen({
    super.key,
    required this.amount,
    required this.name,
    required this.email,
    required this.phone,
    this.onSuccess,
  });

  @override
  State<RazorpayPaymentScreen> createState() => _RazorpayPaymentScreenState();
}

class _RazorpayPaymentScreenState extends State<RazorpayPaymentScreen> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    _openCheckout();
  }

  void _openCheckout() {
    var options = {
      'key': 'rzp_test_xxxxxxxxxxxx', // replace with your Razorpay key
      'amount': (widget.amount * 100).toInt(), // Razorpay expects paise
      'name': 'Your Shop',
      'description': 'Order Payment',
      'prefill': {'contact': widget.phone, 'email': widget.email},
      'external': {
        'wallets': ['paytm'],
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Payment successful
    widget.onSuccess?.call(response.paymentId ?? "");
    Navigator.pop(context, response.paymentId); // return to previous screen
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment failed: ${response.message}")),
    );
    Navigator.pop(context);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("External wallet selected: ${response.walletName}"),
      ),
    );
  }

  @override
  void dispose() {
    _razorpay.clear(); // clear all listeners
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // No UI needed, Razorpay popup will open directly
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
