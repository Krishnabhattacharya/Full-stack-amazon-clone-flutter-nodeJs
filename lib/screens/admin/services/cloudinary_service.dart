import 'dart:developer';
import 'package:amazon_clone/constant/dio_error.dart';
import 'package:amazon_clone/services/ApiServices/ApiBaseServices.dart';
import 'package:amazon_clone/services/ApiServices/ApiServices.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminService {
  Future<void> selProduct({
    required BuildContext context,
    required String name,
    required String desc,
    required double price,
    required double quantity,
    required String catagory,
    required List<XFile> images,
  }) async {
    try {
      final cloudinaryPublic = CloudinaryPublic("delcuaej9", "lwo9z77i");
      List<String> imagesUrl = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinaryPublic
            .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
        imagesUrl.add(res.secureUrl);
      }
      try {
        //   log("Request Payload: $name, $desc, $imagesUrl, $quantity, $price, $catagory");

        final res = await ApiBaseServices.postRequestWithHeader(
            endPoint: "/admin/add-product",
            body: {
              "name": name,
              "description": desc,
              "images": imagesUrl,
              "quantity": quantity,
              "price": price,
              "catagory": catagory
            });
        log("Response Data: ${res.data}");
        log(res.statusCode.toString());

        if (res.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Data Add Succesfully")));
        }
      } catch (e) {
        if (e is DioException) {
          final errorMessage = DioErrorHandling.handleDioError(e);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(errorMessage is Map
                ? errorMessage.toString()
                : "An error occurred"),
          ));
        } else {
          log("Exception: $e");
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
