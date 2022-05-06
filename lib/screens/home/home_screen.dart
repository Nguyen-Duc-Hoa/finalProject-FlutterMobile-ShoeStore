import 'package:final_project_mobile/constants.dart';
import 'package:final_project_mobile/screens/cart/CartController.dart';
import 'package:final_project_mobile/screens/home/components/home_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../details/components/custom_app_bar.dart';
import 'components/body.dart';
import 'package:final_project_mobile/size_config.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: PreferredSize(

        preferredSize: Size.fromHeight(getProportionateScreenHeight(100)),
        child: Expanded(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: getProportionateScreenHeight(60),
                color: kPrimaryColor,
                child: const Text("Shoe's Shop",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 20.0),),
              ),
              // SizedBox(height: 5,),
              Container(
                margin: EdgeInsets.only(bottom: 5),
                color: kPrimaryColor,
                child: HomeHeader()),
            ],
          ),
        ),
      ),
      body: Body(),
    );
  }
}
