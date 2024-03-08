import 'dart:developer';

import 'package:amazon_clone/admin/screen/add_product_screen.dart';
import 'package:amazon_clone/model/product_model.dart';

import 'package:amazon_clone/services/ApiServices/ApiServices.dart';
import 'package:amazon_clone/services/provider/admin_add_product_screen_isprograssing_change.dart';

import 'package:amazon_clone/widgets/account/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatefulWidget {
  static const String routeName = "/postScreen";
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  bool isLoading = false;
  List<Product>? productList = [];
  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  fetchProducts() async {
    Provider.of<IsprograssingChange>(context, listen: false)
        .changeIsPrograssing(true);
    log(isLoading.toString());
    final res = await Apiservices.getAllProduct(context);
    productList = res.products;
    Future.delayed(Duration.zero, () {
      Provider.of<IsprograssingChange>(context, listen: false)
          .changeIsPrograssing(false);
    });
    log(isLoading.toString());
  }

  deleteProductInUi(int index) async {
    setState(() {
      productList!.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    log("rebuild from post screen");
    return Consumer<IsprograssingChange>(builder: (context, value, child) {
      return value.isPrograssing
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              body: GridView.builder(
                  itemCount: productList!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    final product = productList![index];
                    return Column(
                      children: [
                        SizedBox(
                          height: 140,
                          child: SingleProduct(
                            images: product.images![0],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name!,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  Text(
                                    product.price.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ],
                              )),
                              IconButton(
                                  onPressed: () {
                                    // Apiservices.deleteProduct(
                                    //         product.id.toString())
                                    //     .then((value) => {
                                    //           if (value) {log("delete")}
                                    //         });
                                    deleteProductInUi(index);
                                  },
                                  icon: const Icon(Icons.delete_outline))
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: FloatingActionButton(
                shape: const CircleBorder(),
                elevation: 0,
                backgroundColor: const Color.fromARGB(255, 29, 201, 192),
                onPressed: () {
                  Navigator.pushNamed(context, AddProductScreen.routeName);
                },
                tooltip: 'Add a poduct',
                child: const Icon(Icons.add),
              ),
            );
    });
  }
}
