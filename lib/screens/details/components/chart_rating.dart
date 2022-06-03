
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../constants.dart';
import '../../../models/Rate.dart';
import '../../../models/user.dart';

class Chart_Rating extends StatelessWidget {
  List<int> pct;
  final num id;
  Chart_Rating({Key? key,required this.pct,required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Query<Map<String, dynamic>> rate = FirebaseFirestore.instance.collection(
        'rate').where('productId', isEqualTo: id);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Đánh giá sản phẩm'),
      ),
      body: StreamBuilder(
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
            return Container(
              margin: EdgeInsets.all(15),
              child:
              Column(

                children: [

                  SizedBox(height: 8),
                  chartRow(context, '5', pct[4]),
                  chartRow(context, '4', pct[3]),
                  chartRow(context, '3', pct[2]),
                  chartRow(context, '2', pct[1]),
                  chartRow(context, '1',pct[0]),
                  SizedBox(height: 8),


                ],
              ),
            );
          }
          else
          {

            return ListView(
              children: [
                Container(
                  margin: EdgeInsets.all(15),
                  child:
                  Column(

                    children: [

                      SizedBox(height: 8),
                      chartRow(context, '5', pct[4]),
                      chartRow(context, '4', pct[3]),
                      chartRow(context, '3', pct[2]),
                      chartRow(context, '2', pct[1]),
                      chartRow(context, '1',pct[0]),
                      SizedBox(height: 8),


                    ],
                  ),
                ),
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

                          return  Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: ListTile(
                                leading: GestureDetector(

                                  child: Container(
                                    height: 50.0,
                                    width: 50.0,
                                    decoration: new BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: new BorderRadius.all(Radius.circular(50))),
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage("${user.avatar.toString()}"),
                                    ),
                                  ),
                                ),
                                title: Text(user.name??'', style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        for(int i=1;i<=5;i++)
                                        Stack(
                                          children: [

                                              Icon(Icons.star, color:Colors.black12),
                                            if(i<=items[index].rate)
                                            Icon(Icons.star, color:Colors.orange),
                                          ],
                                        )
                                      ],
                                    ),
                                    Text(items[index].comment??''),
                                  ],
                                )


                            ),
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

    );
  }
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
