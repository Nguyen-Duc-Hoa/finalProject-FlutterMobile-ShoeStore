import 'package:final_project_mobile/common.dart';
import 'package:final_project_mobile/components/default_button.dart';
import 'package:final_project_mobile/components/rounded_icon_btn.dart';
import 'package:final_project_mobile/constants.dart';
import 'package:final_project_mobile/models/Cart.dart';
import 'package:final_project_mobile/models/Color.dart';
import 'package:final_project_mobile/models/Product.dart';
import 'package:final_project_mobile/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:final_project_mobile/common.dart';

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
  List<String> imageByColor = [];
  int? value;
  Common _common = new Common();
  late Cart _cart;
  @override
  void initState() {
    super.initState();
    _cart = Cart(product: widget.product, numOfItem: 1, size: -1, color: Color(0x123456));
  }

  @override
  Widget build(BuildContext context) {
    if (imageByColor.isEmpty) {
      for (int i = 0; i < widget.product.colors.length; i++) {
        if (5 * i < widget.product.images.length) {
          imageByColor.add(widget.product.images[5 * i]);
        }
      }
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
                        // color: Color(0xFFF5F6F9),
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
                    press: () {},
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '',
                      ),
                      enabled: value != null,
                    ),
                  ),
                  RoundedIconBtn(
                    icon: Icons.add,
                    showShadow: true,
                    press: () {},
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          Container(
              margin: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(10),
                  vertical: getProportionateScreenWidth(5)),
              child: DefaultButton(text: "Thêm giỏ hàng", disable: true, press: () {})),
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
              } else {
                selectedImage = index;
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
