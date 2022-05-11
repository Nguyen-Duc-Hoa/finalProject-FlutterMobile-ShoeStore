import 'dart:ffi';
import 'package:flutter/cupertino.dart';

import 'Product.dart';

class Cart {
  late int productId;
  late String title = '';
  late int numOfItem;
  late int size;
  late String color;
  late String image;
  late String userId;
  late double price;
  late int discount;
  late Product product;

  Cart(
      {required this.productId,
      required this.title,
      required this.numOfItem,
      required this.size,
      required this.color,
      required this.image,
      required this.userId,
      required this.price,
      required this.discount});

  factory Cart.fromMap(Map data) => Cart(
      productId: data['productId'],
      title: data['title'],
      numOfItem: data['numOfItem'],
      size: data['size'],
      color: data['color'],
      image: data['image'],
      userId: data['userId'],
      price: data['price'],
      discount: data['discount']);
}

class ProductCart {}

// Demo data for our cart

List<Cart> demoCarts = [
  Cart(
      productId: 1,
      price: 10.0,
      discount: 0,
      title: "Giay the thao",
      userId: "",
      numOfItem: 2,
      size: 37,
      color: "0xFFF6625E",
      image: ""),
  Cart(
      productId: 1,
      price: 10.0,
      discount: 0,
      title: "Giay the thao",
      userId: "",
      numOfItem: 1,
      size: 39,
      color: "0xFFF6625E",
      image: ""),
  Cart(
      productId: 1,
      price: 10.0,
      discount: 0,
      title: "Giay the thao",
      userId: "",
      numOfItem: 1,
      size: 38,
      color: "0xFFDECB9C",
      image: ""),
];
