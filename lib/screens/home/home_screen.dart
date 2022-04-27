import 'package:final_project_mobile/screens/cart/CartController.dart';
import 'package:flutter/material.dart';

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
      body: Body(),
    );
  }
}
