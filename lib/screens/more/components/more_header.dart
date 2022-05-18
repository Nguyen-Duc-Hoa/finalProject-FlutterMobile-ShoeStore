import 'package:finalprojectmobile/screens/cart/CartController.dart';
import 'package:finalprojectmobile/screens/cart/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../size_config.dart';
import 'search_field.dart';

class MoreHeader extends StatelessWidget {
  MoreHeader({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(),
        ],
      ),
    );
  }
}
