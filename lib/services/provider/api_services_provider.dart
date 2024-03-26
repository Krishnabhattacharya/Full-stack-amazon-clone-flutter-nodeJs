import 'package:amazon_clone/model/product_model.dart';
import 'package:amazon_clone/services/ApiServices/ApiServices.dart';
import 'package:amazon_clone/services/SharedServices/Sharedservices.dart';
import 'package:flutter/material.dart';

class ApiProviderServices extends ChangeNotifier {
  Future<ProductModel> getAllProductProvider(BuildContext context) async {
    return await Apiservices.getAllProduct(context);
  }

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
  double totalRating = 0;
  double get avgRating => _avgRating;
  double get myrating => _myRating;
  Future<void> rateProductProvider(
      BuildContext context, double rating, Product product) async {
    await Apiservices.rateproduct(
        context: context, product: product, rating: rating);
    for (var i = 0; i < product.rating!.length; i++) {
      totalRating = totalRating + product.rating![i].rating!;
      if (product.rating![i].id == SharedServices.getLoginDetails()!.user!.id) {
        _myRating = product.rating![i].rating!;
      }
    }
    if (totalRating != 0) {
      _avgRating = totalRating / product.rating!.length;
    }
    notifyListeners();
  }
}
