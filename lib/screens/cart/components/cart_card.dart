import 'package:final_project_mobile/models/Product.dart';
import 'package:final_project_mobile/screens/cart/CartController.dart';
import 'package:final_project_mobile/screens/home/components/icon_btn_with_counter.dart';
import 'package:flutter/material.dart';
import 'package:final_project_mobile/models/Cart.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:final_project_mobile/common.dart';
import 'package:final_project_mobile/models/Cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class CartCard extends StatefulWidget {
  const CartCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  CartController _cartController = Get.find();
  bool value1 = false;

  Common _common = new Common();

  var fproduct = FirebaseFirestore.instance.collection('products');
  CollectionReference cartCol = FirebaseFirestore.instance.collection('cart');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream:
            fproduct.where('id', isEqualTo: widget.cart.productId).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('something was wrong');
          }
          // if (snapshot.connectionState == ConnectionState.waiting)
          //   return Text('Loading');

          // var data = snapshot.data?.docs.first.data();
          // late Map<String, dynamic> doc = data as Map<String, dynamic>;
          // print(widget.cart.productId);
          // print(111111111111111);
          // // if(doc.length == 1){

          List<Product> lstProduct = [];
          var dataList = snapshot.data?.docs.map((e) => e.data()).toList();
          List<Cart> lstCart = [];
          dataList?.forEach((element) {
            final Map<String, dynamic> doc = element as Map<String, dynamic>;
            Product product = Product(
                id: doc['id'] ?? 0,
                images: [],
                colors: [],
                size: [],
                gender: doc['gender'],
                disCount: doc['disCount'],
                title: doc['title'],
                price: double.parse(doc['price'].toString()),
                description: doc['description']);
            lstProduct.add(product);
          });

          if (lstProduct.isEmpty) {
            return SizedBox.shrink();
          } else {
            Product product = lstProduct[0];

            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                    value: value1,
                    activeColor: kPrimaryColor,
                    onChanged: (value) {
                      setState(() {
                        value1 = !value1;
                        if (value1) {
                          _cartController.addListOrder(widget.cart, product);
                        } else {
                          _cartController.removeListOrder(widget.cart);
                        }
                      });
                    }),
                SizedBox(
                  width: 88,
                  child: AspectRatio(
                    aspectRatio: 0.88,
                    child: Container(
                        padding:
                            EdgeInsets.all(getProportionateScreenWidth(10)),
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F6F9),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Image.asset(widget.cart.image)),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                        maxLines: 2,
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text.rich(
                            TextSpan(
                              text: _common.formatCurrency(product.price),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: kPrimaryColor),
                              children: [
                                TextSpan(
                                    text: " x${widget.cart.numOfItem}",
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => setState(() {
                              // _cartController.decreaseQuantity(widget.cart);
                              _changeQuantity(widget.cart, product, -1);
                            }),
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(
                                      getProportionateScreenWidth(4))),
                              child: Icon(
                                Icons.remove,
                                color: Colors.white,
                                size: getProportionateScreenWidth(13),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenHeight(8)),
                            child: Text(
                              "${widget.cart.numOfItem}",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(14),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => setState(() {
                              _changeQuantity(widget.cart, product, 1);
                            }),
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(
                                      getProportionateScreenWidth(4))),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: getProportionateScreenWidth(13),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            );
          }
        });
  }

  Future<String> _changeQuantity(
      Cart cart, Product product, int quantity) async {
    String cartId = "";
    if (cart.numOfItem + quantity == 0 || cart.numOfItem + quantity > 50) {
      return "";
    }
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
      print(3);
      await cartCol.doc(cartId).update({
        'userId': cart.userId,
        "productId": cart.productId, // John Doe
        'image': cart.image, // Stokes and Sons
        'numOfItem': cart.numOfItem + quantity, // 42
        // 'size': cart.size,
        'color': cart.color
      }).then((value) {
        print('change quantity cart');
        _cartController.updateQuantity(cart, product, quantity);
        return 'change quantity cart';
      }).catchError((error) => print("Failed to add user: $error"));
    }
    return "";
  }
}
