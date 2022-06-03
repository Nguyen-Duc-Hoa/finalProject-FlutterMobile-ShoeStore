
import 'package:finalprojectmobile/models/Wallet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants.dart';
import '../../models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String pin='';
    final _formKey=GlobalKey<FormState>();
    final users = Provider.of<Users>(context);
    Query<Map<String, dynamic>> w = FirebaseFirestore.instance.collection(
        'wallet').where('userId', isEqualTo: users.uid);
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
    _showDialogAdd() async {
      await showDialog<String>(
          context: context,

          builder:(context){
            return Form(
              key: _formKey,
              child: AlertDialog(
                contentPadding: const EdgeInsets.all(16.0),
                title: Text('Nhập mã PIN',style: TextStyle(color: kPrimaryColor,fontSize: 18)),
                content:
                SingleChildScrollView(
                  child: Column(

                    children: [

                      TextFormField(
                        autofocus: true,
                        initialValue: null,
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter PIN";
                          }
                          if(value.length!=6)
                            {
                              return "PIN có 6 kí tự";
                            }
                        },
                        onChanged: (_value){
                          pin=_value.toString().trim();
                        },
                        decoration: new InputDecoration(
                            labelText: 'PIN'),
                      ),

                    ],

                  ),
                ),
                actions: <Widget>[
                  new FlatButton(
                      child: const Text('Cancel',style: TextStyle(color: Colors.red)),

                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  new FlatButton(
                      child: const Text('Save',style: TextStyle(color: Colors.blue)),
                      onPressed: () async{
                        if(_formKey.currentState!.validate())
                        {
                          final add =FirebaseFirestore.instance.collection('wallet').doc();
                          final json={
                            'pin':pin,
                            'money':0,
                            'userId':users.uid
                          };
                          await add.set(json);
                          showToastMessage('Tạo ví thành công');
                          Navigator.pop(context);
                        }



                      })
                ],
              ),
            );
          });


    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Ví của tôi'),
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: w.snapshots(),
        builder:  (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          Wallet wallet= Wallet();
          if(snapshot.data?.docs.length!=0)
          {

            dynamic data = snapshot.data?.docs.map((e) => e.data()).toList().first;
            wallet = Wallet(userId: data["userId"],
              pin: data["pin"],
              money: data["money"],

            );
          }
          if(wallet.userId==null)
            {
              return Center(

                child: Container(
                    width: 250,
                    height: 50,
                    child:    RaisedButton(
                      onPressed: () {
                        _showDialogAdd();
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
                            "Tạo ví",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ),
                      ),
                    )


                ),
              );
            }
          else{
            return Container();
          }
        },
      ),
    );
  }
}
