import 'package:final_project_mobile/components/default_button.dart';
import 'package:final_project_mobile/constants.dart';
import 'package:final_project_mobile/screens/cart/components/check_out_card.dart';
import 'package:final_project_mobile/screens/home/HomeController.dart';
import 'package:final_project_mobile/size_config.dart';
import 'package:flutter/material.dart';

import '../../models/Product.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';
import 'package:get/get.dart';

import 'components/top_rounded_container.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";
  final HomeController _homeController = Get.find();

  DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final ProductDetailsArguments agrs =
    //     ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(rating: _homeController.productDetail.value.rating),
      ),
      body: Body(product: _homeController.productDetail.value),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenWidth(5),
          horizontal: getProportionateScreenWidth(10),
        ),
        // height: 174,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -15),
              blurRadius: 20,
              color: const Color(0xFFDADADA).withOpacity(0.5),
            )
          ],
        ),
        child: SizedBox(
          width: getProportionateScreenWidth(220),
          child: Padding(
            padding: EdgeInsets.only(
              left: SizeConfig.screenWidth * 0.1,
              right: SizeConfig.screenWidth * 0.1,
              bottom: getProportionateScreenWidth(10),
              top: getProportionateScreenWidth(10),
            ),
            child: DefaultButton(
              text: "Thêm giỏ hàng",
              press: () {
                showModalBottomSheet(context: context, builder: (context) {
                  return Container(
                    decoration: BoxDecoration(color: Theme
                        .of(context)
                        .canvasColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),),
                  );
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ProductDetailsArguments {
  final Product product;

  ProductDetailsArguments({required this.product});
}
