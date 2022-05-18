import 'package:finalprojectmobile/constants.dart';
import 'package:finalprojectmobile/screens/home/components/home_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';
import 'package:finalprojectmobile/size_config.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(SizeConfig.screenHeight * 0.135),
        child: Expanded(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: SizeConfig.screenHeight * 0.08,
                color: kPrimaryColor,
                child: const Text("Shoe's Shop",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 20.0),),
              ),
              // SizedBox(height: 5,),
              Container(
                height: SizeConfig.screenHeight * 0.08,
                // margin: EdgeInsets.only(bottom: 5),
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

