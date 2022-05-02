import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../size_config.dart';


class IconBtnWithCounter extends StatelessWidget {
  const IconBtnWithCounter({
    Key? key, required this.svgSrc,
    this.numOfItem = 0,
    required this.press,
  }) : super(key: key);

  final String svgSrc;
  final int? numOfItem;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      borderRadius: BorderRadius.circular(100),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
              padding:
              EdgeInsets.all(getProportionateScreenWidth(12)),
              height: getProportionateScreenHeight(46),
              width: getProportionateScreenWidth(46),
              decoration: BoxDecoration(
                  color: kPrimaryLightColor.withOpacity(0.3),
                  shape: BoxShape.circle),
              child:
              SvgPicture.asset(svgSrc)),
          if(numOfItem != 0)
            Positioned(
              top: -3,
              right: 0,
              child: Container(
                width: getProportionateScreenWidth(16),
                height: getProportionateScreenHeight(16),
                decoration: BoxDecoration(
                    color: const Color(0xFFFF4848),
                    shape: BoxShape.circle,
                    border:
                    Border.all(width: 1.5, color: Colors.white)),
                child: Center(
                    child: Text(
                      "$numOfItem",
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(10),
                          height: 1,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    )),
              ),
            )
        ],
      ),
    );
  }
}