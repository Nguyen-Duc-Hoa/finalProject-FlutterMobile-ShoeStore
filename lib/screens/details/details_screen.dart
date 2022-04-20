import 'package:final_project_mobile/screens/home/HomeController.dart';
import 'package:flutter/material.dart';

import '../../models/Product.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';
import 'package:get/get.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";
  HomeController agrs = Get.find();



  @override
  Widget build(BuildContext context) {
    print(agrs);
    // final ProductDetailsArguments agrs =
    //     ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(rating: agrs.productDetail.value.rating),
      ),
      body: Body(product: agrs.productDetail.value),
    );
  }
}

class ProductDetailsArguments {
  final Product product;

  ProductDetailsArguments({required this.product});
}
