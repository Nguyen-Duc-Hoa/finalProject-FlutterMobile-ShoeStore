import 'package:finalprojectmobile/screens/details/details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finalprojectmobile/components/product_card.dart';
import 'package:finalprojectmobile/models/Product.dart';

import '../../../size_config.dart';
import 'section_title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PopularProducts extends StatelessWidget {
  PopularProducts({Key? key}) : super(key: key);

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var products = FirebaseFirestore.instance
      .collection('products')
      .orderBy('rate', descending: true);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: products.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return Text("Loading");
          // }
          var dataList = snapshot.data?.docs.map((e) => e.data()).toList();
          List<Product> lstProduct = [];
          dataList?.forEach((element) {
            List<String> images;
            final Map<String, dynamic> doc = element as Map<String, dynamic>;
            images = doc["images"]?.cast<String>();
            List<Color> colors = doc["colors"].cast<Color>();
            List<int> lstSize;
            lstSize = doc["size"]?.cast<int>();
            Product p = Product(
                id: doc["id"],
                images: images,
                colors: doc["colors"].cast<String>(),
                title: doc["title"].toString(),
                price: doc["price"].toDouble(),
                description: doc["description"].toString(),
                disCount: doc["discount"],
                gender: doc["gender"],
                rating: doc["rate"].toDouble(),
                size: lstSize);
            lstProduct.add(p);
          });

          print(lstProduct.length);

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: SectionTitle(title: "Popular Products", press: () {}),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...List.generate(
                      lstProduct.length,
                      (index) {
                        // if (demoProducts[index].isPopular)
                        return ProductCard(
                            product: lstProduct[index],
                            sPopular: "popular",
                            press: () => Navigator.pushNamed(
                                context, DetailsScreen.routeName));

                        // return SizedBox
                        //     .shrink(); // here by default width and height is 0
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
