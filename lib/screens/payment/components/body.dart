import 'dart:async';

import 'package:finalprojectmobile/common.dart';
import 'package:finalprojectmobile/constants.dart';
import 'package:finalprojectmobile/models/Cart.dart';
import 'package:finalprojectmobile/models/address.dart';
import 'package:finalprojectmobile/models/methodPayment.dart';
import 'package:finalprojectmobile/models/voucher.dart';
import 'package:finalprojectmobile/screens/address/address_screen.dart';
import 'package:finalprojectmobile/screens/cart/CartController.dart';
import 'package:finalprojectmobile/screens/payment/components/method.dart';
import 'package:finalprojectmobile/screens/voucher/voucher.dart';
import 'package:finalprojectmobile/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/Product.dart';
import "package:intl/intl.dart";
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../models/user.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  CartController _cartController = Get.find();

  Address address = Address();
  Voucher voucher = Voucher();
  Method method = Method();
  final Common _common = Common();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    voucher = _cartController.voucher.value;
    method = demoMethod[2];
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    num score=0;
    //   FirebaseFirestore.instance.collection(
    //       'address').where('userId', isEqualTo: user.uid).where('isDefault', isEqualTo: true).get()
    //       .then((value)  {
    //
    //     Address a = Address(
    //       userId: value.docs[0]['userId'],
    //       name: value.docs[0]['name'],
    //       phone: value.docs[0]['phone'],
    //       address: value.docs[0]['address'],
    //       isDefault: value.docs[0]['isDefault'],
    //     );
    //
    //     return a;
    //
    //   });
    //
    // }

    List<Cart> items = _cartController.listOrder;
    if (user != null) {
      Query<Map<String, dynamic>> add = FirebaseFirestore.instance
          .collection('address')
          .where('userId', isEqualTo: user.uid)
          .where('isDefault', isEqualTo: true);

      return StreamBuilder(
          stream: add.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            Address a=Address();
            if(snapshot.data?.docs.length!=0)
              {
                dynamic dataList = snapshot.data?.docs.map((e) => e.data()).toList().first;


                // final Map<String, dynamic> doc = element as Map<String, dynamic>;
                a =  Address(
                  userId: dataList["userId"],
                  name: dataList["name"],
                  phone: dataList["phone"],
                  address: dataList["address"],
                  isDefault: dataList["isDefault"],
                );
              }


            address = a;
            _cartController.setAddress(address);

            return ListView(
              children: [

                Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black)),
                  ),
                  child: Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: ListTile(
                        title: Text('Địa chỉ nhận hàng'),
                        leading:
                            Icon(Icons.location_on_outlined, color: Colors.red),
                        trailing: IconButton(
                          onPressed: () async {
                            Get.to(AddressScreen());
                            // if (_address != null) {
                            //   setState(() {
                            //     address = _address;
                            //
                            //   });
                            //
                            // }
                            _cartController.setAddress(address);
                          },
                          icon: Icon(Icons.edit),
                          hoverColor: Colors.white,
                          highlightColor: Colors.white,
                          splashColor: Colors.white,
                          color: Colors.black,
                        ),
                        subtitle:address.userId!=null? Text('${address.name} \n${address.phone} \n${address.address}'):Text('Chọn địa chỉ nhận hàng'),
                        //
                      )),
                ),
                Column(
                    children: List.generate(items.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 10, right: 25, left: 25, bottom: 10),
                    child: Row(
                      children: [
                        Container(
                            width:
                                (MediaQuery.of(context).size.width - 170) / 2,
                            height: 100,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                      spreadRadius: 1,
                                      blurRadius: 0.5,
                                      color: Colors.orange)
                                ],
                                image: DecorationImage(
                                    image: AssetImage(items[index].image),
                                    fit: BoxFit.cover))),
                        const SizedBox(
                          width: 25,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${items[index].product.title}',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(width: 15),
                            if(items[index]
                                .product.disCount != 0)
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _common.formatCurrency(items[index]
                                          .product.price),
                                      style: TextStyle(
                                        fontSize: getProportionateScreenWidth(13),
                                        fontWeight: FontWeight.w600,
                                        color: kSecondaryColor,
                                        decoration: TextDecoration.lineThrough,
                                      ),

                                    ),
                                  ]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Text(
                                  _common.formatCurrency(items[index]
                                          .product
                                          .price *
                                      (1 -
                                          items[index].product.disCount / 100)),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.red),
                                ),
                                Container(
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color:
                                          Color(int.parse(items[index].color)),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  width: 20,
                                  height: 20,
                                ),
                                Text('${items[index].size}'),
                                Text(
                                  "x${items[index].numOfItem}",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            )
                          ],
                        ))
                      ],
                    ),
                  );
                })),
                Padding(
                    padding: EdgeInsets.only(bottom: 25),
                    child: ListTile(
                        onTap: () async {
                          await FirebaseFirestore.instance.collection('ranking').where('userId', isEqualTo: user.uid).get().then((value) {

                              score=value.docs[0].get('score');

                          });

                          Voucher _voucher = await Get.to(VoucherScreen(score: score));
                          if (_voucher != null) {
                            setState(() {
                              voucher = _voucher;
                              _cartController.setVoucher(_voucher);
                            });
                          }
                        },
                        title: Text('Mã giảm giá'),
                        trailing: voucher.voucherId == null
                            ? Text(
                                'Chọn mã giảm giá',
                              )
                            : Text('${voucher.voucherName}',
                                style: TextStyle(
                                    color: Colors.red, fontSize: 15)))),
                Padding(
                  padding: EdgeInsets.only(top: 20, right: 25, left: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tổng',
                        style: TextStyle(
                            fontSize: 17, color: Colors.black.withOpacity(0.5)),
                      ),
                      Text(
                        _common
                            .formatCurrency(_cartController.totalCart(items)),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 25, left: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Vận chuyển',
                        style: TextStyle(
                            fontSize: 17, color: Colors.black.withOpacity(0.5)),
                      ),
                      Text(
                        _common.formatCurrency(30000),
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                if (voucher.voucherId != null)
                  Padding(
                    padding: EdgeInsets.only(right: 25, left: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Giảm giá',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.black.withOpacity(0.5)),
                        ),
                        Text(
                          '-'+_common.formatCurrency(voucher.voucherValue!.toDouble()),
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: Colors.red),
                        )
                      ],
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.only(right: 25, left: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Thanh toán',
                        style: TextStyle(
                            fontSize: 20, color: Colors.black.withOpacity(0.5)),
                      ),
                      Text(
                        _common.formatCurrency(_cartController.totalFinalOrder(items, voucher.obs, 30000)),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.red),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(bottom: 25),
                    child: ListTile(
                        title: Text('Payment'),
                        trailing: GestureDetector(
                            onTap: () async {
                              Method _method = await Get.to(MethodScreen(
                                total: _cartController.totalFinalOrder(items, voucher.obs, 30000),
                              ));
                              if (_method != null) {
                                setState(() {
                                  method = _method;
                                  _cartController.setMethod(method);
                                });
                              }
                            },
                            child: Text(method.name.toString())))),
                SizedBox(height: 50),
              ],
            );
          });
    } else
      return Container();
  }
}
