import 'package:finalprojectmobile/constants.dart';
import 'package:finalprojectmobile/models/user.dart';
import 'package:finalprojectmobile/screens/cart/CartController.dart';
import 'package:finalprojectmobile/size_config.dart';
import 'package:flutter/material.dart';
import 'package:finalprojectmobile/models/Cart.dart';
import 'package:get/get.dart';

import '../sign_in/login_screen.dart';
import 'components/body.dart';
import 'components/check_out_card.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<Users>(context);
    SizeConfig().init(context);
    if(user==null)
      {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            title: Text('Giỏ hàng'),
          ),
          backgroundColor: Colors.white,
          body: Center(

            child: Container(
                width: 250,
                height: 50,
                child:    RaisedButton(
                  onPressed: () {
                    Get.to(Login());
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFFC560A), Color(0xFFFCA931)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Container(
                      constraints:
                      BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Login",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                )


            ),
          ),
        );
      }
    else
      {
        return Scaffold(
          appBar: buildAppBar(context),
          body: Body(user: user),
          bottomNavigationBar: CheckoutCard(),
        );
      }

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
                "Giỏ hàng",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "${_cartController.numberCart} sản phẩm",
                style: TextStyle(color: Colors.white, fontSize: 15),

              ),
            ],
          );
        }
      ),
    );
  }
}
