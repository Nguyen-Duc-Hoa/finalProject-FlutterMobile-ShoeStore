import 'package:final_project_mobile/components/default_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:final_project_mobile/models/Product.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key? key,
    required this.product,
    this.pressOnSeeMore,
  }) : super(key: key);

  final Product product;
  final GestureTapCallback? pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Text(
            product.title,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(15)),
            width: getProportionateScreenWidth(64),
            decoration: BoxDecoration(
              color:
                  product.isFavourite ? Color(0xFFFFE6E6) : Color(0xFFF5F6F9),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: SvgPicture.asset(
              "assets/icons/Heart Icon_2.svg",
              color:
                  product.isFavourite ? Color(0xFFFF4848) : Color(0xFFDBDEE4),
              height: getProportionateScreenWidth(16),
            ),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(
              left: getProportionateScreenWidth(20),
              right: getProportionateScreenWidth(64),
            ),
            child: DescriptionText(text: product.description)
            // Text(
            //   product.description,
            //   maxLines: 3,
            // ),
            ),

      ],
    );
  }
}

class DescriptionText extends StatefulWidget {
  final String text;

  const DescriptionText({required this.text});

  @override
  DescriptionTextState createState() => DescriptionTextState();
}

class DescriptionTextState extends State<DescriptionText> {
  late String firstHalf;
  late String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 50) {
      firstHalf = widget.text.substring(0, 50);
      secondHalf = widget.text.substring(50, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: secondHalf.isEmpty
          ? Text(firstHalf)
          : Column(
              children: <Widget>[
                Text(flag ? (firstHalf + "...") : (firstHalf + secondHalf)),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      flag
                          ? Row(
                              children: const [
                                Text(
                                  "Xem thêm",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: kPrimaryColor),
                                ),
                                SizedBox(width: 5),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 12,
                                  color: kPrimaryColor,
                                ),
                              ],
                            )
                          : Row(
                        children: const [
                          Icon(
                            Icons.arrow_back_ios,
                            size: 12,
                            color: kPrimaryColor,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Thu gọn",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, color: kPrimaryColor),
                          ),

                        ],
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),
              ],
            ),
    );
  }
}
