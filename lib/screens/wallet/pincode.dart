import 'package:finalprojectmobile/common.dart';
import 'package:finalprojectmobile/constants.dart';
import 'package:finalprojectmobile/models/Wallet.dart';
import 'package:finalprojectmobile/screens/sign_up/signup.dart';
import 'package:finalprojectmobile/screens/wallet/recharge.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:get/get.dart';

class PinCodeScreen extends StatefulWidget {
  const PinCodeScreen({Key? key, required this.pin}) : super(key: key);
  final String pin;

  @override
  _PinCodeScreenState createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  int i = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Mật khẩu Ví ShopshoePay',
              style: TextStyle(
                  fontSize: 20.0,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30.0,
            ),
            PinCodeTextField(
              appContext: context,
              length: 6,
              onChanged: (value) {
                print(value);
              },
              pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 60,
                  fieldWidth: 50,
                  activeColor: kPrimaryLightColor,
                  inactiveColor: kSecondaryColor,
                  selectedColor: kPrimaryColor),
              obscureText: true,
              onCompleted: (value) {
                if (i == 5) {
                  Get.back(result: false);
                }
                if (value == widget.pin) {
                  Get.back(result: true);
                } else {
                  i++;
                  String notify =
                      'Bạn còn ' + (5 - i).toString() + ' lượt nhập';
                  showToastMessage(notify);
                }
              },
            ),
          ],
        ),
      )),
    );
  }
}
