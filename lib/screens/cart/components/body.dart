import 'dart:async';

import 'package:finalprojectmobile/models/Product.dart';
import 'package:finalprojectmobile/models/user.dart';
import 'package:finalprojectmobile/screens/cart/CartController.dart';
import 'package:finalprojectmobile/screens/sign_in/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:finalprojectmobile/models/Cart.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
    required this.user,
  }) : super(key: key);
  final Users user;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  CartController _cartController = Get.find();
  CollectionReference cartCol = FirebaseFirestore.instance.collection('cart');

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    // if (user == null) {
    //   return Center(
    //     child: Container(
    //         width: 250,
    //         height: 50,
    //         child: RaisedButton(
    //           onPressed: () {
    //             Get.to(Login());
    //           },
    //           shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(80.0)),
    //           padding: EdgeInsets.all(0.0),
    //           child: Ink(
    //             decoration: BoxDecoration(
    //                 gradient: LinearGradient(
    //                   colors: [Color(0xfff307c1), Color(0xffff64c6)],
    //                   begin: Alignment.centerLeft,
    //                   end: Alignment.centerRight,
    //                 ),
    //                 borderRadius: BorderRadius.circular(30.0)),
    //             child: Container(
    //               constraints: BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
    //               alignment: Alignment.center,
    //               child: Text(
    //                 "Login",
    //                 textAlign: TextAlign.center,
    //                 style: TextStyle(color: Colors.white, fontSize: 15),
    //               ),
    //             ),
    //           ),
    //         )),
    //   );
    // } else {
    return StreamBuilder<QuerySnapshot>(
        stream: cartCol.where('userId', isEqualTo: user.uid).snapshots(),
        // builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          var dataList = snapshot.data?.docs.map((e) => e.data()).toList();
          List<Cart> lstCart = [];
          dataList?.forEach((element) {
            final Map<String, dynamic> doc = element as Map<String, dynamic>;
            Cart item = Cart(
                productId: doc['productId'],
                title: doc['title'],
                numOfItem: doc['numOfItem'],
                size: doc['size'],
                color: doc['color'],
                image: doc['image'],
                userId: doc['userId'],
                price: doc['price'],
                discount: doc['discount']);
            lstCart.add(item);
          });
          print('length');
          print(lstCart.length);
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(10)),
            child: ListView.builder(
              // itemCount: _cartController.lstC.length,
              itemCount: lstCart.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  // onDismissed: (direction) {
                  //   setState(() async {
                  //     // lstCart.removeAt(index);
                  //     await _deleteItemCart(lstCart[index]);
                  //     // _cartController.removeAt(index);
                  //   });
                  // },
                  onDismissed: (direction) async {
                      await _deleteItemCart(lstCart[index]);
                  },
                  background: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFE6E6),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Spacer(),
                        SvgPicture.asset("assets/icons/Trash.svg"),
                      ],
                    ),
                  ),
                  child: CartCard(cart: lstCart[index]),
                ),
              ),
            ),
          );
        });
    // }
  }

  Future<String> _deleteItemCart(Cart cart) async {
    String cartId = "";
    await FirebaseFirestore.instance
        .collection('cart')
        .where('userId', isEqualTo: cart.userId)
        .where('color', isEqualTo: cart.color)
        .where('size', isEqualTo: cart.size)
        .where('productId', isEqualTo: cart.productId)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        cartId = doc.id;
      });
    });

    // Call the user's CollectionReference to add a new user
    if (cartId != "") {
      await cartCol.doc(cartId).delete().then((value) {
        print('delete successful');
        _cartController.removeListOrder(cart);
        return 'delete successful';
      }).catchError((error) => print("Failed to add user: $error"));
    }
    return "";
  }
}
