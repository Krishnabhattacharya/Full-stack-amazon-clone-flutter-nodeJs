

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  bool? success;
  String? message;
  User? user;
  String? token;

  UserModel({
    this.success,
    this.message,
    this.user,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        success: json["success"],
        message: json["message"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "user": user?.toJson(),
        "token": token,
      };
}

class User {
  String? id;
  String? name;
  String? email;
  String? address;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  List<Cart>? cart;

  User({
    this.id,
    this.name,
    this.email,
    this.address,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.cart,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        address: json["address"],
        type: json["type"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        cart: json["cart"] == null
            ? []
            : List<Cart>.from(json["cart"]!.map((x) => Cart.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "address": address,
        "type": type,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "cart": cart == null
            ? []
            : List<dynamic>.from(cart!.map((x) => x.toJson())),
      };
}

class Cart {
  UserModelProduct? product;
  int? cartQuantity;
  String? id;

  Cart({
    this.product,
    this.cartQuantity,
    this.id,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        product: json["product"] == null
            ? null
            : UserModelProduct.fromJson(json["product"]),
        cartQuantity: json["cartQuantity"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "product": product?.toJson(),
        "cartQuantity": cartQuantity,
        "_id": id,
      };
}

class UserModelProduct {
  String? name;
  String? description;
  List<String>? images;
  int? quantity;
  int? price;
  String? catagory;
  List<Rating>? rating;
  String? id;
  int? v;

  UserModelProduct({
    this.name,
    this.description,
    this.images,
    this.quantity,
    this.price,
    this.catagory,
    this.rating,
    this.id,
    this.v,
  });

  factory UserModelProduct.fromJson(Map<String, dynamic> json) =>
      UserModelProduct(
        name: json["name"],
        description: json["description"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        quantity: json["quantity"],
        price: json["price"],
        catagory: json["catagory"],
        rating: json["rating"] == null
            ? []
            : List<Rating>.from(json["rating"]!.map((x) => Rating.fromJson(x))),
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
        "rating": rating == null
            ? []
            : List<dynamic>.from(rating!.map((x) => x.toJson())),
        "_id": id,
        "__v": v,
      };
}

class Rating {
  String? userId;
  int? rating;
  String? id;

  Rating({
    this.userId,
    this.rating,
    this.id,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        userId: json["userId"],
        rating: json["rating"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "rating": rating,
        "_id": id,
      };
}
