
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import '../../services/auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final AuthService _auth=AuthService();

  final _formKey=GlobalKey<FormState>();
  String email='';
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
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Quên mật khẩu'),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(top:10,left: 40.0, right: 40.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 10),
                Text(
                  error,
                  style:  TextStyle(color: Colors.red,fontSize: 14),
                ),
                TextFormField(
                  autocorrect: true,
                  validator: (value) =>
                  value!.isEmpty ? 'Please enter your email' : null,
                  onChanged: (_value)
                  {
                    email=_value.toString().trim();
                  },
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
                      borderSide: BorderSide(color: kPrimaryColor, width: 2),
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                Container(
                  height: 50.0,
                  margin: EdgeInsets.all(30),
                  child: RaisedButton(
                    onPressed: () async {
                      if(_formKey.currentState!.validate())
                      {
                        dynamic result=await _auth.forgotPassword(email);
                        print(result);
                        if(result==0)
                        {
                          setState(() {
                            error='User not found';
                          });
                        }

                        else if(result==1)
                        {
                          setState(() {
                            error='Invalid email';
                          });
                        }

                        else
                        {

                          Get.offNamed('/login');
                          showToastMessage('Check email to reset password');
                        }
                      }


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
                          "Send email",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




