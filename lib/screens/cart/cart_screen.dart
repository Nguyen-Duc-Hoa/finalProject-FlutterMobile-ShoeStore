import 'package:finalprojectmobile/constants.dart';
import 'package:finalprojectmobile/models/user.dart';
import 'package:finalprojectmobile/screens/cart/CartController.dart';
import 'package:finalprojectmobile/size_config.dart';
import 'package:flutter/material.dart';
import 'package:finalprojectmobile/models/Cart.dart';
import 'package:get/get.dart';

import 'components/body.dart';
import 'components/check_out_card.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<Users>(context);
    SizeConfig().init(context);
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(user: user),
      bottomNavigationBar: CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    CartController _cartController = Get.put(CartController());
    return AppBar(
      backgroundColor: kPrimaryColor,
      title: GetBuilder<CartController>(
        builder: (s) {
          return Column(
            children: [
              Text(
                AppLocalizations.of(context)!.cart,
                style: TextStyle(color: Colors.white),
              ),
              Text(
                AppLocalizations.of(context)!.inCart(_cartController.numberCart.value),
                style: TextStyle(color: Colors.white, fontSize: 15),

              ),
            ],
          );
        }
      ),
    );
  }
}
