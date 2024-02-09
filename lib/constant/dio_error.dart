import 'dart:developer';

import 'package:dio/dio.dart';

class DioErrorHandling {
  static String? handleDioError(DioException error) {
    String? errorMessge;
    if (error.response != null) {
      final res = error.response!;
      log("Error Response Data: ${res.data}");
      errorMessge = res.data['message'];
      log("Error Status Code: ${res.statusCode}");
      if (res.statusCode == 500) {
        final Map<String, dynamic>? responseData =
            res.data as Map<String, dynamic>?;

        if (responseData != null && responseData.containsKey("message")) {
          log("Error Message: ${responseData['message']}");
        }
      }
    } else {
      log("DioError: $error");
    }
    return errorMessge;
  }
}
