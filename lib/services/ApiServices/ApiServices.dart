import 'dart:convert';
import 'dart:developer';

import 'package:amazon_clone/constant/dio_error.dart';

import 'package:amazon_clone/model/get_product_model.dart';
import 'package:amazon_clone/model/Auth_models/login_model.dart';
import 'package:amazon_clone/services/ApiServices/ApiBaseServices.dart';
import 'package:amazon_clone/services/SharedServices/Sharedservices.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Apiservices {
  static Future<bool> loginUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    bool res = false;
    LoginModel node = LoginModel();
    try {
      final response = await ApiBaseServices.loginUser(
        Exturl: "/api/auth/user/signin",
        email: email,
        password: password,
      );
      log("heloo");
      log(jsonEncode(response.data));
      if (response.statusCode == 201 || response.statusCode == 200) {
        node = loginModelFromJson(jsonEncode(response.data));
        SharedServices.setLoginDetails(node);
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
  static Future<GetProductModel> getAllProduct(BuildContext context) async {
    GetProductModel getProducts = GetProductModel();
    try {
      final resposnse = await ApiBaseServices.getRequestWithHeaders(
          endPoint: "/admin/get-product");
      log(resposnse.statusCode.toString());
      if (resposnse.statusCode == 200) {
        getProducts = getProductModelFromJson(jsonEncode(resposnse.data));
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
        endPoint: "/api/auth/user/signup",
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
  static Future<GetProductModel> getCategoryProducts(
      BuildContext context, String category) async {
    GetProductModel getProducts = GetProductModel();
    try {
      final response = await ApiBaseServices.getRequestWithHeaders(
          endPoint: "/api/category-products?category=$category");

      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        getProducts = getProductModelFromJson(jsonEncode(response.data));

        // log(getProducts.products!.length.toString());
        return getProducts;
      } else {
        log("Error: ${response.statusCode}");
        return getProducts;
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

      return getProducts;
    }
  }
}
