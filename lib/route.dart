import 'package:amazon_clone/admin/screen/add_product_screen.dart';
import 'package:amazon_clone/admin/screen/post_screen.dart';

import 'package:amazon_clone/model/product_model.dart';
import 'package:amazon_clone/screens/auth/auth_screen.dart';
import 'package:amazon_clone/screens/home/category_deals_screen.dart';
import 'package:amazon_clone/screens/home/home_screen.dart';
import 'package:amazon_clone/screens/home/search_screen.dart';
import 'package:amazon_clone/screens/product_details/product_details_screen.dart';
import 'package:amazon_clone/widgets/reuseable_widgets.dart/bottom_bar.dart';
import 'package:flutter/material.dart';

Route<dynamic> geneRateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AuthScreen());
    case HomePage.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const HomePage());
    case BottomBar.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const BottomBar());
    case AddProductScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AddProductScreen());
    case PostScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const PostScreen());
    case CategoryDeals.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CategoryDeals(
                category: category,
              ));
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => SearchScreen(
                searchQuery: searchQuery,
              ));
    case ProductdetailsScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => ProductdetailsScreen(
                product: product,
              ));
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}
