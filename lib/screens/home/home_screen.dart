import 'package:amazon_clone/constant/global_variable.dart';
import 'package:amazon_clone/widgets/home/address_box.dart';
import 'package:amazon_clone/widgets/home/carousel_slider.dart';
import 'package:amazon_clone/widgets/home/deal_of_the_day.dart';
import 'package:amazon_clone/widgets/home/top_catagory.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const String routeName = "/home";
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: const SingleChildScrollView(
        child: Column(
          children: [
            AddressBoxWidget(),
            SizedBox(
              height: 10,
            ),
            TopCatagory(),
            SizedBox(
              height: 10,
            ),
            CarousalSliderImage(),
            DealOfTheDay(),
          ],
        ),
      ),
    );
  }
}
