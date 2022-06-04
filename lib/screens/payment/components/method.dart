import 'package:finalprojectmobile/common.dart';
import 'package:finalprojectmobile/components/default_button.dart';
import 'package:finalprojectmobile/constants.dart';
import 'package:finalprojectmobile/models/Wallet.dart';
import 'package:finalprojectmobile/models/address.dart';
import 'package:finalprojectmobile/models/methodPayment.dart';
import 'package:finalprojectmobile/models/user.dart';
import 'package:finalprojectmobile/screens/cart/CartController.dart';
import 'package:finalprojectmobile/screens/wallet/recharge.dart';
import 'package:finalprojectmobile/screens/wallet/wallet.dart';
import 'package:finalprojectmobile/size_config.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MethodScreen extends StatefulWidget {
  static String routeName = "/address";

  MethodScreen({Key? key, required this.total}) : super(key: key);

  final double total;
  @override
  State<MethodScreen> createState() => _MethodScreenState();
}

class _MethodScreenState extends State<MethodScreen> {
  final _formKeyAdd = GlobalKey<FormState>();
  final CartController _cartController = CartController();

  final _formKeyEdit = GlobalKey<FormState>();
  Method chooseMethod = Method();
  List<Method> lstMethod = demoMethod;
  bool disable = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var element in demoMethod) {
      if (element.isDefault == true) {
        chooseMethod = element;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    print(widget.total);

    if (user != null) {
      Query<Map<String, dynamic>> w = FirebaseFirestore.instance
          .collection('wallet')
          .where('userId', isEqualTo: user.uid);
      return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text('Phương thức thanh toán'),
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            StreamBuilder(
                stream: w.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {}
                  Wallet wallet = Wallet();
                  if (snapshot.data?.docs.length != 0) {
                    dynamic data =
                        snapshot.data?.docs.map((e) => e.data()).toList().first;
                    wallet = Wallet(
                      userId: data["userId"],
                      pin: data["pin"],
                      money: data["money"],

                    );
                  }
                  return Column(
                      children: List.generate(demoMethod.length, (index) {
                    bool? val = demoMethod[index].isDefault;
                    return Column(
                      children: [
                        Container(
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
                                    for (int i = 0;
                                        i < demoMethod.length;
                                        i++) {
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
                                    if (wallet.userId == null &&
                                        demoMethod[index].name == 'Ví ShopshoePay' &&
                                        demoMethod[index].isDefault == true){
                                      disable = true;
                                    }
                                    else if(wallet.userId != null &&
                                        wallet.money! < widget.total &&
                                        demoMethod[index].name == 'Ví ShopshoePay' &&
                                        demoMethod[index].isDefault == true){
                                      disable = true;
                                    }
                                    else {
                                      disable = false;
                                    }
                                  });
                                },
                                activeColor: kPrimaryColor,
                              ),
                              title: Text('${demoMethod[index].name}'),
                            ),
                          ),
                        ),
                        if (wallet.userId == null &&
                            demoMethod[index].name == 'Ví ShopshoePay' &&
                            demoMethod[index].isDefault == true)

                          Center(
                            child: Container(
                                width: 250,
                                height: 50,
                                child: RaisedButton(
                                  onPressed: () async{
                                    Get.to(WalletScreen());
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(80.0)),
                                  padding: EdgeInsets.all(0.0),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFFFC560A),
                                            Color(0xFFFCA931)
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    child: Container(
                                      constraints: const BoxConstraints(
                                          maxWidth: 250.0, minHeight: 50.0),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "Tạo ví",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 17),
                                      ),
                                    ),
                                  ),
                                )),
                          ),

                        if (wallet.userId != null &&
                            wallet.money! < widget.total &&
                            demoMethod[index].name == 'Ví ShopshoePay' &&
                            demoMethod[index].isDefault == true)

                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text('Số dư ví không đủ để thanh toán'),
                              ),
                              Center(
                                child: Container(
                                    width: 250,
                                    height: 50,
                                    child: RaisedButton(
                                      onPressed: () async{
                                        Get.to(RechargeScreen());
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(80.0)),
                                      padding: EdgeInsets.all(0.0),
                                      child: Ink(
                                        decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [
                                                Color(0xFFFC560A),
                                                Color(0xFFFCA931)
                                              ],
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(30.0)),
                                        child: Container(
                                          constraints: const BoxConstraints(
                                              maxWidth: 250.0, minHeight: 50.0),
                                          alignment: Alignment.center,
                                          child: const Text(
                                            "Nạp tiền vào ví",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 17),
                                          ),
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                      ],
                    );
                  }));
                }),
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
                disable: disable,
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
          onPressed: () {},
          backgroundColor: kPrimaryColor,
          tooltip: 'Add address',
          child: const Icon(Icons.add),
        ),
      );
    }
  }
}
