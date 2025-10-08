import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shree_radhey/features/accounts/controller/account_controller.dart';

class RazorpayPaymentScreen extends StatefulWidget {
  final double amount;
  final String name;
  final String email;
  final String phone;
  final Function(String paymentId)? onSuccess;

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
  final AccountController _accountController = Get.put(AccountController());

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _openCheckout();
    });
  }

  void _openCheckout() {
    var options = {
      'key': 'rzp_test_ROvWxWrNZH8K21',
      'amount': (widget.amount * 100).toInt(),
      'name': widget.name,
      'description': "Order Payment of ₹${widget.amount}",
      'prefill': {'contact': widget.phone, 'email': widget.email},
      'external': {
        'wallets': ['paytm'],
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint("Razorpay open error print: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Payment could not start. Try again after some time"),
        ),
      );
      Navigator.pop(context);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    final paymentId = response.paymentId ?? "";
    widget.onSuccess?.call(paymentId);

    final result = await _accountController.verifyTransaction(
      context,
      transactionId: paymentId,
      provider: "razorpay",
    );

    Navigator.pop(context, {
      'status': 'success',
      'paymentId': response.paymentId,
      // 'verification': result,
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Payment failed due to technical issues: ${response.message}",
        ),
      ),
    );
    Navigator.pop(context, {'status': 'error', 'message': response.message});
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("External wallet selected as :) ${response.walletName}"),
      ),
    );
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
