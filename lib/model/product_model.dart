// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  bool? success;
  List<Product>? products;

  ProductModel({
    this.success,
    this.products,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        success: json["success"],
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class Product {
  String? id;
  String? name;
  String? description;
  List<String>? images;
  int? quantity;
  int? price;
  String? catagory;
  int? v;
  List<Rating>? rating;

  Product({
    this.id,
    this.name,
    this.description,
    this.images,
    this.quantity,
    this.price,
    this.catagory,
    this.v,
    this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        quantity: json["quantity"],
        price: json["price"],
        catagory: json["catagory"],
        v: json["__v"],
        rating: json["rating"] == null
            ? []
            : List<Rating>.from(json["rating"]!.map((x) => Rating.fromJson(x))),
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
        "rating": rating == null
            ? []
            : List<dynamic>.from(rating!.map((x) => x.toJson())),
      };
}

class Rating {
  String? userId;
  double? rating;
  String? id;

  Rating({
    this.userId,
    this.rating,
    this.id,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        userId: json["userId"],
        rating: json["rating"]?.toDouble(),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "rating": rating,
        "_id": id,
      };
}
