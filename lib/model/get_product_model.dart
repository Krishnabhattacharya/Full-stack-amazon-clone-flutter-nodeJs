// To parse this JSON data, do
//
//     final getProductModel = getProductModelFromJson(jsonString);

import 'dart:convert';

GetProductModel getProductModelFromJson(String str) =>
    GetProductModel.fromJson(json.decode(str));

String getProductModelToJson(GetProductModel data) =>
    json.encode(data.toJson());

class GetProductModel {
  bool? success;
  List<GProduct>? products;

  GetProductModel({
    this.success,
    this.products,
  });

  factory GetProductModel.fromJson(Map<String, dynamic> json) =>
      GetProductModel(
        success: json["success"],
        products: json["products"] == null
            ? []
            : List<GProduct>.from(
                json["products"]!.map((x) => GProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class GProduct {
  String? id;
  String? name;
  String? description;
  List<String>? images;
  int? quantity;
  double? price;
  String? catagory;
  int? v;

  GProduct({
    this.id,
    this.name,
    this.description,
    this.images,
    this.quantity,
    this.price,
    this.catagory,
    this.v,
  });

  factory GProduct.fromJson(Map<String, dynamic> json) => GProduct(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        quantity: json["quantity"],
        price: json["price"]?.toDouble(),
        catagory: json["catagory"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "quantity": quantity,
        "price": price,
        "catagory": catagory,
        "__v": v,
      };
}
