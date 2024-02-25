// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

AddProductModel productModelFromJson(String str) =>
    AddProductModel.fromJson(json.decode(str));

String productModelToJson(AddProductModel data) => json.encode(data.toJson());

class AddProductModel {
  bool? success;
  Product? product;

  AddProductModel({
    this.success,
    this.product,
  });

  factory AddProductModel.fromJson(Map<String, dynamic> json) =>
      AddProductModel(
        success: json["success"],
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "product": product?.toJson(),
      };
}

class Product {
  String? name;
  String? description;
  List<String>? images;
  int? quantity;
  double? price;
  String? catagory;
  String? id;
  int? v;

  Product({
    this.name,
    this.description,
    this.images,
    this.quantity,
    this.price,
    this.catagory,
    this.id,
    this.v,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json["name"],
        description: json["description"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        quantity: json["quantity"],
        price: json["price"]?.toDouble(),
        catagory: json["catagory"],
        id: json["_id"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "quantity": quantity,
        "price": price,
        "catagory": catagory,
        "_id": id,
        "__v": v,
      };
}
