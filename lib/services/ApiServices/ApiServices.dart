import 'dart:developer';

import 'package:amazon_clone/constant/dio_error.dart';
import 'package:amazon_clone/services/ApiServices/ApiBaseServices.dart';
import 'package:dio/dio.dart';

class Apiservices {
  // static Future<bool> loginUser({
  //   required String email,
  //   required String password,
  // }) async {
  //   bool res = false;
  //   LoginModel node = LoginModel();
  //   try {
  //     final response = await ApiBaseServices.loginUser(
  //       Exturl: "/user/login",
  //       email: email,
  //       password: password,
  //     );
  //     log("heloo");
  //     log(response.body);
  //     if (response.statusCode == 201 || response.statusCode == 200) {
  //       node = loginModelFromJson(response.body);
  //       SharedServices.setLoginDetails(node);
  //       res = true;
  //     }
  //     return res;
  //   } catch (e) {
  //     log("Exception while login ===$e");
  //     return false;
  //   }
  // }

//---------------------------------------------------------------------------------------------------------
  // static Future<GetUserDataModel> getuserdata() async {
  //   GetUserDataModel getuserDataModel = GetUserDataModel();
  //   try {
  //     final response = await ApiBaseServices.getRequestWithHeaders(
  //         endPoint: "/user/getUserData");
  //     //  log(response.statusCode.toString());
  //     if (response.statusCode == 200) {
  //       //log(response.body);
  //       getuserDataModel = getUserDataModelFromJson(response.body);
  //       return getuserDataModel;
  //     }
  //     return getuserDataModel;
  //   } catch (e) {
  //     log(e.toString());
  //     return getuserDataModel;
  //   }
  // }

//---------------------------------------------------------------------------------------------------------
  static Future<bool> signupUser({
    required String name,
    required String email,
    required String password,
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
        DioErrorHandling.handleDioError(e);
      } else {
        log("Exception: $e");
      }

      isSign = false;
    }
    return isSign;
  }

//-----------------------------------------------------------------------------------------
}
