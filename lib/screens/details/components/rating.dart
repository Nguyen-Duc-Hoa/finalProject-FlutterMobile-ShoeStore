
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/Rate.dart';
import '../../../models/user.dart';

class Rating extends StatelessWidget {
  final int id;
  const Rating({Key? key,required this.id}) : super(key: key);


  @override

  Widget build(BuildContext context) {
    int one=0;
    int two=0;
    int three=0;
    int four=0;
    int five=0;
     FirebaseFirestore.instance.collection('rate').where('productId', isEqualTo: id).where('rate', isEqualTo: 1)..get().then((value) {
       one=value.size;
     });
     FirebaseFirestore.instance.collection('rate').where('productId', isEqualTo: id).where('rate', isEqualTo: 2)..get().then((value) {
       two=value.size;
     });
     FirebaseFirestore.instance.collection('rate').where('productId', isEqualTo: id).where('rate', isEqualTo: 3)..get().then((value) {
       three=value.size;
     });
     FirebaseFirestore.instance.collection('rate').where('productId', isEqualTo: id).where('rate', isEqualTo: 4)..get().then((value) {
       four=value.size;
     });
     FirebaseFirestore.instance.collection('rate').where('productId', isEqualTo: id).where('rate', isEqualTo: 5)..get().then((value) {
       five=value.size;
     });
    Query<Map<String, dynamic>> rate = FirebaseFirestore.instance.collection('rate').where('productId', isEqualTo: id);
    return Container(
      margin: EdgeInsets.all(15),
      child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("ĐÁNH GIÁ SẢN PHẨM",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),),
          SizedBox(height: 8),
          chartRow(context, '5', five),
          chartRow(context, '4', four),
          chartRow(context, '3', three),
          chartRow(context, '2', two),
          chartRow(context, '1', one),
          SizedBox(height: 8),
          StreamBuilder(
            stream: rate.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }
              var dataList = snapshot.data?.docs.map((e) => e.data()).toList();
              List<Rate> items = [];
              dataList?.forEach((element) {
                final Map<String, dynamic> doc = element as Map<String, dynamic>;
                Rate item = Rate(
                    productId: doc["productId"],
                    userId: doc["userId"],
                    rate: doc["rate"],
                    comment: doc['comment']
                );

                items.add(item);
              });
              if(items.isEmpty){
                return Container();
              }
              else
                {
                  return ListView(
                    children: [
                      Column(
                          children:
                          List.generate(items.length, (index){
                            Query<Map<String, dynamic>> user = FirebaseFirestore.instance.collection('user').where('uid', isEqualTo: items[index].userId);
                            return StreamBuilder(
                              stream:user.snapshots() ,
                              builder:(context, AsyncSnapshot<QuerySnapshot> snapshot){
                                if (snapshot.hasError) {
                                  return Text('Something went wrong');
                                }

                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Text("Loading");
                                }
                                dynamic data = snapshot.data?.docs.map((e) => e.data()).toList().first;

                                Users user=Users();
                                user = Users(
                                  uid: data["uid"],
                                  name: data["name"],
                                  phone:data["phone"],
                                  email: data["email"],
                                  avatar: data["avatar"],
                                );

                                return  ListTile(
                                    leading: GestureDetector(

                                      child: Container(
                                        height: 50.0,
                                        width: 50.0,
                                        decoration: new BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: new BorderRadius.all(Radius.circular(50))),
                                        child: CircleAvatar(
                                          radius: 50,
                                          backgroundImage: AssetImage("${user.avatar}"),
                                        ),
                                      ),
                                    ),
                                    title: Text(user.name??'', style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Stack(
                                              children: [
                                                Icon(Icons.star, color:Colors.black12),
                                                Icon(Icons.star, color:Colors.orange),
                                              ],
                                            )
                                          ],
                                        ),
                                        Text(items[index].comment??''),
                                      ],
                                    )


                                );

                              },
                            );

                          }

                          )
                      )
                    ],
                  );
                }

            },

          )

        ],
      ),
    );
  }
  Widget chartRow(BuildContext context, String label, int pct) {
    return Row(
      children: [
        Text(label),
        SizedBox(width: 8),
        Icon(Icons.star, color:Colors.orange),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
          child:
          Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Text(''),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * (pct/100) * 0.7,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Text(''),
                ),
              ]

          ),
        ),
        Text(pct.toString())
      ],
    );
  }
}



