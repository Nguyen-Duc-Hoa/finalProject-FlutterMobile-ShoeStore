import 'package:final_project_mobile/screens/home/components/category_product.dart';
import 'package:final_project_mobile/size_config.dart';
import 'package:flutter/material.dart';

import 'package:final_project_mobile/screens/home/components/categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'special_offers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:final_project_mobile/models/mCategories.dart';

class Body extends StatelessWidget {
  Body({Key? key}) : super(key: key);

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference category =
  FirebaseFirestore.instance.collection('categories');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: category.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          var dataList = snapshot.data?.docs.map((e) => e.data()).toList();
          List<mCategories> lstCategories = [];
          dataList?.forEach((element) {
            final Map<String, dynamic> doc = element as Map<String, dynamic>;
            mCategories cate = mCategories(id: doc["id"], name: doc["name"]);

            lstCategories.add(cate);
          });
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: getProportionateScreenWidth(20),
                  ),
                  HomeHeader(),
                  SizedBox(
                    height: getProportionateScreenWidth(30),
                  ),
                  DiscountBanner(),
                  Categories(),
                  SpecialOffers(),
                  SizedBox(height: getProportionateScreenWidth(30)),
                  PopularProducts(),
                  SizedBox(height: getProportionateScreenWidth(30)),
                  ...List.generate(
                      lstCategories.length,
                          (index) {
                        return CategoryProducts(category: lstCategories[index]);
                      }

                  ),
                ],
              ),
            ),
          );
        });
  }
}
