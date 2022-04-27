
import 'dart:core';
import 'package:flutter/material.dart';

import 'OrderItem.dart';


class Order {
  final String id;
  final int userId;
  final String name;
  late final List<OrderItem> items;
  final DateTime datetime;
  final String phone;
  final String payment;
  final double total;
  final String address;
  final int status;
  final String voucherId;
  final double discount;

  Order({required this.id,
    required this.userId,
    required this.name,
    required this.datetime,
    required this.phone,
    required this.payment,
    required this.total,
    required this.address,
    required this.voucherId,
    required this.discount,
    required this.status});
}


List<Order> demoOrder = [
  Order(id: "#ABCDE",
      userId: 1,
      name: "Nguyen Duc Hoa",
      datetime: DateTime.now(),
      phone: "0123456789",
      payment: "payment",
      total: 401.00,
      address: "165 1st, Pham Van Dong, HCM",
      voucherId: "",
      discount: 0,
      status: 0),
  Order(id: "#DEFGH",
      userId: 1,
      name: "Nguyen Duc Hoa",
      datetime: DateTime.now(),
      phone: "0123456789",
      payment: "payment",
      total: 100.00,
      address: "165 1st, Pham Van Dong, HCM",
      voucherId: "",
      discount: 0,
      status: 0),
  Order(id: "#ABCDE",
      userId: 1,
      name: "Nguyen Duc Hoa",
      datetime: DateTime.now(),
      phone: "0123456789",
      payment: "payment",
      total: 401.00,
      address: "165 1st, Pham Van Dong, HCM",
      voucherId: "",
      discount: 0,
      status: 1),
  Order(id: "#ABCDE",
      userId: 1,
      name: "Nguyen Duc Hoa",
      datetime: DateTime.now(),
      phone: "0123456789",
      payment: "payment",
      total: 401.00,
      address: "165 1st, Pham Van Dong, HCM",
      voucherId: "",
      discount: 0,
      status: 2),
  Order(id: "#ABCDE",
      userId: 1,
      name: "Nguyen Duc Hoa",
      datetime: DateTime.now(),
      phone: "0123456789",
      payment: "payment",
      total: 401.00,
      address: "165 1st, Pham Van Dong, HCM",
      voucherId: "",
      discount: 0,
      status: 3)
];

