import 'package:flutter/material.dart';
import '../../../../constants/app_colors.dart';

class PaymentMethodCard extends StatefulWidget {
  final Function(String paymentMethod)? onPlaceOrder;
  final bool isLoading;
  const PaymentMethodCard({
    super.key,
    this.onPlaceOrder,
    this.isLoading = false,
  });

  @override
  State<PaymentMethodCard> createState() => _PaymentMethodCardState();
}

class _PaymentMethodCardState extends State<PaymentMethodCard> {
  String _selectedPayment = "cod";
  bool _termsAccepted = false;
  bool _captcha = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.blue_eef1ed,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Razorpay
            RadioListTile<String>(
              dense: true,
              visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
              contentPadding: EdgeInsets.zero,
              value: "razorpay",
              groupValue: _selectedPayment,
              onChanged: (val) {
                setState(() => _selectedPayment = val!);
              },
              title: const Text("Razorpay Payment"),
            ),

            Row(
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.account_balance_wallet),
                  color: Colors.blue,
                  onPressed: () {},
                ),
                SizedBox(width: 8),
                Text("Pay by Razorpay"),
              ],
            ),

            // Cash on Delivery
            RadioListTile<String>(
              dense: true,
              visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
              contentPadding: EdgeInsets.zero,
              value: "cod",
              groupValue: _selectedPayment,
              onChanged: (val) {
                setState(() => _selectedPayment = val!);
              },
              title: const Text("Cash on delivery"),
            ),

            // Divider
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Divider(thickness: 1, height: 20),
            ),

            // Info text
            Text(
              "Your personal data will be used to process your order, support your experience throughout this website, and for other purposes described in our privacy policy.",
              style: TextStyle(fontSize: 13, color: AppColors.grey_212121),
            ),

            const SizedBox(height: 12),

            // Terms & conditions
            Row(
              children: [
                Transform.scale(
                  scale: 0.8,
                  child: Checkbox(
                    value: _termsAccepted,
                    onChanged: (val) {
                      setState(() => _termsAccepted = val ?? false);
                    },
                  ),
                ),
                const Expanded(
                  child: Text(
                    "I have read and agree to the website terms and conditions",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Captcha placeholder
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Transform.scale(
                    scale: 1.1, // same size as T&C checkbox
                    child: Checkbox(
                      value: _captcha,
                      onChanged: (val) {
                        setState(() => _captcha = val ?? false);
                      },
                    ),
                  ),
                  const Text(
                    "Verify you are human",
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Place Order button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.green,
                ),
                onPressed:
                    (_termsAccepted && _captcha)
                        ? () {
                          widget.onPlaceOrder?.call(_selectedPayment);
                        }
                        : null,
                child:
                    widget.isLoading
                        ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                        : const Text("Place order"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
