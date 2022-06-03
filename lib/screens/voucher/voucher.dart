import 'package:finalprojectmobile/models/Order.dart';
import 'package:finalprojectmobile/screens/voucher/components/coupon_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VoucherScreen extends StatelessWidget {
  static String routeName = "/voucher";
  num score;
  VoucherScreen({Key? key,required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    Query<Map<String, dynamic>> voucher =
    FirebaseFirestore.instance.collection('order').where('userId',isEqualTo: user.uid);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Mã giảm giá'),
      ),
      body: StreamBuilder(
        stream: voucher.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          var dataList = snapshot.data?.docs.map((e) => e.data()).toList();
          List<Order> orders = [];
          dataList?.forEach((element) {
            final Map<String, dynamic> doc = element as Map<String, dynamic>;
            Order o = Order(
                id: doc["id"],
                userId: doc["userId"],
                name: doc["name"],
                orderDate: doc["orderDate"].toDate(),
                phone: doc["phone"],
                payment: doc["payment"],
                total: doc["total"],
                address: doc["address"],
                status: doc["status"],
                voucherId: doc["voucherId"],
                voucherValue: doc["voucherValue"]);

            orders.add(o);
          });
          if(orders.isEmpty)
            return Padding(
              padding: const EdgeInsets.all(14),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Coupon(orders: [],score: score),

                  ],
                ),
              ),
            );
            else{

            return Padding(
              padding: const EdgeInsets.all(14),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Coupon(orders: orders,score: score),

                  ],
                ),
              ),
            );
          }


        },
      )

    );
  }
}
