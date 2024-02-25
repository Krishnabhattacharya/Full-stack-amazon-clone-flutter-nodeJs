import 'package:amazon_clone/constant/global_variable.dart';
import 'package:amazon_clone/services/ApiServices/ApiServices.dart';
import 'package:flutter/material.dart';

class CategoryDeals extends StatefulWidget {
  static const String routeName = '/category-screen';
  final String category;
  const CategoryDeals({super.key, required this.category});

  @override
  State<CategoryDeals> createState() => _CategoryDealsState();
}

getdata(BuildContext context) async {
  await Apiservices.getCategoryProducts(context, "Mobiles");
}

class _CategoryDealsState extends State<CategoryDeals> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata(context);
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
            )),
      ),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          alignment: Alignment.topLeft,
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
              itemCount: 10,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, childAspectRatio: 1.4, mainAxisExtent: 10),
              itemBuilder: (context, index) {
                return Text("hello");
              }),
        )
      ]),
    );
  }
}
