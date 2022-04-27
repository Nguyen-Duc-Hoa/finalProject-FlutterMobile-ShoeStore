import 'package:final_project_mobile/screens/cart/CartController.dart';
import 'package:final_project_mobile/screens/home/components/home_header.dart';
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
        preferredSize: Size.fromHeight(AppBar().preferredSize.height + 5),
        child: Padding(
          padding: const EdgeInsets.only(top: 25.0, bottom: 15.0),
          child: HomeHeader(),
        ),
      ),
      body: Body(),
    );
  }
}
