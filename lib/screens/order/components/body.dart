import 'package:final_project_mobile/models/Order.dart';
import 'package:final_project_mobile/screens/cart/CartController.dart';
import 'package:final_project_mobile/screens/order_detail/order_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:final_project_mobile/models/Cart.dart';
import 'package:get/get.dart';
import 'package:final_project_mobile/screens/cart/components/cart_card.dart';

import '../../../size_config.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.status}) : super(key: key);

  final int status;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  CartController _cartController = Get.find();
  final int page = 1;
  final int num = 10;

  @override
  Widget build(BuildContext context) {
    List<Order> lstResult = demoOrder
        .where((element) => element.status == widget.status)
        .take(num)
        .skip((page - 1) * num)
        .toList();
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
      child: ListView.builder(
        itemCount: lstResult.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: GestureDetector(
            onTap: () {
              Get.to(OrderDetail());
            },
            child: Card(
              color: Colors.grey[200],
              child: Padding(
                padding: EdgeInsets.all(
                  getProportionateScreenWidth(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              lstResult[index].name,
                              style: const TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Ngày đặt: ${lstResult[index].datetime.toString().substring(0, lstResult[index].datetime.toString().lastIndexOf(":"))}",
                              style: TextStyle(color: Colors.black87),

                            ),
                          ],
                        ),
                        // Container(
                        //
                        //    child: const Padding(
                        //
                        //       padding: EdgeInsets.only(right: 1, bottom: 1),
                        //       child: Text("ABCD"),
                        //     ),
                        // ),
                      ],
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Mã đơn",
                                style: TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                lstResult[index].id.toString().padLeft(6, '0'),
                                style: const TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                          const VerticalDivider(
                            thickness: 1,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Tổng tiền",
                                style: TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                "\$${lstResult[index].total}",
                                style: const TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                          VerticalDivider(
                            thickness: 1,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Thanh toán",
                                style: TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                lstResult[index].payment,
                                style: const TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
