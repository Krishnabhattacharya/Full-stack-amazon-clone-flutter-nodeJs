import 'dart:developer';

import 'package:amazon_clone/constant/global_variable.dart';
import 'package:amazon_clone/screens/payment/payment_details_screen.dart';
import 'package:amazon_clone/widgets/reuseable_widgets.dart/custom_button.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  static const String routeName = "/payment-screen";
  const PaymentScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? _selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
              decoration: const BoxDecoration(
            gradient: GlobalVariables.appBarGradient,
          )),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Select Payment Method',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 0,
              shape: Border.all(
                  width: 0.5, color: const Color.fromARGB(255, 203, 203, 203)),
              child: ListTile(
                title: const Text('Online payment'),
                leading: Radio<String>(
                  value: 'Credit Card',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value;
                      // Perform operations for credit card payment method
                    });
                  },
                ),
              ),
            ),
            Card(
              elevation: 0,
              shape: Border.all(
                  width: 0.5, color: const Color.fromARGB(255, 203, 203, 203)),
              child: ListTile(
                title: const Text('Cash on Delivery'),
                leading: Radio<String>(
                  value: 'Cash on Delivery',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value;
                      // Perform operations for Google Pay payment method
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: "Continue",
              onTap: () {
                log(_selectedPaymentMethod!);
                _selectedPaymentMethod == "Credit Card"
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentDetailsScreen()))
                    : ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Select online payment")));
              },
              color: GlobalVariables.secondaryColor,
            )
          ],
        ),
      ),
    );
  }
}
