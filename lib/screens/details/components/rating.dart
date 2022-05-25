

import 'package:finalprojectmobile/screens/details/components/chart_rating.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../models/Rate.dart';
import '../../../models/user.dart';




class Rating extends StatelessWidget {
  final int id;

  const Rating({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int one = 0;
    int two = 0;
    int three = 0;
    int four = 0;
    int five = 0;
    List<int> num = [];
    int count=0;

    return Container(
      margin: EdgeInsets.all(15),
      child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            child: Row(
              children: [
                Text("ĐÁNH GIÁ SẢN PHẨM", style: TextStyle(fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: Colors.black,
                ),
              ],
            ),
            onTap: () async {
              await FirebaseFirestore.instance.collection('rate').where(
                  'productId', isEqualTo: id).where('rate', isEqualTo: 1)
                ..get().then((value) {
                  one = value.size;
                  num.add(one);
                });
              await FirebaseFirestore.instance.collection('rate').where(
                  'productId', isEqualTo: id).where('rate', isEqualTo: 2)
                  .get()
                  .then((value) {
                two = value.size;
                num.add(two);
              });
              await FirebaseFirestore.instance.collection('rate').where(
                  'productId', isEqualTo: id).where('rate', isEqualTo: 3)
                  .get()
                  .then((value) {
                three = value.size;
                num.add(three);
              });
              await FirebaseFirestore.instance.collection('rate').where(
                  'productId', isEqualTo: id).where('rate', isEqualTo: 4)
                  .get()
                  .then((value) {
                four = value.size;
                num.add(four);
              });

              await FirebaseFirestore.instance.collection('rate').where(
                  'productId', isEqualTo: id).where('rate', isEqualTo: 5)
                  .get()
                  .then((value) {
                five = value.size;
                num.add(five);
              });
              Get.to(Chart_Rating(pct: num,id: id));
            },
          ),

          SizedBox(height: 8),


        ],
      ),
    );
  }
}



