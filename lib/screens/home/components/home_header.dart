import 'package:final_project_mobile/screens/cart/CartController.dart';
import 'package:final_project_mobile/screens/cart/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../size_config.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  HomeHeader({
    Key? key,
  }) : super(key: key);

  CartController _cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(),
          Obx(
            () => IconBtnWithCounter(
              svgSrc: "assets/icons/Cart Icon.svg",
              numOfItem: _cartController.lstC.length,
              press: () =>
                  {Get.to(CartScreen()), _cartController.resetListOrder()},
            ),
          ),
        ],
      ),
    );
  }
}
