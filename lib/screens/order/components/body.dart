import 'package:final_project_mobile/models/Order.dart';
import 'package:final_project_mobile/screens/cart/CartController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:final_project_mobile/models/Cart.dart';
import 'package:get/get.dart';
import 'package:final_project_mobile/screens/cart/components/cart_card.dart';
import 'package:rating_dialog/rating_dialog.dart';
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

  void _showRatingAppDialog() {
    final _ratingDialog = RatingDialog(
        initialRating: 5.0,
        title: Text(
          'Đánh giá',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        message: Text(
          'Hãy cho chúng tôi biết sự hài lòng của bạn về sản phẩm này nhé ',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 15),
        ),
        submitButtonText: 'Submit',
        onCancelled: () => print('cancelled'),
        onSubmitted: (response) {
          print('rating: ${response.rating}, '
              'comment: ${response.comment}');
        });

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _ratingDialog,
    );
  }

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
          child: Card(
            color: Color(0xEDF3F3F3),
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
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black87),
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
                  if (widget.status == 3)
                    Padding(
                        padding: EdgeInsets.only(top: 10, right: 10, left: 10),
                        child: FlatButton(
                          onPressed: () {
                            _showRatingAppDialog();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.deepOrangeAccent,
                                borderRadius: BorderRadius.circular(10)),
                            height: 50,
                            child: Center(
                              child: Text(
                                'Đánh giá',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
