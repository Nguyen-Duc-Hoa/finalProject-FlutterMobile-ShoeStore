import 'package:finalprojectmobile/screens/search/search.dart';
import 'package:finalprojectmobile/screens/search/search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.75, //80% of our width
      height: 50,
      decoration: BoxDecoration(
        color: kPrimaryLightColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        cursorColor: Colors.grey,
        onSubmitted: (value) {
          if(value != ''){
            Get.to(SearchScreen(name: value,));
          }
        },
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintStyle: const TextStyle(color: kPrimaryLightColor),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: "Tìm kiếm sản phẩm",
          prefixIcon: const Icon(Icons.search),
          prefixIconColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenHeight(9),
          )),
      ),
    );
  }
}
