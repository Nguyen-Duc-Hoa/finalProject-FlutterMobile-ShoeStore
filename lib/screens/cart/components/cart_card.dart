import 'package:final_project_mobile/screens/cart/CartController.dart';
import 'package:final_project_mobile/screens/home/components/icon_btn_with_counter.dart';
import 'package:flutter/material.dart';
import 'package:final_project_mobile/models/Cart.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:final_project_mobile/models/Cart.dart';

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

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
            value: value1,
            activeColor: kPrimaryColor,
            onChanged: (value) {
              setState(() {
                value1 = !value1;
                if(value1){
                  _cartController.addListOrder(widget.cart);
                }
                else{
                  _cartController.removeListOrder(widget.cart);
                }
              });
            }),
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.cart.product.title,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                maxLines: 2,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text.rich(
                    TextSpan(
                      text: "\$${widget.cart.product.price}",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: kPrimaryColor),
                      children: [
                        TextSpan(
                            text: " x${widget.cart.numOfItem}",
                            style: Theme.of(context).textTheme.bodyText1),
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
                      _cartController.decreaseQuantity(widget.cart);
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
                      _cartController.increaseQuantity(widget.cart);
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
}
