import 'package:final_project_mobile/screens/voucher/components/coupon_cart.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class VoucherScreen extends StatelessWidget {
  static String routeName = "/voucher";
  const VoucherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Mã giảm giá'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Coupon(),

            ],
          ),
        ),
      ),
    );
  }
}
