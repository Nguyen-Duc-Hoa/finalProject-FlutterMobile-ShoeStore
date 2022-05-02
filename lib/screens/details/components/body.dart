import 'package:final_project_mobile/constants.dart';
import 'package:final_project_mobile/screens/details/components/rating.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:final_project_mobile/components/default_button.dart';
import 'package:final_project_mobile/models/Product.dart';
import 'package:final_project_mobile/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatelessWidget {
  final Product product;

  const Body({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> lstImage = product.images.getRange(0, 4).toList();
    // ignore: avoid_print
    print((product.images.length / 5).round());
    return ListView(
      children: [
        ProductImages(
          product: product,
          lstImage: lstImage,
        ),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ColorDots(product: product),
              ProductDescription(
                product: product,
                pressOnSeeMore: () {},
              ),
              TopRoundedContainer(
                color: Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20),
                        vertical: 10,
                      ),
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text: "Chọn loại hàng",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87),
                                    children: [
                                      TextSpan(
                                        text:
                                            " (${(product.colors.length)} Màu, kích thước)",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: kSecondaryColor),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(width: 40),
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return ModalBottomCart(
                                              product: product);
                                        });
                                  },
                                  child: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ...List.generate(
                                    product.colors.length,
                                    (index) => index * 5 < product.images.length
                                        ? Container(
                                            margin: EdgeInsets.only(right: 15),
                                            padding: EdgeInsets.all(8),
                                            height:
                                                getProportionateScreenWidth(48),
                                            width:
                                                getProportionateScreenWidth(48),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Image.asset(
                                                product.images[index * 5]),
                                          )
                                        : Container()),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Container(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(10)),
                            child: Rating(),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ModalBottomCart extends StatelessWidget {
  const ModalBottomCart({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
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
                        // color: Color(0xFFF5F6F9),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Image.asset(product.images[0]),
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
                          "đ${product.price.toString()}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, color: kPrimaryColor),
                        ),
                        Text.rich(
                          TextSpan(
                            text: "Kho: ",
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: kSecondaryColor),
                            children: [
                              TextSpan(
                                text: "${product.price}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: kSecondaryColor),
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
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
