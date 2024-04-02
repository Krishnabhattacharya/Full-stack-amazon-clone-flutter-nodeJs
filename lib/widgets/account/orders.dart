import 'dart:developer';

import 'package:amazon_clone/constant/global_variable.dart';
import 'package:amazon_clone/screens/Order_Details/order_details_screen.dart';
import 'package:amazon_clone/services/provider/api_services_provider.dart';
import 'package:amazon_clone/widgets/account/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  void initState() {
    super.initState();
    Provider.of<ApiProviderServices>(context, listen: false).getOrders(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ApiProviderServices>(
      builder: (context, value, child) {
        return value.orders.isEmpty
            ? const Center(
                child: Text("No Orders, Keep searching.."),
              )
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 15, top: 20),
                        child: const Text(
                          "Your Orders",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 15, top: 20),
                        child: Text(
                          "See more",
                          style: TextStyle(
                              fontSize: 15,
                              color: GlobalVariables.selectedNavBarColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 0.26.sh,
                    padding: const EdgeInsets.only(top: 20, left: 10),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: value.orders.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              log(value.orders[index].address!);
                              Navigator.pushNamed(
                                  context, OrderDetailScreen.routeName,
                                  arguments: value.orders[index]);
                            },
                            child: SingleProduct(
                              images: value.orders[index].products![0].product!
                                  .images![0],
                            ),
                          );
                        }),
                  )
                ],
              );
      },
    );
  }
}
