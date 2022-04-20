import 'package:final_project_mobile/screens/home/HomeController.dart';
import 'package:flutter/material.dart';
import 'package:final_project_mobile/components/rounded_icon_btn.dart';
import 'package:final_project_mobile/models/Product.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ColorDots extends StatefulWidget {
  ColorDots({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  State<ColorDots> createState() => _ColorDotsState();
}

class _ColorDotsState extends State<ColorDots> {
  int selectedColor = 0;
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    // Now this is fixed and only for demo
    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        children: [
          ...List.generate(
            widget.product.colors.length,
                (index) =>
                buildColorDot(
                  index,
                  widget.product.colors[index],
                  index == selectedColor,
                ),
          ),
          Spacer(),
          RoundedIconBtn(
            icon: Icons.remove,
            press: () {},
          ),
          SizedBox(width: getProportionateScreenWidth(20)),
          RoundedIconBtn(
            icon: Icons.add,
            showShadow: true,
            press: () {},
          ),
        ],
      ),
    );
  }

  GestureDetector buildColorDot(int index, Color color, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = index;
          //homeController.SetListImage(widget.product, index*5);
        });

      },
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: EdgeInsets.only(right: 2),
        padding: EdgeInsets.all(getProportionateScreenWidth(8)),
        height: getProportionateScreenWidth(40),
        width: getProportionateScreenWidth(40),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
              color: index == selectedColor ? kPrimaryColor : Colors.transparent),
          shape: BoxShape.circle,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

// class ColorDot extends StatelessWidget {
//   const ColorDot({
//     Key? key,
//     required this.color,
//     this.isSelected = false,
//     required this.press,
//   }) : super(key: key);
//
//   final Color color;
//   final bool isSelected;
//   final GestureTapCallback press;
//
//   @override
//   Widget build(BuildContext context) {

