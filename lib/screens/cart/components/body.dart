import 'dart:async';

import 'package:final_project_mobile/models/Product.dart';
import 'package:final_project_mobile/models/user.dart';
import 'package:final_project_mobile/screens/cart/CartController.dart';
import 'package:final_project_mobile/screens/sign_in/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:final_project_mobile/models/Cart.dart';
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

  // late Stream<List<Cart>> cartsStream;
  //
  // Future<Cart> generateCart(dynamic item) async {
  //   // await PlatformStringCryptor().decrypt(memo.data['title'], _key);
  //   var a;
  //   await FirebaseFirestore.instance
  //       .collection('products')
  //       .where('id', isEqualTo: item.id)
  //       .get()
  //       .then((QuerySnapshot querySnapshot) {
  //     if (querySnapshot.docs.length > 0) {
  //       a = querySnapshot.docs[0].data();
  //       print(1);
  //       // rest of your code
  //     }
  //   });
  //
  //   Cart cart = Cart(
  //       productId: item.id,
  //       title: item.title,
  //       numOfItem: item.numOfItem,
  //       size: item.size,
  //       color: item.color,
  //       image: item.image,
  //       userId: item.userId,
  //       price: item.price,
  //       discount: item.discount);
  //   Product product = Product(
  //       id: a.id,
  //       images: [],
  //       colors: [],
  //       size: a.size,
  //       gender: a.gender,
  //       disCount: a.disCount,
  //       title: a.title,
  //       price: a.price,
  //       description: a.description);
  //   cart.product = product;
  //   return cart;
  // }
  // @override
  // void initState() {
  //   cartsStream = cart
  //       .where('userId', isEqualTo: widget.user.uid)
  //       .snapshots()
  //       .asyncMap((carts) =>
  //           Future.wait([for (var item in carts.docs) generateCart(item)]));
  //   super.initState();
  // }

  Future<Product> getProduct(int pid) async {
    var a;
    await FirebaseFirestore.instance
        .collection('products')
        .where('id', isEqualTo: pid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.length > 0) {
        a = querySnapshot.docs[0].data();
        print(1);
        // rest of your code
      }
    });

    print(2);
    return Product(
        id: 4,
        images: ['images'],
        colors: ['colors'],
        size: [1],
        gender: 1,
        disCount: 0,
        title: 'snar pham 1',
        price: 0.0,
        description: 'description');
  }

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
                  key: Key(
                      // _cartController.lstC[index].productId.toString()),
                      lstCart[index].productId.toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    setState(() {
                      // lstCart.removeAt(index);
                      _deleteItemCart(lstCart[index]);
                      // _cartController.removeAt(index);
                    });
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
        // _cartController.removeListOrder(cart);
        return 'delete successful';
      }).catchError((error) => print("Failed to add user: $error"));
    }
    return "";
  }
}
