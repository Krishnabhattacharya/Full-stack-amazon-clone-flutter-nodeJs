import 'dart:developer';

import 'package:amazon_clone/constant/dio_error.dart';
import 'package:amazon_clone/model/product_model.dart';

import 'package:amazon_clone/services/ApiServices/ApiBaseServices.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminService {
  List<String> publicIds = [];
  Future<void> selProduct({
    required BuildContext context,
    required String name,
    required String desc,
    required int price,
    required int quantity,
    required String catagory,
    required List<XFile> images,
  }) async {
    // GetProductModel getProduct = GetProductModel();
    try {
      final cloudinaryPublic = CloudinaryPublic("delcuaej9", "lwo9z77i");
      List<String> imagesUrl = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinaryPublic.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imagesUrl.add(res.secureUrl);
        publicIds.add(res.publicId);
      }
      try {
        Product product = Product(
            name: name,
            description: desc,
            images: imagesUrl,
            quantity: quantity,
            price: price,
            catagory: catagory);

        final res = await ApiBaseServices.postRequestWithHeader(
          endPoint: "/admin/add-product",
          body: product.toJson(),
        );
        log("Response Data: ${res.data}");
        log(res.statusCode.toString());

        if (res.statusCode == 200) {
          Future.delayed(Duration.zero, () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Data Add Successfully")),
            );
          });
        }
      } catch (e) {
        if (e is DioException) {
          final errorMessage = DioErrorHandling.handleDioError(e);
          Future.delayed(Duration.zero, () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage is Map
                    ? errorMessage.toString()
                    : "An error occurred"),
              ),
            );
          });
        } else {
          log("Exception: $e");
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }
  //-----------***  Admin delete a product   ***----------------------------------------------------------------------------------------------
// static Future<bool> deleteProduct(String id, List<String> publicIds) async {
//   final cloudinaryPublic = CloudinaryPublic("delcuaej9", "lwo9z77i");
//   bool isDelete = false;

//   try {
//     final resposnse = await ApiBaseServices.postRequestWithHeader(
//       body: ({"_id": id}),
//       endPoint: "/admin/delete-product",
//     );
//     log(resposnse.statusCode.toString());

//     if (resposnse.statusCode == 200) {
//       // Delete images from Cloudinary
//       for (final publicId in publicIds) {
//         await cloudinaryPublic.deleteFile(publicId);
//       }
//       isDelete = true;
//       return isDelete;
//     }

//     return isDelete;
//   } catch (e) {
//     log(e.toString());
//     return isDelete;
//   }
// }
}
