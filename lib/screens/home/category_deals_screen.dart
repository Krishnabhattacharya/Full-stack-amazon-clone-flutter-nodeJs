import 'dart:developer';

import 'package:amazon_clone/constant/global_variable.dart';

import 'package:amazon_clone/screens/product_details/product_details_screen.dart';

import 'package:amazon_clone/services/provider/api_services_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CategoryDeals extends StatefulWidget {
  static const String routeName = '/category-screen';
  final String category;
  const CategoryDeals({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryDeals> createState() => _CategoryDealsState();
}

class _CategoryDealsState extends State<CategoryDeals> {
  @override
  void initState() {
    super.initState();
    Provider.of<ApiProviderServices>(context, listen: false)
        .getCategoryProductProvider(context, widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            title: Text(
              widget.category,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
        body: Consumer<ApiProviderServices>(
          builder: (context, value, child) {
            log(value.categoryProducts.length.toString());
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      'Keep Shopping for ${widget.category}',
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                      height: 170,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 15),
                        itemCount: value.categoryProducts.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 1.4,
                        ),
                        itemBuilder: (context, index) {
                          log(value.categoryProducts[index].images![0]);
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, ProductdetailsScreen.routeName,
                                  arguments: value.categoryProducts[index]);
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 0.14.sh,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black, width: 0.5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Image.network(
                                        value
                                            .categoryProducts[index].images![0],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding:
                                      const EdgeInsets.only(top: 5, right: 15),
                                  child: Text(
                                    "Name: ${value.categoryProducts[index].name}",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding:
                                      const EdgeInsets.only(top: 5, right: 15),
                                  child: Text(
                                    "Price: ${value.categoryProducts[index].price}",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ))
                ]);
          },
        ));
  }
}
