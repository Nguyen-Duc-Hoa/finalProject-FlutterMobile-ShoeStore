import 'package:final_project_mobile/models/mCategories.dart';
import 'package:final_project_mobile/screens/details/details_screen.dart';
import 'package:final_project_mobile/screens/home/components/categories.dart';
import 'package:final_project_mobile/screens/more/more_screen.dart';
import 'package:flutter/material.dart';
import 'package:final_project_mobile/components/product_card.dart';
import 'package:final_project_mobile/models/Product.dart';

import '../../../size_config.dart';
import 'section_title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:final_project_mobile/screens/home/HomeController.dart';

class CategoryProducts extends StatelessWidget {
  CategoryProducts({Key? key, required this.category}) : super(key: key);

  final mCategories category;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var products =
      FirebaseFirestore.instance.collection('products').orderBy("title").limit(15);
  HomeController c = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: products.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          var dataList = snapshot.data?.docs.map((e) => e.data()).toList();
          List<Product> lstProduct = [];
          dataList?.forEach((element) {
            List<String> images;
            final Map<String, dynamic> doc = element as Map<String, dynamic>;
            images = doc["images"]?.cast<String>();
            List<String> sColors = doc["colors"].cast<String>();
            List<Color> lstColor = [];
            for (var element in sColors) {
              String valueString = element.split('(0x')[1].split(')')[0];
              int value = int.parse(valueString, radix: 16);
              lstColor.add(Color(value));
            }
            Product p = Product(
                id: doc["id"],
                images: images,
                colors: lstColor,
                title: doc["title"].toString(),
                price: doc["price"],
                description: doc["description"].toString(),
                category: doc["category"]);
            lstProduct.add(p);
          });

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: SectionTitle(title: category.name, press: () {Get.to(MoreScreen());}),
              ),
              SizedBox(height: getProportionateScreenWidth(20)),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(
                      lstProduct.length,
                      (index) {
                        if (lstProduct[index].category == category.id) {
                          return ProductCard(
                              product: lstProduct[index],
                              press: () {
                                c.productDetail(lstProduct[index]);
                                c.SetListImage(lstProduct[index], 0);
                                Get.to(DetailsScreen());
                              });
                        }

                        return const SizedBox
                            .shrink(); // here by default width and height is 0
                      },
                    ),
                    SizedBox(width: getProportionateScreenWidth(20)),
                  ],
                ),
              )
            ],
          );
        });
  }
}
