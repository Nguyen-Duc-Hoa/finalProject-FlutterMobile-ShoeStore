import 'package:flutter/material.dart';
import 'package:finalprojectmobile/constants.dart';

import '../size_config.dart';

class RoundedIconBtn extends StatelessWidget {
  const RoundedIconBtn({
    Key? key,
    required this.icon,
    required this.press,
    this.showShadow = false,
    required this.disable,
  }) : super(key: key);

  final IconData icon;
  final GestureTapCancelCallback press;
  final bool showShadow;
  final bool disable;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenWidth(40),
      width: getProportionateScreenWidth(40),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          if (showShadow)
            BoxShadow(
              offset: Offset(0, 6),
              blurRadius: 10,
              color: Color(0xFFB0B0B0).withOpacity(0.2),
            ),
        ],
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          primary: kPrimaryColor,
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
        onPressed: disable ? null : press,
        child: Icon(icon),
      ),
    );
  }
}
