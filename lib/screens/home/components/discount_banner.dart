import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import '../../../size_config.dart';

class DiscountBanner extends StatelessWidget{
  const DiscountBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.only(left: 10, right: 10,bottom: 10),
      child: Carousel(

        boxFit: BoxFit.fill,
        images: [
          AssetImage('assets/images/img0.png'),
          AssetImage('assets/images/img1.png'),
          AssetImage('assets/images/img2.png'),
        ],
        autoplay: true,
        indicatorBgPadding:1.0 ,

      ),
    );
  }
}