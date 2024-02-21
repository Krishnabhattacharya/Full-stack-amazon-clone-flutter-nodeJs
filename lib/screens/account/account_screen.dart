import 'package:amazon_clone/constant/global_variable.dart';
import 'package:amazon_clone/widgets/account/account_button.dart';
import 'package:amazon_clone/widgets/account/bellow_app_bar.dart';
import 'package:amazon_clone/widgets/account/keep_shopping_for_widget.dart';
import 'package:amazon_clone/widgets/account/orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              alignment: Alignment.topLeft,
              child: Image.asset(
                "assets/images/amazon_in.png",
                width: 0.32.sw,
                height: 45,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 15, right: 5, bottom: 10),
              child: const Row(children: [
                Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(Icons.notifications_outlined),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 0),
                  child: Icon(Icons.search_outlined),
                ),
              ]),
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
          children: [
            const BellowBottomBar(),
            const SizedBox(
              height: 7,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AccountButton(text: "Your orders", onTap: () {}),
                AccountButton(text: "Buy Again", onTap: () {}),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AccountButton(text: "Your Account", onTap: () {}),
                AccountButton(text: "Your Lists", onTap: () {}),
              ],
            ),
            const Orders(),
            const KeepShoppingFor(),
            const SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AccountButton(text: "Manage Profile", onTap: () {}),
                  AccountButton(text: "Yours Orders", onTap: () {}),
                  AccountButton(text: "Yours Address", onTap: () {}),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
