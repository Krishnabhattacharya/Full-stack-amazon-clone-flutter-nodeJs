import 'package:amazon_clone/constant/global_variable.dart';

import 'package:amazon_clone/screens/product_details/product_details_screen.dart';

import 'package:amazon_clone/services/provider/api_services_provider.dart';
import 'package:amazon_clone/widgets/home/address_box.dart';
import 'package:amazon_clone/widgets/home/search_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  final String searchQuery;
  static const routeName = '/search-screen';
  const SearchScreen({super.key, required this.searchQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ApiProviderServices>(context, listen: false)
        .getSearchProductsProvider(context, widget.searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Container(
                    height: 42,
                    margin: const EdgeInsets.only(left: 15),
                    child: Material(
                      borderRadius: BorderRadius.circular(7),
                      elevation: 1,
                      child: TextFormField(
                        onFieldSubmitted: (value) {
                          Navigator.pushNamed(context, SearchScreen.routeName,
                              arguments: value);
                        },
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.only(top: 10),
                            border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                borderSide: BorderSide.none),
                            enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(7),
                                ),
                                borderSide: BorderSide(
                                    color: Colors.black38, width: 1)),
                            prefixIcon: InkWell(
                              onTap: () {},
                              child: const Padding(
                                padding: EdgeInsets.only(left: 6),
                                child: Icon(Icons.search),
                              ),
                            ),
                            hintText: "Search Amazon.in",
                            hintStyle: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17)),
                      ),
                    ),
                  )),
                  Container(
                    color: Colors.transparent,
                    height: 42,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Icon(
                      Icons.mic,
                      color: Colors.black,
                    ),
                  )
                ]),
            flexibleSpace: Container(
                decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            )),
          ),
        ),
        body: Consumer<ApiProviderServices>(
          builder: (context, value, child) {
            return value.searchProducts.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      const AddressBoxWidget(),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                          child: ListView.builder(
                              itemCount: value.searchProducts.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, ProductdetailsScreen.routeName,
                                        arguments: value.searchProducts[index]);
                                  },
                                  child: SearchProductWidget(
                                      products: value.searchProducts[index]),
                                );
                              }))
                    ],
                  );
          },
        ));
  }
}
