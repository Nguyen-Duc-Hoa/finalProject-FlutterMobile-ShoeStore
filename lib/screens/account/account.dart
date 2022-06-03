
import 'package:finalprojectmobile/models/Ranking.dart';
import 'package:finalprojectmobile/screens/address/address_screen.dart';
import 'package:finalprojectmobile/screens/profile/profile.dart';
import 'package:finalprojectmobile/screens/ranking_detail/ranking_detail.dart';
import 'package:finalprojectmobile/screens/wallet/wallet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';
import '../../services/auth.dart';
import '../sign_in/login_screen.dart';

class Account extends StatelessWidget {
   Account({Key? key}) : super(key: key);
  final AuthService _auth=AuthService();
  @override
  Widget build(BuildContext context) {
    final users=Provider.of<Users>(context);

    if(users==null)
      {
        return Center(

          child: Container(
            width: 250,
            height: 50,
            child:    RaisedButton(
                  onPressed: () {
                    Get.to(Login());
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFFC560A), Color(0xFFFCA931)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Container(
                      constraints:
                      BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Login",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                )


          ),
        );
      }
    else
    {
      Query<Map<String, dynamic>> u = FirebaseFirestore.instance.collection(
          'user').where('uid', isEqualTo: users.uid);
      Query<Map<String, dynamic>> rank = FirebaseFirestore.instance.collection(
          'ranking').where('userId', isEqualTo: users.uid);
      return StreamBuilder(
          stream: u.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            dynamic data = snapshot.data?.docs.map((e) => e.data()).toList().first;
            Users user = Users();
            user = Users(
              uid: data["uid"],
              name: data["name"],
              phone:data["phone"],
              email: data["email"],
              avatar: data["avatar"],

            );
            return
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Container(
                      height: 115,
                      width: 115,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage('${user.avatar.toString()}'),
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text("${user.name}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),

                    Expanded(
                      child: ListView(

                        children: [
                          Container(
                            margin: EdgeInsets.all(5),
                            color: Color(0x14B6B8B6),
                            child: ListTile(
                              title: Text('Thông tin'),
                              leading: Icon(Icons.account_circle,color: Colors.blue),
                              trailing: Icon(Icons.keyboard_arrow_right_sharp),
                              onTap: (){

                                Get.to(Profile());

                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(5),

                            color: Color(0x14B6B8B6),
                            child: ListTile(
                              title: Text('Địa chỉ nhận hàng'),
                              leading: Icon(Icons.location_on_outlined,color: Colors.red,),
                              trailing: Icon(Icons.keyboard_arrow_right_sharp),
                              onTap: (){

                                Get.to(AddressScreen());

                              },
                            ),
                          ),
                          StreamBuilder(
                            stream: rank.snapshots(),
                            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text('Something went wrong');
                              }

                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Text("Loading");
                              }
                              dynamic data = snapshot.data?.docs.map((e) => e.data()).toList().first;
                              Ranking ranking = Ranking();
                              ranking = Ranking(
                                userId: data["userId"],
                                score: data["score"],
                              );
                              return Container(
                                margin: EdgeInsets.all(5),

                                color: Color(0x14B6B8B6),
                                child: ListTile(
                                  title: Text('Hạng'),
                                  leading: Icon(Icons.military_tech_outlined,color: Colors.orangeAccent,),
                                  trailing:Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
            children: [

            if(ranking.score!<50)
            Text('Vô hạng')
            else if(ranking.score!>=50 && ranking.score!<80)
            Text('Đồng')
            else if(ranking.score!>=80 && ranking.score!<150)
            Text('Bạc')
              else if(ranking.score!>=150 && ranking.score!<200)
                  Text('Vàng')
            else
            Text('Kim cương'),

            ],
            ),

                              onTap: (){
                                Get.to(RankingDetail(score: ranking.score));
                              },
                              ),
                              );

                            },
                          ),


                          Container(
                            margin: EdgeInsets.all(5),
                            color: Color(0x14B6B8B6),
                            child: ListTile(
                              title: Text('Ngôn ngữ'),
                              leading: Icon(Icons.language,color: Colors.grey),
                              trailing: Icon(Icons.keyboard_arrow_right_sharp),
                              onTap: (){

                                Get.to(Profile());

                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(5),
                            color: Color(0x14B6B8B6),
                            child: ListTile(
                              title: Text('Ví của tôi'),
                              leading: Icon(Icons.account_balance_wallet_outlined,color: Colors.red),
                              trailing: Icon(Icons.keyboard_arrow_right_sharp),
                              onTap: (){

                                Get.to(WalletScreen());

                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(5),
                            color: Color(0x14B6B8B6),
                            child: ListTile(
                              title: Text('Đăng xuất'),
                              leading: Icon(Icons.logout,color: Colors.black),
                              trailing: Icon(Icons.keyboard_arrow_right_sharp),
                              onTap: (){

                                Get.offNamed("/home");
                                _auth.signOut();
                              },
                            ),
                          ),
                        ],
                      ),
                    )

                  ],
                ),
              );
          }

      );

    }


  }
}

