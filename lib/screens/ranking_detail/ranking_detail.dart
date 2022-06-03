

import 'package:finalprojectmobile/models/RankingDetail.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';
import "package:intl/intl.dart";

class RankingDetail extends StatelessWidget {
  final num? score;
  const RankingDetail({Key? key,this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final users=Provider.of<Users>(context);
    Query<Map<String, dynamic>> ranking = FirebaseFirestore.instance.collection(
        'rankingDetail').where('userId', isEqualTo: users.uid);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Xếp hạng'),
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: ranking.snapshots(),
        builder:(context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          dynamic data = snapshot.data?.docs.map((e) => e.data()).toList().first;
         Rankingdetail rank=new Rankingdetail();
          rank = Rankingdetail(
            userId: data["userId"],
            totalPrice: data["totalPrice"],
            numOfOrder:data["numOfOrder"],
          );

          return Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if(score!<50)
                          SizedBox (
                            width: 400,
                            height: 200,
                            child: Card (
                              margin: EdgeInsets.all(10),
                              color: Color(0x56E8B151),
                              shadowColor: Color(0x56E8B151),
                              elevation: 10,
                              child:
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[

                                  Column(
                                    children: [
                                      ListTile(
                                        leading: Image.asset('assets/images/member.png',
                                            width: 80,
                                            height: 100,
                                            fit:BoxFit.fill
                                        ),
                                        title: Text(
                                          "THÀNH VIÊN",
                                          style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.w600),
                                        ),

                                      ),
                                      SizedBox(height: 20,),
                                      Center(
                                        child: Text(
                                          "${score}",
                                          style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Text(
                                        "Cần ${50-score!} điểm để thăng hạng Đồng",
                                        style: TextStyle(fontSize: 17,color:Colors.white,fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        else if(score!>=50 && score!<80)
                          SizedBox (
                            width: 400,
                            height: 200,
                            child: Card (
                              margin: EdgeInsets.all(10),
                              color: Color(0x5272290F),
                              shadowColor:  Color(0x5272290F),
                              elevation: 10,
                              child:
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[


                                  Column(
                                    children: [
                                      ListTile(
                                        leading: Image.asset('assets/images/bronze.png',
                                            width: 80,
                                            height: 100,
                                            fit:BoxFit.fill
                                        ),
                                        title: Text(
                                          "ĐỒNG",
                                          style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.w600),
                                        ),

                                      ),
                                      SizedBox(height: 20,),
                                      Center(
                                        child: Text(
                                          "Điểm: ${score}",
                                          style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Text(
                                        "Cần ${80-score!} điểm để thăng hạng Bạc",
                                        style: TextStyle(fontSize: 17,color:Colors.white,fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  )


                                ],
                              ),
                            ),
                          )
                        else if(score!>=80 && score!<150)
                            SizedBox (
                              width: 400,
                              height: 200,
                              child: Card (
                                margin: EdgeInsets.all(10),
                                color: Color(0x43C0C0C0),
                                shadowColor: Color(0x43C0C0C0),
                                elevation: 10,
                                child:
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[

                                    Column(
                                      children: [
                                        ListTile(
                                          leading: Image.asset('assets/images/silver.png',
                                              width: 80,
                                              height: 100,
                                              fit:BoxFit.fill
                                          ),
                                          title: Text(
                                            "BẠC",
                                            style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.w600),
                                          ),

                                        ),
                                        SizedBox(height: 20,),
                                        Center(
                                          child: Text(
                                            "Điểm: ${score}",
                                            style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Text(
                                          "Cần ${150-score!} điểm để thăng hạng Vàng",
                                          style: TextStyle(fontSize: 17,color:Colors.black,fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    )


                                  ],
                                ),
                              ),
                            )
                          else if(score!>=150 && score!<200)
                              SizedBox (
                                width: 400,
                                height: 200,
                                child: Card (
                                  margin: EdgeInsets.all(10),
                                  color: Color(0x60F1DC10),
                                  shadowColor: Color(0x60F1DC10),
                                  elevation: 10,
                                  child:
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[


                                      Column(
                                        children: [
                                          ListTile(
                                            leading: Image.asset('assets/images/gold.png',
                                                width: 80,
                                                height: 100,
                                                fit:BoxFit.fill
                                            ),
                                            title: Text(
                                              "VÀNG",
                                              style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.w600),
                                            ),

                                          ),
                                          SizedBox(height: 20,),
                                          Center(
                                            child: Text(
                                              "Điểm: ${score}",
                                              style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Text(
                                            "Cần ${200-score!} điểm để thăng hạng Kim cương",
                                            style: TextStyle(fontSize: 17,color:Colors.white,fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      )


                                    ],
                                  ),
                                ),
                              )
                            else
                              SizedBox (
                                width: 400,
                                height: 200,
                                child: Card (
                                  margin: EdgeInsets.all(10),
                                  color: Color(0x0F103FCB),
                                  shadowColor: Color(0x0F103FCB),
                                  elevation: 10,
                                  child:
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[

                                      Column(
                                        children: [
                                          ListTile(
                                            leading: Image.asset('assets/images/diamond.png',
                                                width: 60,
                                                height: 100,
                                                fit:BoxFit.fill
                                            ),
                                            title: Text(
                                              "KIM CƯƠNG",
                                              style: TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.w600),
                                            ),

                                          ),
                                          SizedBox(height: 20,),
                                          Center(
                                            child: Text(
                                              "Điểm: ${score}",
                                              style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.w600),
                                            ),
                                          ),

                                        ],
                                      )

                                    ],
                                  ),
                                ),
                              )

                      ]
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox (
                          width: 400,
                          height: 200,
                          child: Card (
                            margin: EdgeInsets.all(10),
                            color: Color(0x3151E865),
                            shadowColor: Color(0x3151E865),
                            elevation: 10,
                            child:
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(

                                  title: Text(
                                    "CHI TIÊU",
                                    style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w600),
                                  ),

                                ),
                                SizedBox(height: 20,),
                                Center(
                                  child: Text(
                                    "${NumberFormat.currency(locale: 'vi').format(rank.totalPrice)}",
                                    style: TextStyle(fontSize: 30,color: kPrimaryColor,fontWeight: FontWeight.w600),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        SizedBox (
                          width: 400,
                          height: 200,
                          child: Card (
                            margin: EdgeInsets.all(10),
                            color: Color(0x37E8B651),
                            shadowColor: Color(0x37E8B651),
                            elevation: 10,
                            child:
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(

                                  title: Text(
                                    "SỐ ĐƠN HÀNG",
                                    style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w600),
                                  ),

                                ),
                                SizedBox(height: 20,),
                                Center(
                                  child: Text(
                                    "${rank.numOfOrder}",
                                    style: TextStyle(fontSize: 30,color: kPrimaryColor,fontWeight: FontWeight.w600),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        )
                      ]
                  ),
                ),
              ),
            ]
          );
        }
      )

    );
  }
}
