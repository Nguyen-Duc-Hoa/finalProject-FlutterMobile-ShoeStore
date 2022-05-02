import 'package:final_project_mobile/screens/home/components/category_product.dart';
import 'package:final_project_mobile/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:final_project_mobile/screens/home/components/categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'special_offers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:final_project_mobile/models/mCategories.dart';
import 'package:final_project_mobile/screens/cart/CartController.dart';
import 'package:get/get.dart';

class Body extends StatelessWidget {
  Body({Key? key}) : super(key: key);
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference category =
      FirebaseFirestore.instance.collection('categories');
  List<mCategories> lstCate = demoType;
  int selectedIndex = 0;

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
                  // SizedBox(
                  //   height: getProportionateScreenWidth(20),
                  // ),
                  // HomeHeader(),
                  SizedBox(
                    height: getProportionateScreenWidth(30),
                  ),
                  DiscountBanner(),
                  Categories(),
                  SizedBox(
                    height: getProportionateScreenHeight(50),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: lstCate.length,
                      itemBuilder: (context, index) =>
                          buildCategory(context, index),
                    ),
                  ),
                  SpecialOffers(),
                  SizedBox(height: getProportionateScreenWidth(30)),
                  PopularProducts(),
                  SizedBox(height: getProportionateScreenHeight(30)),
                  ...List.generate(lstCategories.length, (index) {
                    return CategoryProducts(category: lstCategories[index]);
                  }),
                ],
              ),
            ),
          );
        });
  }

  Widget buildCategory(BuildContext context, int index) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            demoType[index].name,
            style: TextStyle(fontWeight: FontWeight.bold, color: selectedIndex == index ? Colors.black : Color(0xFF656464)),
          ),
          Container(
            margin: EdgeInsets.only(top: getProportionateScreenWidth(10) / 4),
            height: getProportionateScreenHeight(3),
            width: getProportionateScreenWidth(30),
            color:selectedIndex == index ? Colors.black : Colors.transparent   ,
          )
        ],
      ),
    );
  }
}
