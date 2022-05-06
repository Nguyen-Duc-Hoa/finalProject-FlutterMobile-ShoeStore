
import 'dart:core';
import 'package:flutter/material.dart';

import 'OrderItem.dart';


class Order {
  final String id;
  final String userId;
  final String name;

  final DateTime orderDate;
  final String phone;
  final String payment;
  final num total;
  final String address;
  final int status;
  final String voucherId;
  final num voucherValue;


  Order({required this.id,
    required this.userId,
    required this.name,
    required this.orderDate,
    required this.phone,
    required this.payment,
    required this.total,
    required this.address,
    required this.voucherId,
    required this.voucherValue,
    required this.status});
}


// List<Order> demoOrder = [
//   Order(id: "#ABCDE",
//       userId: 1,
//       name: "Nguyen Duc Hoa",
//       datetime: DateTime.now(),
//       phone: "0123456789",
//       payment: "payment",
//       total: 401.00,
//       address: "165 1st, Pham Van Dong, HCM",
//       voucherId: "",
//       discount: 0,
//       status: 0),
//   Order(id: "#DEFGH",
//       userId: 1,
//       name: "Nguyen Duc Hoa",
//       datetime: DateTime.now(),
//       phone: "0123456789",
//       payment: "payment",
//       total: 100.00,
//       address: "165 1st, Pham Van Dong, HCM",
//       voucherId: "",
//       discount: 0,
//       status: 0),
//   Order(id: "#ABCDE",
//       userId: 1,
//       name: "Nguyen Duc Hoa",
//       datetime: DateTime.now(),
//       phone: "0123456789",
//       payment: "payment",
//       total: 401.00,
//       address: "165 1st, Pham Van Dong, HCM",
//       voucherId: "",
//       discount: 0,
//       status: 1),
//   Order(id: "#ABCDE",
//       userId: 1,
//       name: "Nguyen Duc Hoa",
//       datetime: DateTime.now(),
//       phone: "0123456789",
//       payment: "payment",
//       total: 401.00,
//       address: "165 1st, Pham Van Dong, HCM",
//       voucherId: "",
//       discount: 0,
//       status: 2),
//   Order(id: "#ABCDE",
//       userId: 1,
//       name: "Nguyen Duc Hoa",
//       datetime: DateTime.now(),
//       phone: "0123456789",
//       payment: "payment",
//       total: 401.00,
//       address: "165 1st, Pham Van Dong, HCM",
//       voucherId: "",
//       discount: 0,
//       status: 3)
// ];

