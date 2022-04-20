import 'package:final_project_mobile/screens/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:final_project_mobile/components/product_card.dart';
import 'package:final_project_mobile/models/Product.dart';

import '../../../size_config.dart';
import 'section_title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PopularProducts extends StatelessWidget {
  PopularProducts({Key? key}) : super(key: key);

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');

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
            List<Color> colors = doc["colors"].cast<Color>();
            Product p = Product(
                id: doc["id"],
                images: images,
                colors: colors,
                title: doc["title"].toString(),
                price: doc["price"],
                description: doc["description"].toString());
            lstProduct.add(p);
          });

          print(lstProduct);

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: SectionTitle(title: "Popular Products", press: () {}),
              ),
              SizedBox(height: getProportionateScreenWidth(20)),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(
                      lstProduct.length,
                      (index) {
                        if (demoProducts[index].isPopular)
                          return ProductCard(
                              product: demoProducts[index],
                              sPopular: "popular",
                              press: () => Navigator.pushNamed(
                                  context, DetailsScreen.routeName));

                        return SizedBox
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
