
import 'package:flutter/material.dart';

class Method{
  final int? id;
  final String? name;
  late final bool? isDefault;
  final IconData? icon;
  Method({ this.id, this.name, this.isDefault, this.icon});
}

List<Method> demoMethod = [
  Method(id: 1, name: "Ví ShopshoePay", isDefault: false, icon: Icons.wallet_giftcard),
  Method(id: 2, name: "Thanh toán bằng Paypal", isDefault: false, icon: Icons.credit_card),
  Method(id: 3, name: "Thanh toán khi nhận hàng", isDefault: true, icon: Icons.home)
];