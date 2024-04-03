import 'dart:developer';

import 'package:amazon_clone/model/Auth_models/user_model.dart';
import 'package:amazon_clone/model/order_model.dart';
import 'package:amazon_clone/model/product_model.dart';
import 'package:amazon_clone/services/ApiServices/ApiServices.dart';
import 'package:amazon_clone/services/SharedServices/Sharedservices.dart';
import 'package:amazon_clone/services/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApiProviderServices extends ChangeNotifier {
  // Future<ProductModel> getAllProductProvider(BuildContext context) async {
  //   return await Apiservices.getAllProduct(context);
  // }

//--------------------------------------------------
  List<Product> _categoryProducts = [];
  List<Product> get categoryProducts => _categoryProducts;
  Future<void> getCategoryProductProvider(
      BuildContext context, String category) async {
    _categoryProducts =
        await Apiservices.getCategoryProducts(context, category);
    notifyListeners();
  }

//---------------------------------------------------
  List<Product> _searchProducts = [];
  List<Product> get searchProducts => _searchProducts;

  Future<void> getSearchProductsProvider(
      BuildContext context, String category) async {
    _searchProducts = await Apiservices.getSearchProducts(context, category);
    notifyListeners();
  }

  //----------------------------------------------------
  double _avgRating = 0;
  double _myRating = 0;

  double get avgRating => _avgRating;
  double get myRating => _myRating;

  Future<void> rateProductProvider(
      BuildContext context, double rating, Product product) async {
    await Apiservices.rateproduct(
        context: context, product: product, rating: rating);
    double totalRating = 0;
    for (var i = 0; i < product.rating!.length; i++) {
      totalRating += product.rating![i].rating!;
      if (product.rating![i].id ==
          Provider.of<AuthProvider>(context, listen: false).loginmodel!.id) {
        _myRating = product.rating![i].rating!;
      }
    }
    if (product.rating!.length > 0) {
      _avgRating = totalRating / product.rating!.length;
    } else {
      _avgRating = 0;
    }
    notifyListeners();
  }

  //------------------------------------------------------------------
  Product? _product;
  Product? get dealOfTheProduct => _product;
  Future<void> getDealOfTheDay(BuildContext context) async {
    _product = await Apiservices.dealOfTheDay(context: context);
    //  log(_product.toString());
    notifyListeners();
  }

  //-----------------------------------------------------------
  List<OrderModelProduct> _orders = [];
  List<OrderModelProduct> get orders => _orders;
  void getOrders(BuildContext context) async {
    _orders = await Apiservices.getAllOrders(context: context);
    notifyListeners();
  }

  //-------------------------------------------------------------
  List<OrderModelProduct> _admiorders = [];
  List<OrderModelProduct> get adminorders => _admiorders;
  void getadminOrders(BuildContext context) async {
    _admiorders = await Apiservices.adminGetAllOrders(context);
    notifyListeners();
  }

  //-----------------------------------------------------------
  Map<String, dynamic>? _data;

  Map<String, dynamic>? get data => _data;
  void fetchAnalytics(BuildContext context) async {
    _data = await Apiservices.analyticDetails(context: context);
    notifyListeners();
  }
}
