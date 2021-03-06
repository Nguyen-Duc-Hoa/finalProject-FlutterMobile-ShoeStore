import 'package:finalprojectmobile/screens/home/HomeController.dart';
import 'package:flutter/material.dart';
import 'package:finalprojectmobile/models/Product.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.product,
    required this.lstImage,
  }) : super(key: key);

  final Product product;
  final List<String> lstImage;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  late int selectedImage;
  late HomeController _homeController;
  @override
  void initState() {
    super.initState();
    _homeController = Get.find();
    selectedImage = 0;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (context) {
        return Column(
          children: [
            SizedBox(
              width: getProportionateScreenWidth(238),
              child: AspectRatio(
                aspectRatio: 1,
                child: Hero(
                  tag: widget.product.id.toString()+'image',
                  child: Obx(() => Image.asset(_homeController.lstImage[selectedImage])),
                ),
              ),
            ),
            // SizedBox(height: getProportionateScreenWidth(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(_homeController.lstImage.length,
                    (index) => buildSmallProductPreview(index)),
              ],
            ),
          ],
        );
      }
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
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
              color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: Obx(() => Image.asset(_homeController.lstImage[index])),
      ),
    );
  }
}
