import 'dart:developer';

import 'package:amazon_clone/constant/global_variable.dart';
import 'package:amazon_clone/screens/account/account_screen.dart';
import 'package:amazon_clone/screens/home/cart_screen.dart';
import 'package:amazon_clone/screens/home/home_screen.dart';
import 'package:amazon_clone/services/SharedServices/Sharedservices.dart';
import 'package:amazon_clone/services/provider/api_services_provider.dart';
import 'package:amazon_clone/services/provider/auth_provider.dart';
import 'package:amazon_clone/services/provider/bottom_bar_index_change_provider.dart';
import 'package:amazon_clone/screens/home/demo_last_screen.dart';
import 'package:flutter/material.dart';

import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = "/actual-home";
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AuthProvider>(context, listen: false)
        .setLoginDetails(SharedServices.getLoginDetails()!.user!);
  }

  List screens = [
    const HomePage(),
    const AccountScreen(),
    const CartScreen(),
    const DemoLastScreen(),
  ];
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().loginmodel;
    log("rebuild from bottom");
    // final updatePage = Provider.of<BottobarIndexChange>(context, listen: false);
    return Consumer<BottobarIndexChange>(builder: (context, value, child) {
      return Scaffold(
          body: screens[value.page],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: value.page,
            selectedItemColor: GlobalVariables.selectedNavBarColor,
            unselectedItemColor: GlobalVariables.unselectedNavBarColor,
            backgroundColor: GlobalVariables.backgroundColor,
            iconSize: 28,
            type: BottomNavigationBarType.fixed,
            onTap: (int i) {
              value.updatePage(i);
            },
            items: [
              // HOME
              BottomNavigationBarItem(
                icon: Container(
                  width: bottomBarWidth,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: value.page == 0
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.backgroundColor,
                        width: bottomBarBorderWidth,
                      ),
                    ),
                  ),
                  child: const Icon(
                    Icons.home_outlined,
                  ),
                ),
                label: '',
              ),
              // ACCOUNT
              BottomNavigationBarItem(
                icon: Container(
                  width: bottomBarWidth,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: value.page == 1
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.backgroundColor,
                        width: bottomBarBorderWidth,
                      ),
                    ),
                  ),
                  child: const Icon(
                    Icons.person_outline_outlined,
                  ),
                ),
                label: '',
              ),
              // CART
              BottomNavigationBarItem(
                icon: Container(
                  width: bottomBarWidth,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: value.page == 2
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.backgroundColor,
                        width: bottomBarBorderWidth,
                      ),
                    ),
                  ),
                  child: badges.Badge(
                    //   elevation: 0,
                    badgeContent: Text(user?.cart?.length.toString() ?? "0"),
                    badgeStyle: const badges.BadgeStyle(
                      badgeColor: Colors.white,
                    ),

                    child: const Icon(
                      Icons.shopping_cart_outlined,
                    ),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  width: bottomBarWidth,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: value.page == 3
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.backgroundColor,
                        width: bottomBarBorderWidth,
                      ),
                    ),
                  ),
                  child: const Icon(
                    Icons.menu_outlined,
                  ),
                ),
                label: '',
              ),
            ],
          ));
    });
  }
}
