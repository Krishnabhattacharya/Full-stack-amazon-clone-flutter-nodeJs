import 'package:amazon_clone/constant/global_variable.dart';

import 'package:amazon_clone/model/product_model.dart';
import 'package:amazon_clone/screens/home/search_screen.dart';
import 'package:amazon_clone/services/SharedServices/Sharedservices.dart';
import 'package:amazon_clone/widgets/home/carousel_slider.dart';
import 'package:amazon_clone/widgets/reuseable_widgets.dart/custom_button.dart';
import 'package:amazon_clone/widgets/reuseable_widgets.dart/custom_page_indicator_slider.dart';
import 'package:amazon_clone/widgets/reuseable_widgets.dart/rating_star_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductdetailsScreen extends StatefulWidget {
  static const String routeName = '/product-details-screen';
  final Product product;
  const ProductdetailsScreen({super.key, required this.product});

  @override
  State<ProductdetailsScreen> createState() => _ProductdetailsScreenState();
}

class _ProductdetailsScreenState extends State<ProductdetailsScreen> {
  int _currentIndex = 0;
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Visite the ${widget.product.name} store",
                    style: const TextStyle(color: Colors.teal),
                  ),
                  const StartRatting(rating: 3),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.product.name!,
                style: const TextStyle(fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5),
              child: CarouselSlider(
                items: widget.product.images!.map((imageUrl) {
                  return Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                    height: 0.3.sh,
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 0.3.sh,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  enableInfiniteScroll: true,
                  reverse: false,
                  // autoPlay: true,
                  // autoPlayInterval: Duration(seconds: 3),
                  // autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
            CustomPageIndicator(
              currentIndex: _currentIndex,
              itemCount: widget.product.images!.length,
            ),
            Container(
              color: const Color.fromARGB(255, 230, 230, 230),
              height: 6,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.currency_rupee,
                        size: 15,
                      ),
                      Text(
                        widget.product.price.toString(),
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  Text(
                    widget.product.description!,
                    style: const TextStyle(color: Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                    child: RichText(
                      text: const TextSpan(children: [
                        TextSpan(
                            text: "EMI ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        TextSpan(
                            text: "from RS 123. No cost EMI available.",
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                            text: "EMI option",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal)),
                      ]),
                    ),
                  ),
                  const Text("Inclusive of all taxes"),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    color: const Color.fromARGB(255, 230, 230, 230),
                    height: 6,
                  ),
                  Text("Total ${widget.product.price}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 19)),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: RichText(
                        text: const TextSpan(children: [
                      TextSpan(
                          text: "FREE scheduled delivery as soona as ",
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
                          text: "Sunday,7 AM - 9 PM.",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ])),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Text("Order within 8 hrs 54 mins.Details",
                        style: TextStyle(color: Colors.teal, fontSize: 13)),
                  ),
                  SharedServices.getLoginDetails()!.user!.address!.isNotEmpty
                      ? Row(
                          children: [
                            const Icon(Icons.location_on_outlined),
                            Text(
                                "Deliver to ${SharedServices.getLoginDetails()!.user!.address}")
                          ],
                        )
                      : Container(),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "In Stock",
                    style: TextStyle(
                        color: Color.fromARGB(255, 58, 154, 61),
                        fontWeight: FontWeight.w500,
                        fontSize: 17),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(right: 10.0, top: 10),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor:
                              const Color.fromARGB(255, 255, 214, 11),
                        ),
                        child: const Text(
                          "Add to Cart",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(right: 10.0, top: 10),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: GlobalVariables.secondaryColor,
                        ),
                        child: const Text(
                          "Buy Now",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      )),
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 4),
                    child: Text(
                      "Rate and Review the product",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20),
                    ),
                  ),
                  RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                      itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: GlobalVariables.secondaryColor,
                          ),
                      onRatingUpdate: (r) {}),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
