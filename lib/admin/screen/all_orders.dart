import 'dart:developer';

import 'package:amazon_clone/model/order_model.dart';
import 'package:amazon_clone/screens/Order_Details/order_details_screen.dart';
import 'package:amazon_clone/services/provider/api_services_provider.dart';
import 'package:amazon_clone/widgets/account/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ApiProviderServices>(context, listen: false)
        .getadminOrders(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ApiProviderServices>(builder: (context, value, child) {
      return value.adminorders.isEmpty
          ? const CircularProgressIndicator()
          : GridView.builder(
              itemCount: value.adminorders.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                final orderData = value.adminorders[index];
                // log("kkkkkk" + orderData.address.toString());
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      OrderDetailScreen.routeName,
                      arguments: orderData,
                    );
                  },
                  child: SizedBox(
                    height: 140,
                    child: SingleProduct(
                        images:
                            orderData.products!.first.product!.images!.first),
                  ),
                );
              },
            );
    });
  }
}
