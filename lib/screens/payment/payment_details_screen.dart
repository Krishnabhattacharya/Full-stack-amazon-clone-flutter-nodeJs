import 'dart:developer';

import 'package:amazon_clone/constant/global_variable.dart';
import 'package:amazon_clone/screens/home/home_screen.dart';
import 'package:amazon_clone/screens/payment/razorpay_service.dart';
import 'package:amazon_clone/screens/payment/stripe_service.dart';
import 'package:amazon_clone/services/ApiServices/ApiServices.dart';
import 'package:amazon_clone/services/SharedServices/Sharedservices.dart';
import 'package:amazon_clone/services/provider/auth_provider.dart';
import 'package:amazon_clone/widgets/reuseable_widgets.dart/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentDetailsScreen extends StatefulWidget {
  const PaymentDetailsScreen({
    Key? key,
  });

  @override
  State<PaymentDetailsScreen> createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
  int sum = 0;
  @override
  void initState() {
    super.initState();
    RazorpayService.initRazorPay(
      onError: (error) {
        print("Payment Error: ${error.message}");
      },
      onSuccess: (success) async {
        await Apiservices.placeOrder(
            address: Provider.of<AuthProvider>(context, listen: false)
                .loginmodel!
                .address!,
            context: context,
            price: sum);
        Navigator.pushReplacementNamed(context, HomePage.routeName);
      },
      onExternalWallet: (wallet) {
        print("External Wallet: ${wallet.walletName}");
      },
    );
    price();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    RazorpayService.clear();
  }

  void price() {
    Provider.of<AuthProvider>(context, listen: false)
        .loginmodel!
        .cart!
        .map((e) => sum += (e.cartQuantity)! * (e.product!.price)!)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
              decoration: const BoxDecoration(
            gradient: GlobalVariables.appBarGradient,
          )),
        ),
      ),
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Order Now',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 23),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 200,
                width: 370,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: const Color.fromARGB(255, 207, 207, 207)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Shipping to :',
                        style: const TextStyle(fontSize: 17),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              (SharedServices.getLoginDetails()!.user!.name)!
                                  .split(' ')[0],
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            flex: 8,
                            child: Text(
                              " - ${SharedServices.getLoginDetails()!.user!.address}",
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Color.fromARGB(255, 218, 218, 218),
                      ),
                      Row(
                        //crossAxisAlignment: ,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.0),
                                child: Text("Items:",
                                    style: TextStyle(
                                      fontSize: 17,
                                    )),
                              ),
                              Text("Delivery:",
                                  style: TextStyle(
                                    fontSize: 17,
                                  )),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Text("${sum}",
                                    style: const TextStyle(
                                      fontSize: 17,
                                    )),
                              ),
                              const Text("0.0",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ))
                            ],
                          ),
                        ],
                      ),
                      const Divider(
                        color: Color.fromARGB(255, 215, 215, 215),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Order Total",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                          Text(
                            "${sum}",
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 186, 29, 18)),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 370,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: const Color.fromARGB(255, 207, 207, 207)),
                ),
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Payment Type",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              )),
                          Text("Card",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                      const Divider(
                        color: Color.fromARGB(255, 215, 215, 215),
                      ),
                      Text("Add Gift Card or Promo Code",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: GlobalVariables.selectedNavBarColor))
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: CustomButton(
                text: "Place your Order",
                onTap: () {
                  RazorpayService.openCheckout(sum.toString(), context);
                },
                color: const Color.fromARGB(255, 230, 207, 0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
