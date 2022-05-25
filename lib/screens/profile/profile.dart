import 'package:finalprojectmobile/common.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../services/auth.dart';
import 'package:get/get.dart';

import '../sign_in/login_screen.dart';



class Profile extends StatelessWidget {
  static String routeName = "/profile";

   Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService auth=AuthService();
    final _formKeyEdit=GlobalKey<FormState>();
    final _formKeyChangePass=GlobalKey<FormState>();
    final users = Provider.of<Users>(context);
    String password='';
    String error='';
    void showToastMessage(String message){
      Fluttertoast.showToast(
          msg: message, //message to show toast
          toastLength: Toast.LENGTH_LONG, //duration for message to show
          gravity: ToastGravity.BOTTOM, //where you want to show, top, bottom
          backgroundColor: Colors.black87, //background Color for message
          textColor: Colors.white, //message text color
          fontSize: 16.0 //message font size
      );
    }
    bool? validateCurrentPassword(String password){




    }
    _showDialog(title, value,type,snapshot) async {
      String change=value;

      await showDialog<String>(
          context: context,

          builder: (context) {
            return Form(
              key:  _formKeyEdit,
              child: AlertDialog(
                contentPadding: const EdgeInsets.all(16.0),
                content: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: TextFormField(
                        autofocus: true,
                        initialValue: value,

                        validator: (value){
                          if(type=='name')
                            {
                              if(value!.isEmpty)
                                return 'Please enter your name';
                              else return null;
                            }
                          else if(type=='phone')
                            {
                             Common().validateMobile(value!);
                            }
                          else if(type=='email')
                            {

                            }
                        },

                        onChanged: (_value){

                            change=_value.toString().trim();

                        },
                        decoration: new InputDecoration(
                            labelText: '${title}'),
                      ),
                    )
                  ],
                ),
                actions: <Widget>[
                  new FlatButton(
                      child: const Text(
                          'Cancel', style: TextStyle(color: Colors.red)),

                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  // ignore: deprecated_member_use
                  new FlatButton(
                      child: const Text(
                          'Save', style: TextStyle(color: Colors.blue)),
                      onPressed: () async{
                        if(_formKeyEdit.currentState!.validate()){
                          if(type=='name')
                          {
                            final DocumentSnapshot data = snapshot.data!.docs[0];
                            FirebaseFirestore.instance
                                .collection('user')
                                .doc(data.id).update({
                              'name':change,
                            });

                            Navigator.pop(context);
                          }
                          else if(type=='phone'){
                            final DocumentSnapshot data = snapshot.data!.docs[0];
                            FirebaseFirestore.instance
                                .collection('user')
                                .doc(data.id).update({
                              'phone':change,
                            });

                            Navigator.pop(context);
                          }
                          else if(type=='email')
                          {

                            final FirebaseAuth _auth =FirebaseAuth.instance;
                            User user = _auth.currentUser!;
                            //
                            // UserCredential authResult = await user.reauthenticateWithCredential(
                            //   EmailAuthProvider.credential(
                            //     email: user.email??'',
                            //     password: 'password',
                            //   ),
                            // );
                            

                            await user.verifyBeforeUpdateEmail(change).then((value) {
                              showToastMessage("Verify email");

                            }).catchError((error) {

                              if (error.code == 'email-already-in-use')
                                showToastMessage("Email đã tồn tại");
                              else if(error.code=='requires-recent-login')
                                Get.offNamed('/login');

                            });
                            //    print(users.email);
                            //    final FirebaseAuth _a =FirebaseAuth.instance;
                            // await _a.currentUser!.reload() ;
                            //    print(_a.currentUser!.email);


                          }
                        }

                      })
                ],
              ),
            );
          });
    }
    _changePassword() async {
      await showDialog<String>(
          context: context,

          builder: (context) {
            return Form(
              key: _formKeyChangePass,
              child: AlertDialog(
                title: Text('Đổi mật khẩu',
                  style: TextStyle(color: kPrimaryColor, fontSize: 18),),
                contentPadding: const EdgeInsets.all(16.0),
                content:
                SingleChildScrollView(
                  child: Column(
                    children: [

                      TextFormField(
                        obscureText: true,
                        autofocus: true,
                        initialValue: null,
                      validator: (value) {
                        if(value!.isEmpty)
                          return 'Please enter current password';

                      },
                      onChanged: (_value){

                        password=_value.toString().trim();

                      },
                        decoration: new InputDecoration(
                            labelText: 'Current Password'),
                      ),

                      TextFormField(
                        obscureText: true,
                        autofocus: true,
                        initialValue: null,
                        decoration: new InputDecoration(
                            labelText: 'New Password'),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  new FlatButton(
                      child: const Text(
                          'Cancel', style: TextStyle(color: Colors.red)),

                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  new FlatButton(
                      child: const Text(
                          'Save', style: TextStyle(color: Colors.blue)),
                      onPressed: () async{
                        if(_formKeyChangePass.currentState!.validate())
                          {
                           // print('p');
                            final FirebaseAuth _auth =FirebaseAuth.instance;
                            User user = _auth.currentUser!;

                            var credential = EmailAuthProvider.credential(
                                email:user.email??'',
                                password: password.trim()
                            );

                           await user.reauthenticateWithCredential(credential).then((value) {
                             error='';
                            }).catchError((errors) {
                              if(errors.code=='too-many-requests')
                                {
                                  Get.offNamed('/login');
                                }
                              print(errors.code);
                              error='Incorrect Password';
                              if(error!='')
                                {
                                  showToastMessage('Incorrect current password');
                                }
                            });

                          }
                      })
                ],
              ),
            );
          });
    }
    if (users != null) {
      Query<Map<String, dynamic>> u = FirebaseFirestore.instance.collection(
          'user').where('uid', isEqualTo: users.uid);


      return Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            title: Text('Thông tin người dùng'),
          ),
          body: StreamBuilder(
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
                return Container(
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
                              //backgroundImage:  AssetImage("assets/images/user.png")
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                onPressed: () {

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
                      Expanded(
                        child: ListView(

                          children: [
                            Container(
                              margin: EdgeInsets.all(5),

                              child: ListTile(
                                  title: Text('Full Name'),
                                  leading: Icon(Icons.account_circle_outlined,
                                    color: Colors.black,),
                                  trailing: IconButton(
                                    onPressed: () {
                                      _showDialog('Full Name', user.name,'name',snapshot);
                                    },
                                    icon: Icon(Icons.edit),
                                    hoverColor: Colors.white,
                                    highlightColor: Colors.white,
                                    splashColor: Colors.white,
                                    color: Colors.black,
                                  ),
                                  subtitle: Text('${user.name}')

                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(5),

                              child: ListTile(
                                  title: Text('Email'),
                                  leading: Icon(
                                    Icons.email_outlined, color: Colors.black,),
                                  trailing: IconButton(
                                    onPressed: () {
                                      _showDialog('Email', user.email,'email',snapshot);
                                    },
                                    icon: Icon(Icons.edit),
                                    hoverColor: Colors.white,
                                    highlightColor: Colors.white,
                                    splashColor: Colors.white,
                                    color: Colors.black,
                                  ),
                                  subtitle: Text('${user.email}')

                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(5),

                              child: ListTile(
                                  title: Text('Phone'),
                                  leading: Icon(
                                    Icons.phone, color: Colors.black,),
                                  trailing: IconButton(
                                    onPressed: () {
                                      _showDialog('Phone', user.phone,'phone',snapshot);
                                    },
                                    icon: Icon(Icons.edit),
                                    hoverColor: Colors.white,
                                    highlightColor: Colors.white,
                                    splashColor: Colors.white,
                                    color: Colors.black,
                                  ),
                                  subtitle: Text('${user.phone}')

                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(5),

                              child: ListTile(
                                title: Text('Đổi mật khẩu'),
                                leading: Icon(
                                  Icons.lock_outline, color: Colors.black,),
                                onTap: () {
                                  _changePassword();
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

          )


      );
    }
    else {
      return Container();
    }
  }
}