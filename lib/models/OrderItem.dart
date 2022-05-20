import 'package:flutter/material.dart';

class OrderItem {
  final String orderId;
  final int productId;
  final String productName;
  final String image;
  final int quantity;
  final num price;
  final int size;
  final String color;
  final bool comment;
  OrderItem(
      {required this.orderId,
      required this.productId,
      required this.productName,
      required this.image,
      required this.price,
      required this.color,
      required this.size,
      required this.quantity,
      required this.comment});
}



// List<OrderItem> orderitems=[
// OrderItem(orderId: 'awueter162432', productId: 1, productName: 'Nike Sport White - Man Pant', image: 'assets/images/shoe1.png',
//     quantity: 1, price: 50.5, size: 36, color: Color(0xFFF6625E)),
//   OrderItem(orderId: 'awueter162432', productId: 2, productName: 'Gloves XC Omega - Polygon', image: 'assets/images/shoe1.png',
//       quantity: 2, price: 64.99, size: 40, color: Color(0xFF836DB8)),
// ];


