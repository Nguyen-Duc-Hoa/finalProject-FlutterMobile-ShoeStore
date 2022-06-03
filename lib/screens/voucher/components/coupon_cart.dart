import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:finalprojectmobile/constants.dart';
import 'package:finalprojectmobile/models/Order.dart';
import 'package:finalprojectmobile/models/voucher.dart';
import 'package:flutter/material.dart';
import "package:intl/intl.dart";
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../../../models/user.dart';

class Coupon extends StatelessWidget {
  List<Order> orders;
  num score;
  Coupon({Key? key,required this.orders,required this.score}) : super(key: key);

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Query<Map<String, dynamic>> voucher =
  FirebaseFirestore.instance.collection('voucher').where('endDate',isGreaterThanOrEqualTo: DateTime.now());
  Query<Map<String, dynamic>> ranking =
  FirebaseFirestore.instance.collection('ranking').where('userId',isEqualTo: DateTime.now());
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    const Color primaryColor = Color(0x5BF3E0CB);
    Query<Map<String, dynamic>> ranking =
    FirebaseFirestore.instance.collection('ranking').where('userId',isEqualTo: user.uid);
    return StreamBuilder(
        stream: voucher.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          var dataList = snapshot.data?.docs.map((e) => e.data()).toList();


          List<Voucher> vouchers = [];

          dataList?.forEach((element) {
            final Map<String, dynamic> doc = element as Map<String, dynamic>;
            Voucher v = Voucher(voucherId: doc["voucherId"],
              voucherName: doc["voucherName"],
              voucherValue: doc["voucherValue"],
              startDate: doc["startDate"].toDate(),
              endDate: doc["endDate"].toDate(),

            );
            int count=0;

            for(int i=0;i<orders.length;i++)
            {
              if(v.voucherId==orders[i].voucherId&&orders[i].status!=-1)
                {
                  count++;
                }
            }
            if(count==0)
              vouchers.add(v);

          });

         if(score>=50&&score<80)
           {
             int numVoucher=0;
             for(int i=0;i<orders.length;i++)
             {
               if(orders[i].voucherId=='BRONZE'&&orders[i].status!=-1)
               {
                 numVoucher++;
               }
             }
             if(numVoucher==0)
             vouchers.add(bronzeVoucher);
           }

         if(score>=80&&score<150)
           {
             int numVoucher=0;
             for(int i=0;i<orders.length;i++)
             {
               if(orders[i].voucherId=='SILVER'&&orders[i].status!=-1)
               {
                 numVoucher++;
               }
             }
             if(numVoucher==0)
               vouchers.add(silverVoucher);
           }
          if(score>=150&&score<200)
          {
            int numVoucher=0;
            for(int i=0;i<orders.length;i++)
            {
              if(orders[i].voucherId=='VCGOLD'&&orders[i].status!=-1)
              {
                numVoucher++;
              }
            }
            if(numVoucher==0)
              vouchers.add(goldVoucher);
          }
          if(score>=200)
          {
            int numVoucher=0;
            for(int i=0;i<orders.length;i++)
            {
              if(orders[i].voucherId=='DIAMON'&&orders[i].status!=-1)
              {
                numVoucher++;
              }
            }
            if(numVoucher==0)
              vouchers.add(diamondVoucher);
          }
          if(vouchers.isEmpty)
          {
            return Container();
          }
          else{
            return Column(
                children:
                List.generate(vouchers.length, (index) {
                  return Card(
                    child: InkWell(
                        onTap: () =>Get.back(result: vouchers[index]),
                        child:  CouponCard(
                          height: 150,
                          backgroundColor: primaryColor,
                          curveAxis: Axis.vertical,
                          firstChild: Container(
                            decoration: const BoxDecoration(
                              color: kPrimaryColor,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'SALE',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'OFF',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(color: Colors.white54, height: 0),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      'SHOP SHOES',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          secondChild: Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${NumberFormat.currency(locale: 'vi').format(vouchers[index].voucherValue)}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor,
                                  ),
                                ),
                                SizedBox(height: 4),


                                Text(
                                  '${vouchers[index].voucherName}',

                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                vouchers[index].startDate==null?
                                Text(
                                  'Không giới hạn',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black45,
                                  ),
                                ):
                                Text(
                                  '${vouchers[index].startDate.toString().substring(0, vouchers[0].startDate.toString().lastIndexOf(":"))} - ${vouchers[index].endDate.toString().substring(0, vouchers[0].endDate.toString().lastIndexOf(":"))}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black45,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                    ),
                  );
                }
                )

            );
          }
        }
    );


  }
}







