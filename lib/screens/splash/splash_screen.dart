import 'package:flutter/material.dart';
import 'package:final_project_mobile/screens/splash/components/body.dart';
import 'package:final_project_mobile/size_config.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}