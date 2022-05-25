import 'package:finalprojectmobile/models/OrderTracking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Order_tracking extends StatelessWidget {
  final String orderId;
  const Order_tracking({Key? key,required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Query<Map<String, dynamic>> orderTracking = FirebaseFirestore.instance.collection('orderTracking').where('orderId', isEqualTo: orderId).orderBy('time',descending: true);
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text('Thông tin vận chuyển',),

      ),
      body:StreamBuilder(
        stream: orderTracking.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          var dataList = snapshot.data?.docs.map((e) => e.data()).toList();


          List<OrderTracking> items = [];
          dataList?.forEach((element) {
            final Map<String, dynamic> doc = element as Map<String, dynamic>;
            OrderTracking item = OrderTracking(orderId: doc["orderId"],
                time: doc["time"].toDate(),
                note: doc["note"],

            );

            items.add(item);

          });
          return Container(
            margin: EdgeInsets.only(top: 15,bottom: 15,left: 5,right: 5),
            child: ListView(
              children:[
                Column(
                    children:List.generate(items.length, (index) {
                      return  Column(
                        children: [
                          TimelineTile(

                            alignment: TimelineAlign.manual,
                            lineXY: 0.3,
                            isFirst: index==0,
                            isLast: index==items.length-1,
                            indicatorStyle: IndicatorStyle(
                              width: index==0?20:15,
                              color: index==0?Color(0xFF27AA69):Color(0xFFDADADA),

                            ),
                            startChild: Center(
                              child: Container(
                             margin: EdgeInsets.only(left:10),
                                child:index==0?Text('${items[index].time.toString().substring(0, items[index].time.toString().lastIndexOf(":"))}',style: TextStyle(color: Colors.black),):Text('${items[index].time.toString().substring(0, items[index].time.toString().lastIndexOf(":"))}')
                              ),
                            ),

                            beforeLineStyle: const LineStyle(
                              color: Color(0xFFDADADA),
                            ),
                            endChild: Center(
                              child: Container(
                                height: 80,
                                alignment: Alignment.center,
                                child:index==0?Text('${items[index].note}',style: TextStyle(fontSize: 16,color: Color(0xFF27AA69)),):Text('${items[index].note}',style: TextStyle(fontSize: 16),)
                              ),
                            ),
                          ),

                        ]
                      );
                    },
                    )
                )
              ]

            ),
          );
        },
      ) ,
    );
  }
}
