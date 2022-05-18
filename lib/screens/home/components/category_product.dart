import 'package:finalprojectmobile/models/mCategories.dart';
import 'package:finalprojectmobile/screens/details/details_screen.dart';
import 'package:finalprojectmobile/screens/home/components/categories.dart';
import 'package:finalprojectmobile/screens/more/more_screen.dart';
import 'package:flutter/material.dart';
import 'package:finalprojectmobile/components/product_card.dart';
import 'package:finalprojectmobile/models/Product.dart';

import '../../../size_config.dart';
import 'section_title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:finalprojectmobile/screens/home/HomeController.dart';

class CategoryProducts extends StatefulWidget {
  CategoryProducts({Key? key, required this.category, required this.gender})
      : super(key: key);

  final mCategories category;
  final Gender gender;

  @override
  State<CategoryProducts> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var products;

  HomeController c = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    products = FirebaseFirestore.instance
        .collection('products')
        .orderBy('title')
        .where("category", isEqualTo: widget.category.id)
        .where('gender', isEqualTo: widget.gender.id);
  }

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
            List<String> sColors = doc["colors"].cast<String>();
            List<int> lstSize;
            lstSize = doc["size"]?.cast<int>();
            Product p = Product(
                id: doc["id"],
                images: images,
                colors: sColors,
                title: doc["title"].toString(),
                price: doc["price"].toDouble(),
                description: doc["description"].toString(),
                category: doc["category"],
                disCount: doc["discount"],
                gender: doc["gender"],
                size: lstSize);
            lstProduct.add(p);
          });

          if (lstProduct.isEmpty) {
            return const SizedBox.shrink();
          }

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: SectionTitle(
                    title: widget.category.name,
                    press: () {
                      Get.to(MoreScreen(
                        gender: widget.gender,
                        categories: widget.category,
                      ));
                    }),
              ),
              SizedBox(height: getProportionateScreenWidth(20)),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(
                      lstProduct.length,
                      (index) {
                        if (lstProduct[index].category == widget.category.id) {
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
