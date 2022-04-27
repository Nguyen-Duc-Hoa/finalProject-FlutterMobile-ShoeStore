import 'package:flutter/material.dart';

class OrderItem {
  final String orderId;
  final int productId;
  final String productName;
  final String image;
  final int quantity;
  final double price;
  final String size;
  final Colors color;

  OrderItem(
      {required this.orderId,
        required this.productId,
        required this.productName,
        required this.image,
        required this.price,
        required this.color,
        required this.size,
        required this.quantity});
}