// import 'dart:convert';
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';

// import 'package:http/http.dart' as http;

// //some problem////

// class StripeService {
//   String sk =

//   // static Map<String, dynamic>? paymentIntent;

//   // static Future<Map<String, dynamic>> createPaymentIntent(
//   //     {required String amount}) async {
//   //   try {
//   //     final double amountValue = double.parse(amount);
//   //     final int amountInSmallestUnit = (amountValue * 100).round();
//   //     final http.Response response = await http.post(
//   //       Uri.parse('https://api.stripe.com/v1/payment_intents'),
//   //       headers: <String, String>{
//   //         'Authorization': 'Bearer ${StripeService().sk}',
//   //         'Content-Type': 'application/x-www-form-urlencoded',
//   //       },
//   //       body: <String, String>{
//   //         'amount': amountInSmallestUnit.toString(),
//   //         'currency': 'INR',
//   //       },
//   //     );

//   //     final responseData = jsonDecode(response.body);
//   //     log("Payment Intent Response: $responseData");

//   //     return responseData;
//   //   } catch (e) {
//   //     print('Error occurred in createPaymentIntent: $e');
//   //     throw Exception(e.toString());
//   //   }
//   // }

//   // static Future<void> displayPaymentSheet() async {
//   //   try {
//   //     log("i am in display payment");
//   //     final res = await Stripe.instance.presentPaymentSheet();
//   //     log(res.toString());
//   //     log("i am in display payment phase 2");
//   //   } catch (e) {
//   //     print('Error occurred displayPaymentSheet: $e');
//   //     throw Exception(e.toString());
//   //   }
//   // }

//   // static Future<bool> makePayment({
//   //   required String amount,
//   // }) async {
//   //   bool success = false;
//   //   try {
//   //     log("here i am");
//   //     StripeService.paymentIntent =
//   //         await StripeService.createPaymentIntent(amount: amount);

//   //     var gpay = const PaymentSheetGooglePay(
//   //       merchantCountryCode: 'IN',
//   //       currencyCode: 'INR',
//   //       testEnv: true,
//   //     );

//   //     await Stripe.instance.initPaymentSheet(
//   //       paymentSheetParameters: SetupPaymentSheetParameters(
//   //           paymentIntentClientSecret:
//   //               StripeService.paymentIntent!['client_secret'],
//   //           googlePay: gpay,
//   //           style: ThemeMode.dark,
//   //           merchantDisplayName: "krishna"),
//   //     );

//   //     log("Init Payment Sheet done");

//   //     await displayPaymentSheet().then(
//   //       (value) {
//   //         success = true;
//   //       },
//   //     ).catchError((e) {
//   //       success = false;
//   //       print(e);
//   //     });

//   //     log("Displayed Payment Sheet");
//   //     return success;
//   //   } catch (e) {
//   //     success = false;
//   //     print('Error occurred makePayment: $e');
//   //     return success;
//   //   }
//   // }
//   static Map<String, dynamic>? paymentIntent;
//   static Future<void> makePayment() async {
//     try {
//       // Create payment intent data
//       paymentIntent = await createPaymentIntent('100', 'INR');
//       // initialise the payment sheet setup
//       await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           // Client secret key from payment data
//           paymentIntentClientSecret: paymentIntent!['client_secret'],
//           googlePay: const PaymentSheetGooglePay(
//               // Currency and country code is accourding to India
//               testEnv: true,
//               currencyCode: "INR",
//               merchantCountryCode: "IN"),
//           // Merchant Name
//           merchantDisplayName: 'krishna',
//           // return URl if you want to add
//           // returnURL: 'flutterstripe://redirect',
//         ),
//       );
//       // Display payment sheet
//       displayPaymentSheet();
//     } catch (e) {
//       print("exception $e");

//       if (e is StripeConfigException) {
//         print("Stripe exception ${e.message}");
//       } else {
//         print("exception $e");
//       }
//     }
//   }

//   static displayPaymentSheet() async {
//     try {
//       // "Display payment sheet";
//       await Stripe.instance.presentPaymentSheet();
//       // Show when payment is done
//       // Displaying snackbar for it
//       log("successfull");

//       paymentIntent = null;
//     } on StripeException catch (e) {
//       // If any error comes during payment
//       // so payment will be cancelled
//       print('Error: $e');
//       log("not successfull");
//     } catch (e) {
//       print("Error in displaying");
//       print('$e');
//     }
//   }

//   static createPaymentIntent(String amount, String currency) async {
//     try {
//       Map<String, dynamic> body = {
//         'amount': ((int.parse(amount)) * 100).toString(),
//         'currency': currency,
//         'payment_method_types[]': 'card',
//       };
//       var secretKey = StripeService().sk;
//       var response = await http.post(
//         Uri.parse('https://api.stripe.com/v1/payment_intents'),
//         headers: {
//           'Authorization': 'Bearer $secretKey',
//           'Content-Type': 'application/x-www-form-urlencoded'
//         },
//         body: body,
//       );
//       print('Payment Intent Body: ${response.body.toString()}');
//       return jsonDecode(response.body.toString());
//     } catch (err) {
//       print('Error charging user: ${err.toString()}');
//     }
//   }
// }
