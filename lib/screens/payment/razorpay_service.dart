import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayService {
  static final Razorpay _razorpay = Razorpay();

  static Future<void> initRazorPay({
    required Function(PaymentFailureResponse) onError,
    required Function(PaymentSuccessResponse) onSuccess,
    required Function(ExternalWalletResponse) onExternalWallet,
  }) async {
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, onError);
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, onSuccess);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, onExternalWallet);
  }

  static void openCheckout(String amount, BuildContext context) {
    var options = {
      "key": "rzp_test_wY2KNQ4FkcXrqo",
      "amount": num.parse(amount) * 100,
      "name": "test",
      "description": " this is the test payment",
      "timeout": "180",
      "currency": "INR",
      "prefill": {
        "contact": "11111111111",
        "email": "test@abc.com",
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
        backgroundColor: Colors.red,
      ));
    }
  }

  static void clear() {
    _razorpay.clear();
  }
}
