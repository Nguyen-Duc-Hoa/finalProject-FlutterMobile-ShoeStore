import 'package:finalprojectmobile/common.dart';
import 'package:finalprojectmobile/components/default_button.dart';
import 'package:finalprojectmobile/constants.dart';
import 'package:finalprojectmobile/models/address.dart';
import 'package:finalprojectmobile/models/methodPayment.dart';
import 'package:finalprojectmobile/models/user.dart';
import 'package:finalprojectmobile/size_config.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MethodScreen extends StatefulWidget {
  static String routeName = "/address";

  MethodScreen({Key? key}) : super(key: key);

  @override
  State<MethodScreen> createState() => _MethodScreenState();
}

class _MethodScreenState extends State<MethodScreen> {
  final _formKeyAdd = GlobalKey<FormState>();

  final _formKeyEdit = GlobalKey<FormState>();
  Method chooseMethod = Method();
  List<Method> lstMethod = demoMethod;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var element in demoMethod) {
      if(element.isDefault == true){
        chooseMethod = element;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    String address = '';
    String name = '';
    String phone = '';
    String? validateMobile(String value) {
      String patttern = r'(^(?:[+0]9)?[0-9]{10}$)';
      RegExp regExp = new RegExp(patttern);
      if (value.length == 0) {
        return 'Please enter mobile number';
      } else if (!regExp.hasMatch(value)) {
        return 'Please enter valid mobile number';
      }
      return null;
    }
    if (user != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text('Phương thức thanh toán'),
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Column(
                children: List.generate(demoMethod.length, (index) {
              bool? val = demoMethod[index].isDefault;
              return Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 25),
                  child: ListTile(
                    leading: IconButton(
                      onPressed: () {},
                      icon: Icon(demoMethod[index].icon),
                      hoverColor: Colors.white,
                      highlightColor: Colors.white,
                      iconSize: 30,
                      splashColor: Colors.white,
                      color: kPrimaryColor,
                    ),
                    trailing: Radio(
                      value: true,
                      groupValue: val,
                      onChanged: (bool? value) {
                        setState(() {
                          print("click");
                          for (int i = 0; i < demoMethod.length; i++) {
                            demoMethod[i] = Method(
                                id: demoMethod[i].id,
                                name: demoMethod[i].name,
                                isDefault: false,
                            icon: demoMethod[i].icon);
                          }
                          demoMethod[index] = Method(
                              id: demoMethod[index].id,
                              name: demoMethod[index].name,
                              isDefault: true,
                              icon: demoMethod[index].icon);
                          chooseMethod = demoMethod[index];
                          val = value;
                        });
                      },
                      activeColor: kPrimaryColor,
                    ),
                    title: Text('${demoMethod[index].name}'),
                    onTap: () => Get.back(result: demoMethod[index]),
                  ),
                ),
              );
            })),
          ],
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenWidth(5),
            horizontal: getProportionateScreenWidth(10),
          ),
          // height: 174,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, -15),
                blurRadius: 20,
                color: const Color(0xFFDADADA).withOpacity(0.5),
              )
            ],
          ),
          child: SizedBox(
            width: getProportionateScreenWidth(220),
            child: Padding(
              padding: EdgeInsets.only(
                left: SizeConfig.screenWidth * 0.1,
                right: SizeConfig.screenWidth * 0.1,
                bottom: getProportionateScreenWidth(10),
                top: getProportionateScreenWidth(10),
              ),
              child: DefaultButton(
                text: "Đồng ý",
                press: () {
                  Get.back(result: chooseMethod);
                },
              ),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text('Địa chỉ nhận hàng'),
        ),
        backgroundColor: Colors.white,
        body: Container(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
          },
          backgroundColor: kPrimaryColor,
          tooltip: 'Add address',
          child: const Icon(Icons.add),
        ),
      );
    }
  }
}
