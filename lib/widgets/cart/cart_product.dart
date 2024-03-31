import 'dart:developer';

import 'package:amazon_clone/model/Auth_models/user_model.dart';
import 'package:amazon_clone/services/ApiServices/ApiServices.dart';
import 'package:amazon_clone/services/SharedServices/Sharedservices.dart';
import 'package:flutter/material.dart';

class Cartproduct extends StatefulWidget {
  final int index;
  const Cartproduct({super.key, required this.index});

  @override
  State<Cartproduct> createState() => _CartproductState();
}

class _CartproductState extends State<Cartproduct> {
  int quantity = 0;
  @override
  void initState() {
    super.initState();
    setState(() {
      quantity = SharedServices.getLoginDetails()!
          .user!
          .cart![widget.index]
          .cartQuantity!;
    });
  }

  void increaseQuantity(UserModelProduct product) async {
    final res = await Apiservices.addToCart(context: context, product: product);
    setState(() {
      quantity = res.user!.cart![0].cartQuantity!;
      log(quantity.toString());
    });
    SharedServices.updateCart(res.user!.cart!);
  }

  void decreaseQuantity(UserModelProduct product) async {
    final res =
        await Apiservices.deleteFromCart(context: context, product: product);
    if (res.user!.cart!.isEmpty) {
      setState(() {
        quantity = 0;
      });
      SharedServices.updateCart([]);
    } else {
      setState(() {
        quantity = res.user!.cart![0].cartQuantity!;
        log(quantity.toString());
      });
      SharedServices.updateCart(res.user!.cart!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final singleProduct =
        SharedServices.getLoginDetails()?.user?.cart?.isNotEmpty ?? false
            ? SharedServices.getLoginDetails()!.user!.cart![widget.index]
            : null;

    final products = singleProduct?.product;
    return singleProduct == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(children: [
                  Image.network(
                    products!.images![0],
                    fit: BoxFit.cover,
                    height: 135,
                    width: 135,
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: 235,
                        child: Text(
                          products.name!,
                          style: const TextStyle(fontSize: 16),
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: 235,
                        child: Text(
                          "Rs ${products.price!}",
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: 235,
                        child: const Text(
                          "Eligible for FREE shipping",
                          // style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: 235,
                        child: const Text(
                          "In stock",
                          style: TextStyle(color: Colors.teal),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  )
                ]),
              ),
              Container(
                padding: const EdgeInsets.only(left: 5),
                margin: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black12,
                        ),
                        child: Row(children: [
                          InkWell(
                            onTap: () =>
                                decreaseQuantity(singleProduct.product!),
                            child: Container(
                              width: 35,
                              height: 32,
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.remove,
                                size: 18,
                              ),
                            ),
                          ),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black12, width: 1.5),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: Container(
                              width: 35,
                              height: 32,
                              alignment: Alignment.center,
                              child: Text(quantity.toString()),
                            ),
                          ),
                          InkWell(
                            onTap: () =>
                                increaseQuantity(singleProduct.product!),
                            child: Container(
                              width: 35,
                              height: 32,
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.add,
                                size: 18,
                              ),
                            ),
                          ),
                        ]))
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
  }
}
