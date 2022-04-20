import 'package:flutter/material.dart';

import 'components/body.dart';
import 'package:final_project_mobile/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    Color clor = Colors.white;
    String colorString = clor.toString();
    String valueString = colorString.split('(0x')[1].split(')')[0];
    int value = int.parse(valueString, radix: 16);

    Color otherColor = new Color(value);
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
