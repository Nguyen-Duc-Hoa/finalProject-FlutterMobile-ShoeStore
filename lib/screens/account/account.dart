
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
        return Login();
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
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        onPressed: (){

                        },
                        icon: Icon(Icons.edit),
                        hoverColor: Colors.white,
                        highlightColor: Colors.white,
                        splashColor: Colors.white,
                        color: Colors.black,
                      ),
                    )
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
                      color: Colors.black12,
                      child: ListTile(
                        title: Text('Thông tin'),
                        leading: Icon(Icons.account_circle,color: Colors.blue),
                        trailing: Icon(Icons.keyboard_arrow_right_sharp),

                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),

                      color: Colors.black12,
                      child: ListTile(
                        title: Text('Địa chỉ nhận hàng'),
                        leading: Icon(Icons.add_location_alt_outlined,color: Colors.red,),
                        trailing: Icon(Icons.keyboard_arrow_right_sharp),

                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      color: Colors.black12,
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

