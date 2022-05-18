import 'package:finalprojectmobile/screens/sign_up/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:finalprojectmobile/screens/home/home_screen.dart';
import '../../services/auth.dart';

class Login extends StatefulWidget {
  static String routeName = "/login";
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

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

          child: Container(

            color: Colors.white,
            child:
            Column(
              children: <Widget>[
                SizedBox(height: 20),
                Image.asset('assets/images/shop-icon.png',
                    width: 80,
                    height: 80,
                    fit:BoxFit.fill
                ),
                // IconButton(
                //   onPressed: (){},
                //   icon: Icon(Icons.shopping_cart),
                //   iconSize: 100,
                //   color: Colors.black12,
                // ),
                Text('Login',style: TextStyle(color: Colors.black.withOpacity(1.0),height: 3, fontSize: 20,fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                Text(
                  error,
                  style:  TextStyle(color: Colors.red,fontSize: 14),
                ),
                SizedBox(height: 20),
                Container(
                    margin: const EdgeInsets.only(left: 40.0, right: 40.0,bottom: 10),
                    child:Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            autocorrect: true,
                            validator: (value) =>
                            value!.isEmpty ? 'Please enter your email' : null,
                            onChanged: (_value)
                            { setState(() {
                              email=_value.toString().trim();
                            });},
                            decoration: const InputDecoration(
                              hintText: 'Enter Your Email',
                              prefixIcon: Icon(Icons.account_circle_outlined),
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
                          const SizedBox(height: 10),
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
                            decoration: const InputDecoration(
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
                          SizedBox(height: 10),
                          RichText(
                              text:
                              TextSpan(
                                text: "Forgot Password?",
                                style: TextStyle(color: Colors.black),
                              ),


                          ),

                          Container(
                            height: 50.0,
                            margin: EdgeInsets.all(30),
                            child: RaisedButton(
                              onPressed: () async {
                                if(_formKey.currentState!.validate())
                                {
                                  dynamic result=await _auth.signInUsingEmailPassword(email: email, password: password);


                                  if(result==0)
                                  {
                                    setState(() {
                                      error='User not found';
                                    });
                                  }
                                  else if(result==1)
                                  {
                                    setState(() {
                                      error='Wrong password';
                                    });
                                  }
                                  else if(result==2)
                                  {
                                    setState(() {
                                      error='Invalid email';
                                    });
                                  }
                                  else if(result==3)
                                {

                                setState(() {
                                error='Please verify email';
                                });
                                }
                                    else
                                      {

                                        Get.offNamed('/home');
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
                                    "Login",
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


                SizedBox(height: 50),

                RichText(
                    text:
                    TextSpan(
                      text: "Don't have an account?",
                      style: TextStyle(color: Colors.black26),
                      recognizer: new TapGestureRecognizer()..onTap= () =>Get.to(Signup())
                    )

                ),

              ],
            ),
          ),
        )


    );
  }
}