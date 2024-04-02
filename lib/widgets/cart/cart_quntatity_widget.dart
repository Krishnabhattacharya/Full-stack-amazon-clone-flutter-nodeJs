import 'package:amazon_clone/services/SharedServices/Sharedservices.dart';
import 'package:amazon_clone/services/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartQuantityWidget extends StatelessWidget {
  const CartQuantityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().loginmodel;
    int sum = 0;
    user!.cart!
        .map((e) => sum += (e.cartQuantity)! * (e.product!.price)!)
        .toList();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          const Text(
            "Subtotal ",
            style: TextStyle(fontSize: 24),
          ),
          Text(
            sum.toString(),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
