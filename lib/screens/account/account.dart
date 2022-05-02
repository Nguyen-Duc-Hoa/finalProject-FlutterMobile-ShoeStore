
import 'package:final_project_mobile/screens/address/address_screen.dart';
import 'package:final_project_mobile/screens/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
import '../../models/user.dart';
import '../../services/auth.dart';
import '../sign_in/login_screen.dart';

class Account extends StatelessWidget {
   Account({Key? key}) : super(key: key);
  final AuthService _auth=AuthService();
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<Users>(context);
    if(user==null)
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
                          colors: [Color(0xfff307c1), Color(0xffff64c6)],
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
                      backgroundImage: AssetImage("${user.avatar}"),
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
                    Container(
                      margin: EdgeInsets.all(5),
                      color: Color(0x14B6B8B6),
                      child: ListTile(
                        title: Text('Đăng xuất'),
                        leading: Icon(Icons.logout,color: Colors.black),
                        trailing: Icon(Icons.keyboard_arrow_right_sharp),
                        onTap: (){

                          Get.offNamed("/login");
                          _auth.signOut();
                        },
                      ),
                    )
                  ],
                ),
              )

            ],
          ),
        );
    }


  }
}

