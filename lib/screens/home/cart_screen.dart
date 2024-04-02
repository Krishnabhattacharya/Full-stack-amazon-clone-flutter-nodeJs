import 'package:amazon_clone/constant/global_variable.dart';
import 'package:amazon_clone/screens/address/address_screen.dart';
import 'package:amazon_clone/screens/home/search_screen.dart';
import 'package:amazon_clone/services/provider/auth_provider.dart';
import 'package:amazon_clone/widgets/cart/cart_product.dart';
import 'package:amazon_clone/widgets/cart/cart_quntatity_widget.dart';
import 'package:amazon_clone/widgets/home/address_box.dart';
import 'package:amazon_clone/widgets/reuseable_widgets.dart/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
                          borderSide:
                              BorderSide(color: Colors.black38, width: 1)),
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
      body: user.loginmodel?.cart == null
          ? const Center(child: Text("Cart is Empty"))
          : SingleChildScrollView(
              child: Column(children: [
                const AddressBoxWidget(),
                const CartQuantityWidget(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                      color: Colors.yellow[600],
                      text:
                          "Procced to Buy (${user!.loginmodel!.cart!.length})",
                      onTap: () {
                        user?.loginmodel?.cart?.length == 0
                            ? () {}
                            : Navigator.pushNamed(
                                context,
                                AddressScreen.routeName,
                              );
                      }),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Divider(
                  color: Color.fromARGB(255, 218, 218, 218),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  //height: double.infinity,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: user.loginmodel!.cart!.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 200,
                          child: Cartproduct(
                            index: index,
                          ),
                        );
                      }),
                )
              ]),
            ),
    );
  }
}
