import 'dart:convert';
import 'dart:developer';

import 'package:amazon_clone/constant/apis_end_point.dart';
import 'package:amazon_clone/constant/dio_error.dart';
import 'package:amazon_clone/model/order_model.dart';
import 'package:amazon_clone/model/product_model.dart';
import 'package:amazon_clone/model/Auth_models/user_model.dart';
import 'package:amazon_clone/services/ApiServices/ApiBaseServices.dart';
import 'package:amazon_clone/services/SharedServices/Sharedservices.dart';
import 'package:amazon_clone/services/provider/auth_provider.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Apiservices {
  static Future<bool> loginUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    bool res = false;
    UserModel node = UserModel();
    try {
      final response = await ApiBaseServices.loginUser(
        Exturl: ApiEndpoints.login,
        email: email,
        password: password,
      );
      log("heloo");
      log(jsonEncode(response.data));
      if (response.statusCode == 201 || response.statusCode == 200) {
        node = userModelFromJson(jsonEncode(response.data));
        SharedServices.setLoginDetails(node);
        Future.delayed(Duration.zero, () {
          Provider.of<AuthProvider>(context, listen: false)
              .setLoginDetails(node.user!);
        });
        res = true;
      }
      return res;
    } catch (e) {
      if (e is DioException) {
        final errorMessage = DioErrorHandling.handleDioError(e);
        Future.delayed(Duration.zero, () {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(errorMessage.toString())));
        });
      } else {
        log("Exception: $e");
      }
      return false;
    }
  }

//-----------***  Admin get all product   ***----------------------------------------------------------------------------------------------
  static Future<ProductModel> getAllProduct(BuildContext context) async {
    ProductModel getProducts = ProductModel();
    try {
      final resposnse = await ApiBaseServices.getRequestWithHeaders(
          endPoint: ApiEndpoints.getAllProducts);
      log(resposnse.statusCode.toString());
      if (resposnse.statusCode == 200) {
        getProducts = productModelFromJson(jsonEncode(resposnse.data));
        //log(getM.products!.first.price.toString());

        return getProducts;
      }

      return getProducts;
    } catch (e) {
      if (e is DioException) {
        final errorMessage = DioErrorHandling.handleDioError(e);
        Future.delayed(Duration.zero, () {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(errorMessage.toString())));
        });
      } else {
        log("Exception: $e");
      }
      return getProducts;
    }
  }

//---------------------------------------------------------------------------------------------------------
  static Future<bool> signupUser({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    bool isSign = false;

    try {
      Response res = await ApiBaseServices.postRequest(
        endPoint: ApiEndpoints.signup,
        body: {
          "name": name,
          "email": email,
          "password": password,
        },
      );

      log("Response Data: ${res.data}");
      log(res.statusCode.toString());

      if (res.statusCode == 201) {
        isSign = true;
      }
    } catch (e) {
      if (e is DioException) {
        final errorMessage = DioErrorHandling.handleDioError(e);
        Future.delayed(Duration.zero, () {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(errorMessage.toString())));
        });
      } else {
        log("Exception: $e");
      }

      isSign = false;
    }
    return isSign;
  }

//--------  get category products users  ----------------------------------------------------
  static Future<List<Product>> getCategoryProducts(
      BuildContext context, String category) async {
    List<Product> products = [];
    try {
      final response = await ApiBaseServices.getRequestWithHeaders(
          endPoint: "${ApiEndpoints.getCategoryProducts}?category=$category");

      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        ProductModel getProducts =
            productModelFromJson(jsonEncode(response.data));
        products = getProducts.products ?? [];
        // log(products.length.toString());
        return products;
      } else {
        log("Error: ${response.statusCode}");
        return products;
      }
    } catch (e) {
      if (e is DioException) {
        final errorMessage = DioErrorHandling.handleDioError(e);
        Future.delayed(Duration.zero, () {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(errorMessage.toString())));
        });
      } else {
        log("Exception: $e");
      }

      return products;
    }
  }

  //------------------------------------------------------------------------------
  //search-products
  static Future<List<Product>> getSearchProducts(
      BuildContext context, String category) async {
    List<Product> products = [];
    try {
      final response = await ApiBaseServices.getRequestWithHeaders(
          endPoint: "${ApiEndpoints.searchProducts}/$category");

      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        ProductModel getProducts =
            productModelFromJson(jsonEncode(response.data));
        products = getProducts.products ?? [];
        // log(products.length.toString());
        return products;
      } else {
        log("Error: ${response.statusCode}");
        return products;
      }
    } catch (e) {
      if (e is DioException) {
        final errorMessage = DioErrorHandling.handleDioError(e);
        Future.delayed(Duration.zero, () {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(errorMessage.toString())));
        });
      } else {
        log("Exception: $e");
      }

      return products;
    }
  }

  //----------------------------------------------------------------------------------
  //rating-product
  static Future<void> rateproduct({
    required BuildContext context,
    required Product product,
    required double rating,
  }) async {
    try {
      Response res = await ApiBaseServices.postRequestWithHeader(
          endPoint: ApiEndpoints.rateProduct,
          body: {
            'id': product.id,
            'rating': rating,
          });
    } catch (e) {
      if (e is DioException) {
        final errorMessage = DioErrorHandling.handleDioError(e);
        Future.delayed(Duration.zero, () {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(errorMessage.toString())));
        });
      } else {
        log("Exception: $e");
      }
    }
  }

  //--------------------------------------------------
  //get deal of the day
  static Future<Product> dealOfTheDay({required BuildContext context}) async {
    Product product = Product();
    try {
      final response = await ApiBaseServices.getRequestWithHeaders(
          endPoint: ApiEndpoints.dealOfTheDay);

      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        //  log(response.data.toString());
        final res = productModelFromJson(jsonEncode(response.data));
        product = res.products!.first;
        return product;
      } else {
        log("Error: ${response.statusCode}");
        return product;
      }
    } catch (e) {
      if (e is DioException) {
        final errorMessage = DioErrorHandling.handleDioError(e);
        Future.delayed(Duration.zero, () {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(errorMessage.toString())));
        });
      } else {
        log("Exception: $e");
      }

      return product;
    }
  }

  //-----------------------------------------------------------------------------------
  //add-to-cart
  static Future<UserModel> addToCart(
      {required BuildContext context,
      required UserModelProduct product}) async {
    UserModel userModel = UserModel();
    try {
      Response res = await ApiBaseServices.postRequestWithHeader(
          endPoint: ApiEndpoints.addToCart,
          body: {
            "id": product.id,
          });

      userModel = userModelFromJson(jsonEncode(res.data));
      Future.delayed(Duration.zero, () {
        User user = Provider.of<AuthProvider>(context, listen: false)
            .loginmodel!
            .copyWith(cart: userModel.user!.cart);

        Provider.of<AuthProvider>(context, listen: false).setLoginDetails(user);
      });
      SharedServices.updateCart(userModel.user!.cart!);
      return userModel;
    } catch (e) {
      if (e is DioException) {
        final errorMessage = DioErrorHandling.handleDioError(e);
        Future.delayed(Duration.zero, () {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(errorMessage.toString())));
        });
      } else {
        log("Exception: $e");
      }
    }
    return userModel;
  }

  //--------------------------------------------------------
  //delete from cart
  static Future<UserModel> deleteFromCart(
      {required BuildContext context,
      required UserModelProduct product}) async {
    UserModel userModel = UserModel();
    try {
      Response res = await ApiBaseServices.postRequestWithHeader(
          endPoint: ApiEndpoints.deleteFromCart,
          body: {
            "id": product.id,
          });

      userModel = userModelFromJson(jsonEncode(res.data));
      Future.delayed(Duration.zero, () {
        User user = Provider.of<AuthProvider>(context, listen: false)
            .loginmodel!
            .copyWith(cart: userModel.user!.cart);

        Provider.of<AuthProvider>(context, listen: false).setLoginDetails(user);
      });
      SharedServices.updateCart(userModel.user!.cart!);
      return userModel;
    } catch (e) {
      if (e is DioException) {
        final errorMessage = DioErrorHandling.handleDioError(e);
        Future.delayed(Duration.zero, () {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(errorMessage.toString())));
        });
      } else {
        log("Exception: $e");
      }
    }
    return userModel;
  }

  //--------------------------------------------------------
  //add-address
  static Future<void> addAddress({
    required String address,
    required BuildContext context,
  }) async {
    try {
      final response = await ApiBaseServices.postRequestWithHeader(
          endPoint: ApiEndpoints.addAddress,
          body: {
            'address': address,
          });
      // log("heloo");
      log(jsonEncode(response.data));
      if (response.statusCode == 201 || response.statusCode == 200) {
        SharedServices.updateAddress(address);
        Future.delayed(Duration.zero, () {
          User user = Provider.of<AuthProvider>(context, listen: false)
              .loginmodel!
              .copyWith(address: address);

          Provider.of<AuthProvider>(context, listen: false)
              .setLoginDetails(user);
        });
      }
      // return res;
    } catch (e) {
      if (e is DioException) {
        final errorMessage = DioErrorHandling.handleDioError(e);
        Future.delayed(Duration.zero, () {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(errorMessage.toString())));
        });
      } else {
        log("Exception: $e");
      }
    }
  }

  //place order--------------------------------------------------------------
  static Future<void> placeOrder({
    required String address,
    required BuildContext context,
    required int price,
  }) async {
    try {
      final response = await ApiBaseServices.postRequestWithHeader(
          endPoint: ApiEndpoints.placeOrder,
          body: {
            'cart': SharedServices.getLoginDetails()!.user!.cart,
            'address': SharedServices.getLoginDetails()!.user!.address,
            'price': price
          });
      log(jsonEncode(response.data));
      if (response.statusCode == 201 || response.statusCode == 200) {
        SharedServices.updateCart([]);
      }
      Future.delayed(Duration.zero, () {
        User user = Provider.of<AuthProvider>(context, listen: false)
            .loginmodel!
            .copyWith(cart: []);

        Provider.of<AuthProvider>(context, listen: false).setLoginDetails(user);
      });

      // return res;
    } catch (e) {
      if (e is DioException) {
        final errorMessage = DioErrorHandling.handleDioError(e);
        Future.delayed(Duration.zero, () {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(errorMessage.toString())));
        });
      } else {
        log("Exception: $e");
      }
      // return false;
    }
  }

  //get my orders------------------------------------------------------------------------
  static Future<List<OrderModelProduct>> getAllOrders(
      {required BuildContext context}) async {
    List<OrderModelProduct> orders = [];
    try {
      final response = await ApiBaseServices.getRequestWithHeaders(
          endPoint: ApiEndpoints.getOrders);

      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        final res = orderModelFromJson(jsonEncode(response.data));
        orders = res.products!;
        return orders;
      } else {
        log("Error: ${response.statusCode}");
        return orders;
      }
    } catch (e) {
      if (e is DioException) {
        final errorMessage = DioErrorHandling.handleDioError(e);
        Future.delayed(Duration.zero, () {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(errorMessage.toString())));
        });
      } else {
        log("Exception: $e");
      }

      return orders;
    }
  }

  //admin get all orders-----------------------------------------------------
  static Future<List<OrderModelProduct>> adminGetAllOrders(
      BuildContext context) async {
    List<OrderModelProduct> orders = [];
    try {
      final resposnse = await ApiBaseServices.getRequestWithHeaders(
          endPoint: ApiEndpoints.adminGetAllOrders);
      log(resposnse.statusCode.toString());
      if (resposnse.statusCode == 200) {
        final res = orderModelFromJson(jsonEncode(resposnse.data));
        orders = res.products!;
        log(resposnse.data.toString());
        return orders;
      }
      return orders;
    } catch (e) {
      if (e is DioException) {
        final errorMessage = DioErrorHandling.handleDioError(e);
        Future.delayed(Duration.zero, () {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(errorMessage.toString())));
        });
      } else {
        log("Exception: $e");
      }
      return orders;
    }
  }

  //update status-------------------------------------------------------------------------------------
  static Future<OrderModelProduct> updateOrderStatus(
      {required int status,
      required BuildContext context,
      required OrderModelProduct order}) async {
    OrderModelProduct ordr = OrderModelProduct();
    try {
      final response = await ApiBaseServices.postRequestWithHeader(
          endPoint: ApiEndpoints.updateOrderStatus,
          body: {'id': order.id, 'status': status});
      log(jsonEncode(response.data));
      if (response.statusCode == 201 || response.statusCode == 200) {
        ordr = orderModelProductFromJson(response.data);
      }
      return ordr;
    } catch (e) {
      if (e is DioException) {
        final errorMessage = DioErrorHandling.handleDioError(e);
        Future.delayed(Duration.zero, () {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(errorMessage.toString())));
        });
      } else {
        log("Exception: $e");
      }
      return ordr;
    }
  }

  //-------------------------------------------------------------------
  //get analytic details in admin
  static Future<Map<String, dynamic>> analyticDetails({
    required BuildContext context,
  }) async {
    late Map<String, dynamic> res;
    try {
      final response = await ApiBaseServices.getRequestWithHeaders(
        endPoint: ApiEndpoints.getAnalyticDetails,
      );
      if (response.statusCode == 200) {
        res = response.data;
      } else {
        log("Error: ${response.statusCode}");
      }
      return res;
    } catch (e) {
      if (e is DioException) {
        final errorMessage = DioErrorHandling.handleDioError(e);
        Future.delayed(Duration.zero, () {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(errorMessage.toString())));
        });
      } else {
        log("Exception: $e");
      }
    }
    return res;
  }
}
