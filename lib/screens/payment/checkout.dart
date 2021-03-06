import 'dart:convert';

import 'package:finalprojectmobile/common.dart';
import 'package:finalprojectmobile/constants.dart';
import 'package:finalprojectmobile/models/Cart.dart';
import 'package:finalprojectmobile/models/Wallet.dart';
import 'package:finalprojectmobile/models/methodPayment.dart';
import 'package:finalprojectmobile/models/voucher.dart';
import 'package:finalprojectmobile/screens/cart/CartController.dart';
import 'package:finalprojectmobile/screens/page/page.dart';
import 'package:finalprojectmobile/screens/sign_up/signup.dart';
import 'package:finalprojectmobile/screens/wallet/pincode.dart';
import 'package:flutter/material.dart';
import "package:intl/intl.dart";
import '../../models/address.dart';
import '../../models/user.dart';
import '../payment/components/body.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

class Checkout extends StatefulWidget {
  static String routeName = "/checkout";

  const Checkout({Key? key}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  CartController _cartController = Get.find();
  CollectionReference cartCol = FirebaseFirestore.instance.collection('cart');
  CollectionReference orderCol = FirebaseFirestore.instance.collection('order');
  CollectionReference orderItemCol =
      FirebaseFirestore.instance.collection('orderItem');
  var url =
      'http://10.0.2.2:5001/final-project-shoestore-334b6/us-central1/paypalPayment';
  final Common _common = Common();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    Query<Map<String, dynamic>> w = FirebaseFirestore.instance
        .collection('wallet')
        .where('userId', isEqualTo: user.uid);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Thanh to??n'), //Thanh to??n
      ),
      body: Body(),
      bottomSheet: Container(
          color: Colors.white,
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: GetBuilder<CartController>(builder: (s) {
                  return Column(
                    children: [
                      const Text("T???ng ti???n"), //T???ng ti???n
                      Text(
                          //_cartController.voucher.value.voucherId.toString(),
                          _common.formatCurrency(
                              _cartController.totalFinalOrder(
                                  _cartController.listOrder,
                                  _cartController.voucher,
                                  30000)),
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                    ],
                  );
                }),
              ),
              StreamBuilder(
                  stream: w.snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {}
                    Wallet wallet = Wallet();
                    if (snapshot.data?.docs.length != 0) {
                      dynamic data = snapshot.data?.docs
                          .map((e) => e.data())
                          .toList()
                          .first;
                      wallet = Wallet(
                        userId: data["userId"],
                        pin: data["pin"],
                        money: data["money"],
                      );
                    }
                    return Padding(
                        padding: EdgeInsets.only(right: 10, left: 10),
                        child: FlatButton(
                          onPressed: () async {
                            if (_cartController.address.value.userId == null) {
                              showToastMessage(
                                  'Ch???n ?????a ch??? nh???n h??ng tr?????c khi thanh to??n');
                            } else {
                              if (_cartController.method.value.name ==
                                  'Thanh to??n b???ng Paypal') {
                                double total = _cartController.totalFinalOrder(
                                    _cartController.listOrder,
                                    _cartController.voucher,
                                    30000);
                                String amount =
                                    (total / 22000).toStringAsFixed(2);
                                var request = BraintreeDropInRequest(
                                    tokenizationKey:
                                        'sandbox_gp7hsnyd_7dxbrf6yqvmhdzdk',
                                    collectDeviceData: true,
                                    paypalRequest: BraintreePayPalRequest(
                                      amount: amount,
                                      displayName: 'Raja Yogan',
                                    ),
                                    cardEnabled: true);
                                BraintreeDropInResult? result =
                                    await BraintreeDropIn.start(request);
                                if (result != null) {
                                  print(result.paymentMethodNonce.description);
                                  print(result.paymentMethodNonce.nonce);
                                  print(result.deviceData);

                                  var response = await http.post(Uri.parse(
                                      '$url?payment_method_nonce=${result.paymentMethodNonce.nonce}&device_data=${result.deviceData}'));
                                  final payResult = jsonDecode(response.body);
                                  print(payResult);
                                  if (payResult['result'] == 'success') {
                                    String addDB = await _paymentOrder(
                                        _cartController.listOrder,
                                        user,
                                        _cartController.address.value,
                                        _cartController.voucher.value,
                                        _cartController.method.value);
                                    if (addDB == 'true') {
                                      showToastMessage('Thanh to??n th??nh c??ng');
                                      print('Pay done!');

                                      Get.to(const Pages(selectedIndex: 2));
                                    }
                                  }
                                  // String addDB = await _paymentOrder(
                                  //     _cartController.listOrder,
                                  //     user,
                                  //     _cartController.address.value,
                                  //     _cartController.voucher.value);
                                  // if(addDB=='true'){
                                  //   Get.to(const Pages(selectedIndex : 2));
                                  // }
                                }
                                // String addDB = await _paymentOrder(
                                //     _cartController.listOrder,
                                //     user,
                                //     _cartController.address.value,
                                //     _cartController.voucher.value);
                                // if(addDB == 'true'){
                                //
                                // }

                              } else if (_cartController.method.value.name ==
                                  'V?? ShopshoePay') {
                                String walletId = '';
                                await FirebaseFirestore.instance
                                    .collection('wallet')
                                    .where('userId', isEqualTo: user.uid)
                                    .get()
                                    .then((QuerySnapshot querySnapshot) {
                                  querySnapshot.docs.forEach((doc) {
                                    walletId = doc.id;
                                    print(walletId);
                                  });
                                });

                                bool result = await Get.to(
                                    PinCodeScreen(pin: wallet.pin ?? ""));

                                if (result == true) {
                                  if (walletId != '') {
                                    double total =
                                        _cartController.totalFinalOrder(
                                            _cartController.listOrder,
                                            _cartController.voucher,
                                            30000);
                                    await FirebaseFirestore.instance
                                        .collection('wallet')
                                        .doc(walletId)
                                        .update({
                                      'money': wallet.money! - total,
                                    }).then((value) {
                                      print('change quantity cart');
                                      return 'change quantity cart';
                                    }).catchError((error) => print(
                                            "Failed to add user: $error"));
                                  }

                                  String addDB = await _paymentOrder(
                                      _cartController.listOrder,
                                      user,
                                      _cartController.address.value,
                                      _cartController.voucher.value,
                                      _cartController.method.value);

                                  if (addDB == 'true') {
                                    showToastMessage('Thanh to??n th??nh c??ng');
                                    Get.to(const Pages(selectedIndex: 2));
                                  }
                                }
                              } else if (_cartController.method.value.name ==
                                  'Thanh to??n khi nh???n h??ng') {
                                String addDB = await _paymentOrder(
                                    _cartController.listOrder,
                                    user,
                                    _cartController.address.value,
                                    _cartController.voucher.value,
                                    _cartController.method.value);

                                if (addDB == 'true') {
                                  showToastMessage('?????t h??ng th??nh c??ng');
                                  Get.to(const Pages(selectedIndex: 2));
                                }
                              }
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.deepOrangeAccent,
                                borderRadius: BorderRadius.circular(10)),
                            height: 50,
                            width: 100,
                            child: const Center(
                              child: Text(
                                'Thanh to??n', //Thanh to??n
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ));
                  })
            ],
          )),
    );
  }

  Future<String> _paymentOrder(List<Cart> lstOrder, Users user, Address address,
      Voucher voucher, Method method) async {
    if (lstOrder.isEmpty) {
      return "false";
    }
    String payment = 'Thanh to??n khi nh???n';
    if (method.id == 1) {
      payment = 'ShopshoePay';
    } else if (method.id == 2) {
      payment = 'Paypal';
    }
    String cartId = "";
    String orderId = "";
    String oldOrderId = "";
    bool isExistOrder = false;
    //Ki???m tra order t???n t???i ch??a
    do {
      orderId = _common.getRandomString(6);
      oldOrderId = "";
      await FirebaseFirestore.instance
          .collection('order')
          .where('orderId', isEqualTo: orderId)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          oldOrderId = doc.id;
        });
      });
    } while (oldOrderId != "");

    //Add to order
    await orderCol.add({
      'address': address.address,
      "id": orderId, // John Doe
      'name': address.name, // Stokes and Sons
      'orderDate': DateTime.now(), // 42
      'payment': payment,
      'phone': address.phone, // 42
      'status': 0,
      'total': _cartController.totalFinalOrder(lstOrder, voucher.obs, 30000),
      'userId': user.uid,
      'voucherId': voucher.voucherId,
      'voucherValue': voucher.voucherValue ?? 0
    }).then((value) {
      print("User Order");
      return "User Order";
    }).catchError((error) {
      print("Failed to add user: $error");
      return error;
    });

    _cartController.listOrder.forEach((element) async {
      cartId = "";

      //Add to orderitem
      await orderItemCol.add({
        'color': element.color,
        'image': element.image,
        // John Doe
        'orderId': orderId,
        // Stokes and Sons
        'price': element.product.price * (1 - element.product.disCount / 100),
        // 42
        'productId': element.productId,
        'productName': element.product.title,
        'quantity': element.numOfItem,
        'size': element.size,
        'comment': false
        // 42
      }).then((value) {
        print("User OrderItem");
        return "User Added";
      }).catchError((error) {
        print("Failed to add OrderItem: $error");
        return error;
      });

      //delete in cart
      await FirebaseFirestore.instance
          .collection('cart')
          .where('userId', isEqualTo: element.userId)
          .where('color', isEqualTo: element.color)
          .where('size', isEqualTo: element.size)
          .where('productId', isEqualTo: element.productId)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          cartId = doc.id;
        });
      });
      if (cartId != "") {
        await cartCol.doc(cartId).delete().then((value) {
          print('delete successful');
          return 'delete successful';
        }).catchError((error) => print("Failed to add user: $error"));
      }
    });

    CollectionReference trackingCol =
        FirebaseFirestore.instance.collection('orderTracking');
    //Update to OrderTracking
    await trackingCol.add({
      'note': 'Ch??? nh??n vi??n x??c nh???n ????n h??ng',
      'orderId': orderId, // John Doe
      'time': DateTime.now(), // Stokes and Sons
    }).then((value) {
      print("User OrderItem");
      return "User Added";
    }).catchError((error) {
      print("Failed to add OrderItem: $error");
      return error;
    });

    if (method.id == 1) {
      CollectionReference historyCol =
      FirebaseFirestore.instance.collection('history');
      await historyCol.add({
        'date': DateTime.now(),
        'description': 'Thanh to??n th??nh c??ng',
        'name': 'Thanh to??n ti???n',
        'orderId': orderId,
        'userId': user.uid,
        'total': _cartController.totalFinalOrder(lstOrder, voucher.obs, 30000),
      }).then((value) {
        print("add hisotory");
        return "User Order";
      }).catchError((error) {
        print("Failed to add user: $error");
        return error;
      });
    }

    _cartController.resetListOrder();
    _cartController.voucher = Voucher().obs;
    return "true";
  }

  Future<String> _addToOrderItem(String orderId, Cart element) async {
    return "true";
  }
}
