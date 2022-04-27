import 'package:final_project_mobile/constants.dart';
import 'package:final_project_mobile/screens/cart/CartController.dart';
import 'package:final_project_mobile/size_config.dart';
import 'package:flutter/material.dart';
import 'package:final_project_mobile/models/Cart.dart';
import 'package:get/get.dart';

import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    CartController _cartController = Get.put(CartController());
    return AppBar(
      backgroundColor: kPrimaryColor,
      title: Column(
        children: [
          Text(
            "Giỏ hàng",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "${_cartController.lstC.length} sản phẩm",
            style: TextStyle(color: Colors.white, fontSize: 15),

          ),
        ],
      ),
    );
  }
}
