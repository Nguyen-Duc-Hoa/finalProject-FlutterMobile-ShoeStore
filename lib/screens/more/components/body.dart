import 'package:final_project_mobile/components/product_card.dart';
import 'package:final_project_mobile/models/Product.dart';
import 'package:final_project_mobile/size_config.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(10),
              horizontal: getProportionateScreenWidth(10)),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: getProportionateScreenWidth(8),
            mainAxisSpacing: getProportionateScreenHeight(2),
            childAspectRatio: (1 / 1.3),
            children: [
              ...List.generate(demoProducts.length, (index) {
                return Container(
                  child: ProductCard(
                      product: demoProducts[index],
                      press: () {
                        // c.productDetail(lstProduct[index]);
                        // c.SetListImage(lstProduct[index], 0);
                        // Get.to(DetailsScreen());
                      }),
                );
                //   return Container(
                //     color: Colors.black,
                //   );
              }),
            ],
          )),
    );
  }
}
