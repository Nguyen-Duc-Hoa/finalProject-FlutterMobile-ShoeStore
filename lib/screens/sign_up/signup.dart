
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../services/auth.dart';
import '../sign_in/login_screen.dart';
class Signup extends StatefulWidget {

  static String routeName = "/signup";
  @override
  State<Signup> createState() => _SignupState();
}
void showToastMessage(String message){
  Fluttertoast.showToast(
      msg: message, //message to show toast
      toastLength: Toast.LENGTH_LONG, //duration for message to show
      gravity: ToastGravity.CENTER, //where you want to show, top, bottom
      backgroundColor: Colors.pink, //background Color for message
      textColor: Colors.white, //message text color
      fontSize: 16.0 //message font size
  );
}
class _SignupState extends State<Signup> {

  dynamic _value = 1;
  final AuthService _auth=AuthService();
  final _formKey=GlobalKey<FormState>();
  String email='';
  String name='';
  String password='';
  String error='';

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SingleChildScrollView(
      child:Container(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent
        color: Colors.white,
        child: Column(


          children: <Widget>[
            SizedBox(height: 20),
            Image.asset('assets/images/shop-icon.png',
                width: 80,
                height: 80,
                fit:BoxFit.fill
            ),

            Text('Sign Up',style: TextStyle(color: Colors.black.withOpacity(1.0),height: 3, fontSize: 20,fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text(
              error,
              style:  TextStyle(color: Colors.red,fontSize: 14),
            ),
            SizedBox(height: 20),
            Container(
                margin: const EdgeInsets.only(left: 40.0, right: 40.0,bottom: 10),
                child:
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        autocorrect: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your name";
                          }
                        },
                        onChanged: (_value)
                        { setState(() {
                          name=_value.toString().trim();
                        });},
                        decoration: InputDecoration(
                          hintText: 'Name',
                          hintStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white70,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                            borderSide: BorderSide(color: Colors.black12, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.pinkAccent, width: 2),
                          ),
                        ),
                      ),

                      SizedBox(height: 10),
                      TextFormField(
                        autocorrect: true,

                        validator: (value) =>
                        value!.isEmpty ? 'Please enter your email' : null,
                        onChanged: (_value)
                        { setState(() {
                          email=_value.toString().trim();
                        });},
                        decoration: InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.email_outlined),
                          hintStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white70,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                            borderSide: BorderSide(color: Colors.black12, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.pinkAccent, width: 2),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        autocorrect: true,
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Password";
                          }
                        },
                        onChanged: (_value)
                        { setState(() {
                          password=_value;
                        });},
                        decoration: InputDecoration(
                          hintText: 'Enter Your Password',
                          prefixIcon: Icon(Icons.lock_outline),
                          hintStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white70,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                            borderSide: BorderSide(color: Colors.black12, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.pinkAccent, width: 2),
                          ),
                        ),
                      ),



                      Container(
                        height: 50.0,
                        margin: EdgeInsets.all(10),
                        child: RaisedButton(
                          onPressed: () async {
                            if(_formKey.currentState!.validate())
                              {
                                dynamic result=await _auth.registerUsingEmailPassword(name, email, password);
                                print(name);
                                print(email);
                                print(password);
                                print(result);
                                if(result==0)
                                {
                                  setState(() {
                                    error='Password weak';
                                  });
                                }
                                else if(result==1)
                                {
                                  setState(() {
                                    error='Email already';
                                  });
                                }
                                else if(result==2)
                                {
                                  setState(() {
                                    error='Invalid email';
                                  });
                                }
                                else
                                {
                                  showToastMessage("Verify email to login");
                                  Get.to(Login());
                                }
                              }

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
                                "Sign Up",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white, fontSize: 15),
                              ),

                            ),
                          ),
                        ),
                      ),

                    ],
                  )
                )

            ),





          ],
        ),
      ),
      )
    );
  }
}