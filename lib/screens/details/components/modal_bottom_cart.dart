import 'dart:collection';

import 'package:finalprojectmobile/common.dart';
import 'package:finalprojectmobile/components/default_button.dart';
import 'package:finalprojectmobile/components/rounded_icon_btn.dart';
import 'package:finalprojectmobile/constants.dart';
import 'package:finalprojectmobile/models/Cart.dart';
import 'package:finalprojectmobile/models/Color.dart';
import 'package:finalprojectmobile/models/Product.dart';
import 'package:finalprojectmobile/models/user.dart';
import 'package:finalprojectmobile/screens/cart/CartController.dart';
import 'package:finalprojectmobile/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:finalprojectmobile/common.dart';

class ModalBottomCart extends StatefulWidget {
  const ModalBottomCart({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  State<ModalBottomCart> createState() => _ModalBottomCartState();
}

class _ModalBottomCartState extends State<ModalBottomCart> {
  int selectedImage = -1;
  int number = 1;
  List<String> imageByColor = [];
  int? value;
  final Common _common = Common();
  final CartController _cartController = Get.find();
  late Cart _cart;

  @override
  void initState() {
    super.initState();
    _cart = Cart(
        productId: widget.product.id,
        title: widget.product.title,
        numOfItem: 1,
        size: -1,
        color: "",
        image: "",
        userId: "",
    price: widget.product.price,
      discount: widget.product.disCount
    );
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Users>(context);
    CollectionReference cartCol = FirebaseFirestore.instance.collection('cart');

    if (imageByColor.isEmpty) {
      for (int i = 0; i < widget.product.colors.length; i++) {
        if (5 * i < widget.product.images.length) {
          imageByColor.add(widget.product.images[5 * i]);
        }
      }
    }

    Future<String> addToCart(Cart cart, String uid) async {
      String cartId = "";
      int oldQuantity = 0;
      await FirebaseFirestore.instance
          .collection('cart')
          .where('userId', isEqualTo: uid)
          .where('color', isEqualTo: cart.color)
          .where('size', isEqualTo: cart.size)
          .where('productId', isEqualTo: cart.productId)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          cartId = doc.id;
          oldQuantity = doc['numOfItem'];
        });
      });

      // Call the user's CollectionReference to add a new user
      if (cartId == "") {
        await cartCol.add({
          'userId': uid,
          "productId": cart.productId, // John Doe
          'image': cart.image, // Stokes and Sons
          'numOfItem': cart.numOfItem, // 42
          'size': cart.size,
          'color': cart.color // 42
        }).then((value) {
          print("User Added");
          return "User Added";
        }).catchError((error) {
          print("Failed to add user: $error");
          return error;
        });
      } else {
        await cartCol.doc(cartId).update({
          'userId': uid,
          "productId": cart.productId, // John Doe
          'image': cart.image, // Stokes and Sons
          'numOfItem': cart.numOfItem + oldQuantity, // 42
          'size': cart.size,
          'color': cart.color
        }).then((value) {
          print('change quantity cart');
          return 'change quantity cart';
        }).catchError((error) => print("Failed to add user: $error"));
      }
      return "";
    }

    return Container(
      decoration: BoxDecoration(
          // color: Theme.of(context).canvasColor,
          color: kSecondaryColor.withOpacity(0.1),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          )),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: getProportionateScreenWidth(10),
                left: getProportionateScreenWidth(20)),
            child: Row(
              children: [
                SizedBox(
                  width: 88,
                  child: AspectRatio(
                    aspectRatio: 0.88,
                    child: Container(
                      decoration: BoxDecoration(
                        // color: Color(int.parse(color1)),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Image.asset(selectedImage != -1
                          ? imageByColor[selectedImage]
                          : widget.product.images[0]),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _common.formatCurrency(widget.product.price),
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: kPrimaryColor,
                              fontSize: 15),
                        ),
                        Text.rich(
                          TextSpan(
                            text: "Kho: ",
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: kSecondaryColor,
                                fontSize: 15),
                            children: [
                              TextSpan(
                                text: "${widget.product.price}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: kSecondaryColor,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Align(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(60),
                      // ),
                      primary: kPrimaryColor,
                      // backgroundColor: Colors.white,
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Icon(Icons.close),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(15)),
                    child: const Text(
                      "Color",
                      style: TextStyle(color: Colors.black87, fontSize: 17),
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenWidth(10),
                      horizontal: getProportionateScreenWidth(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ...List.generate(imageByColor.length,
                          (index) => buildSmallProductPreview(index)),
                    ],
                  ),
                )
              ],
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          Row(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(15)),
                    child: const Text(
                      "Size",
                      style: TextStyle(color: Colors.black87, fontSize: 17),
                    )),
              ),
              Container(
                width: SizeConfig.screenWidth * 0.6,
                height: 45,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black, width: 1)),
                child: DropdownButton<int>(
                  value: value,
                  iconSize: 36,
                  icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                  isExpanded: true,
                  items: widget.product.size.map(buildMenuItem).toList(),
                  onChanged: (value) => setState(() {
                    this.value = value;
                    _cart.size = value!;
                  }),
                ),
              )
            ],
          ),
          const Divider(
            thickness: 1,
          ),
          Row(
            children: [
              Container(
                width: SizeConfig.screenWidth * 0.4,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(15)),
                      child: const Text(
                        "Số lượng",
                        style: TextStyle(color: Colors.black87, fontSize: 17),
                      )),
                ),
              ),
              Row(
                children: [
                  RoundedIconBtn(
                    icon: Icons.remove,
                    showShadow: false,
                    disable:
                        (_cart.color == "" || _cart.size == -1 || number <= 1),
                    press: () {
                      setState(() {
                        number--;
                      });
                    },
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    child: TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      controller:
                          TextEditingController(text: number.toString()),
                      onChanged: (text) {
                        if (int.parse(text) <= 0) {
                        } else {
                          number = int.parse(text);
                        }
                        print(number);
                      },
                      enabled: _cart.size != -1 && _cart.color != "",
                    ),
                  ),
                  RoundedIconBtn(
                      icon: Icons.add,
                      showShadow: true,
                      disable: (_cart.color == "" || _cart.size == -1),
                      press: () {
                        setState(() {
                          number++;
                        });
                      }),
                ],
              ),
            ],
          ),
          Spacer(),
          Container(
              margin: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(10),
                  vertical: getProportionateScreenWidth(5)),
              child: DefaultButton(
                  text: "Thêm giỏ hàng",
                  disable: !(_cart.color != "" && _cart.size != -1),
                  press: () {
                    _cart.numOfItem = number;
                    if (user != null) {
                      addToCart(_cart, user.uid.toString());
                      Navigator.pop(context);
                    }
                  })),
        ],
      ),
    );
  }

  DropdownMenuItem<int> buildMenuItem(int item) => DropdownMenuItem(
      value: item,
      child: Text(
        item.toString(),
        style: TextStyle(color: Colors.black, fontSize: 15),
      ));

  buildSmallProductPreview(int index) {
    mColor nameColor = demoColor
        .where((element) => element.id == widget.product.colors[index])
        .first;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              if (selectedImage == index) {
                selectedImage = -1;
                _cart.color = "";
                _cart.image = "";
              } else {
                selectedImage = index;
                _cart.color = nameColor.id;
                _cart.image = imageByColor[selectedImage];
              }
            });
          },
          child: AnimatedContainer(
            duration: defaultDuration,
            margin: EdgeInsets.only(right: 15),
            padding: EdgeInsets.all(8),
            height: getProportionateScreenWidth(48),
            width: getProportionateScreenWidth(48),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: kPrimaryColor
                      .withOpacity(selectedImage == index ? 1 : 0)),
            ),
            child: Image.asset(imageByColor[index]),
          ),
        ),
        Container(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(5)),
            child: Text(
              nameColor.name,
              style: TextStyle(color: Colors.black87),
            )),
      ],
    );
  }
}
