import 'package:finalprojectmobile/models/user.dart';
import 'package:finalprojectmobile/screens/cart/CartController.dart';
import 'package:finalprojectmobile/screens/cart/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/Cart.dart';
import '../../../size_config.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class HomeHeader extends StatefulWidget {
  HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  CartController _cartController = Get.put(CartController());
  CollectionReference carts = FirebaseFirestore.instance.collection('cart');

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    // int numOfItem = 0;
    // if (user != null) {
    //   CollectionReference cart = FirebaseFirestore.instance.collection('cart');
    //   cart
    //       .where('userId', isEqualTo: user.uid)
    //       .get()
    //       .then((QuerySnapshot querySnapshot) {
    //     querySnapshot.docs.forEach((doc) {
    //       numOfItem = numOfItem + 1;
    //     });
    //     print(numOfItem);
    //   });
    // }
    if (user != null) {
      return StreamBuilder<QuerySnapshot>(
          stream: carts.where('userId', isEqualTo: user.uid).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              _cartController.setNumCart(0);
            }

            int numbercart = 0;
            var dataList = snapshot.data?.docs.map((e) => e.data()).toList();
            List<Cart> lstCart = [];
            dataList?.forEach((element) {
              numbercart++;
            });
            _cartController.setNumCart(numbercart);
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SearchField(),
                  Obx(
                    () => IconBtnWithCounter(
                      svgSrc: "assets/icons/Cart Icon.svg",
                      numOfItem: _cartController.numberCart.value,
                      press: () async => {
                        Get.to(CartScreen()),
                        _cartController.resetListOrder(),
                      },
                    ),
                  ),
                ],
              ),
            );
          });
    } else {
      return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SearchField(),
            IconBtnWithCounter(
              svgSrc: "assets/icons/Cart Icon.svg",
              numOfItem: 0,
              press: () async => {
                Get.to(CartScreen()),
                _cartController.resetListOrder(),
              },
            ),
          ],
        ),
      );
    }
  }
}
