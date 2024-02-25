import 'package:amazon_clone/constant/global_variable.dart';
import 'package:amazon_clone/widgets/account/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KeepShoppingFor extends StatefulWidget {
  const KeepShoppingFor({super.key});

  @override
  State<KeepShoppingFor> createState() => _KeepShoppingFor();
}

class _KeepShoppingFor extends State<KeepShoppingFor> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15, top: 20),
              child: const Text(
                "Keep shopping for",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 15, top: 20),
              child: Text(
                "Browsing history",
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
              itemCount: 2,
              itemBuilder: (context, index) {
                return const SingleProduct(
                  images:
                      'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
                );
              }),
        )
      ],
    );
  }
}
