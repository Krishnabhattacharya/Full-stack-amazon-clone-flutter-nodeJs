import 'dart:developer';

import 'package:amazon_clone/model/Auth_models/user_model.dart';
import 'package:amazon_clone/model/product_model.dart';
import 'package:amazon_clone/services/ApiServices/ApiServices.dart';
import 'package:amazon_clone/services/SharedServices/Sharedservices.dart';
import 'package:flutter/material.dart';

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
      if (product.rating![i].id == SharedServices.getLoginDetails()!.user!.id) {
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

  //---------------------------------------------------------------------
  final UserModel _userModel = SharedServices.getLoginDetails()!;
  UserModelProduct _singleProduct = UserModelProduct();
  List<Cart> get cart => _userModel.user!.cart!;
  void setSingleProduct(int index) {
    _singleProduct = _userModel.user!.cart![index].product!;
  }

  UserModelProduct get singleProduct => _singleProduct;

  void increaseQuantity(BuildContext context) async {
    await Apiservices.addToCart(context: context, product: _singleProduct);
    notifyListeners();
  }
}
