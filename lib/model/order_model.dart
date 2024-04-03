import 'dart:convert';

import 'package:amazon_clone/model/product_model.dart';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));
OrderModelProduct orderModelProductFromJson(String str) =>
    OrderModelProduct.fromJson(json.decode(str));
String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  bool? success;
  List<OrderModelProduct>? products;

  OrderModel({
    this.success,
    this.products,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        success: json["success"],
        products: json["products"] == null
            ? []
            : List<OrderModelProduct>.from(
                json["products"]!.map((x) => OrderModelProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class OrderModelProduct {
  String? id;
  List<InnerProducts>? products;
  int? price;
  String? address;
  String? userId;
  int? orderAt;
  int? status;
  int? v;

  OrderModelProduct({
    this.id,
    this.products,
    this.price,
    this.address,
    this.userId,
    this.orderAt,
    this.status,
    this.v,
  });

  factory OrderModelProduct.fromJson(Map<String, dynamic> json) =>
      OrderModelProduct(
        id: json["_id"],
        products: json["products"] == null
            ? []
            : List<InnerProducts>.from(
                json["products"]!.map((x) => InnerProducts.fromJson(x))),
        price: json["price"],
        address: json["address"],
        userId: json["userId"],
        orderAt: json["orderAt"],
        status: json["status"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "price": price,
        "address": address,
        "userId": userId,
        "orderAt": orderAt,
        "status": status,
        "__v": v,
      };
}

class InnerProducts {
  Product? product;
  int? quantity;
  String? id;

  InnerProducts({
    this.product,
    this.quantity,
    this.id,
  });

  factory InnerProducts.fromJson(Map<String, dynamic> json) => InnerProducts(
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
        quantity: json["quantity"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "product": product?.toJson(),
        "quantity": quantity,
        "_id": id,
      };
}
