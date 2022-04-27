

import 'package:final_project_mobile/models/OrderItem.dart';

class Order{
  final String id;
  final String userId;
  final List<OrderItem> items;
  final DateTime datetime;
  final String phone;
  final int payment;
  final String address;
  final double total;
  final int voucherId;
  final int discount;
  final String status;
  final String name;
  Order({required this.id,
    required this.userId,
    required this.items,
    required this.datetime,
    required this.phone,
    required this.payment,
    required this.total,
    required this.address,
    required this.voucherId,
    required this.discount,
    required this.status,
    required this.name
  });
}
List<Order> orders=[
  Order(id: 'awueter162432', userId: 'ancbhdgyse', items: orderitems, datetime: DateTime.now(),
      phone: '09384692623', payment: 0, total: 550.34, address: 'Thủ Đức, TPHCM', voucherId: 1,
      discount: 0, status: 'Đang giao',name:'Nguyễn Thị Bích Phương'),

];

