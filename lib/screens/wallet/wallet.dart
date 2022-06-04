import 'package:finalprojectmobile/common.dart';
import 'package:finalprojectmobile/models/History.dart';
import 'package:finalprojectmobile/models/Wallet.dart';
import 'package:finalprojectmobile/screens/wallet/pincode.dart';
import 'package:finalprojectmobile/screens/wallet/recharge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants.dart';
import '../../models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final Common _common = Common();

  @override
  Widget build(BuildContext context) {
    String pin = '';
    final _formKey = GlobalKey<FormState>();
    final users = Provider.of<Users>(context);
    Query<Map<String, dynamic>> w = FirebaseFirestore.instance
        .collection('wallet')
        .where('userId', isEqualTo: users.uid);
    Query<Map<String, dynamic>> historyCol = FirebaseFirestore.instance
        .collection('history')
        .where('userId', isEqualTo: users.uid);
    void showToastMessage(String message) {
      Fluttertoast.showToast(
          msg: message,
          //message to show toast
          toastLength: Toast.LENGTH_LONG,
          //duration for message to show
          gravity: ToastGravity.BOTTOM,
          //where you want to show, top, bottom
          backgroundColor: Colors.black87,
          //background Color for message
          textColor: Colors.white,
          //message text color
          fontSize: 16.0 //message font size
          );
    }

    _showDialogAdd() async {
      await showDialog<String>(
          context: context,
          builder: (context) {
            return Form(
              key: _formKey,
              child: AlertDialog(
                contentPadding: const EdgeInsets.all(16.0),
                title: Text('Nhập mã PIN',
                    style: TextStyle(color: kPrimaryColor, fontSize: 18)),
                content: SingleChildScrollView(
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
                          if (value.length != 6) {
                            return "PIN có 6 kí tự";
                          }
                        },
                        onChanged: (_value) {
                          pin = _value.toString().trim();
                        },
                        decoration: new InputDecoration(labelText: 'PIN'),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  new FlatButton(
                      child: const Text('Cancel',
                          style: TextStyle(color: Colors.red)),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  new FlatButton(
                      child: const Text('Save',
                          style: TextStyle(color: Colors.blue)),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final add = FirebaseFirestore.instance
                              .collection('wallet')
                              .doc();
                          final json = {
                            'pin': pin,
                            'money': 0,
                            'userId': users.uid
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
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          Wallet wallet = Wallet();
          if (snapshot.data?.docs.length != 0) {
            dynamic data =
                snapshot.data?.docs.map((e) => e.data()).toList().first;
            wallet = Wallet(
              userId: data["userId"],
              pin: data["pin"],
              money: data["money"],
            );
          }
          if (wallet.userId == null) {
            return Center(
              child: Container(
                  width: 250,
                  height: 50,
                  child: RaisedButton(
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
                  )),
            );
          } else {
            return SafeArea(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Container(
                //   padding: EdgeInsets.all(16.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       CircleAvatar(
                //         backgroundImage:
                //             NetworkImage('${users.avatar.toString()}'),
                //       ),
                //       SizedBox(width: 40.0),
                //       const Text(
                //         "Ví ShopshoePay",
                //         style: TextStyle(
                //             color: kPrimaryColor,
                //             fontSize: 20.0,
                //             fontWeight: FontWeight.bold),
                //       )
                //     ],
                //   ),
                // ),
                const SizedBox(height: 30.0),
                Text("Số dư ví",
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold)),
                Text(_common.formatCurrency(wallet.money?.toDouble() ?? 0),
                    style: TextStyle(
                        color: kPrimaryColor.withOpacity(1),
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap: () async{
                    bool result = await Get.to(PinCodeScreen(pin: wallet.pin.toString()));
                    if(result == true){
                      Get.to(RechargeScreen());
                    }
                  },
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                        color: kPrimaryLightColor,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Icon(
                      Icons.account_balance_wallet_outlined,
                      color: kPrimaryColor,
                      size: 32.0,
                    ),
                  ),
                ),
                Text('Nạp tiền',
                    style: TextStyle(color: kPrimaryColor, fontSize: 17.0)),

                const SizedBox(height: 50.0),
                StreamBuilder(
                    stream: historyCol.snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      List<History> lstHis = [];
                      if (snapshot.hasError) {}
                      if (snapshot.data?.docs.length != 0) {
                        var dataList =
                            snapshot.data?.docs.map((e) => e.data()).toList();

                        dataList?.forEach((element) {
                          final Map<String, dynamic> doc =
                              element as Map<String, dynamic>;
                          History history = History(
                            userId: doc["userId"],
                            name: doc["name"],
                            total: doc["total"].toDouble(),
                            date: doc["date"].toDate(),
                            description: doc["description"],
                            orderId: doc["orderId"]
                          );
                          lstHis.add(history);
                        });
                      }
                      return Expanded(
                          child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(
                            top: 26.0, left: 16.0, right: 16.0),
                        decoration: BoxDecoration(
                            color: kPrimaryColor.withOpacity(0.7),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(60.0),
                                topRight: Radius.circular(60.0))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Giao dịch gần nhất",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 25.0),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: lstHis.length,
                                  itemBuilder: (context, index) {
                                      return listTitle(Icons.shopping_cart, kPrimaryColor,
                                          lstHis[index]);
                                  }
                              ),
                            )
                          ],
                        ),
                      ));
                    })
              ],
            ));
          }
        },
      ),
    );
  }
}

Widget listTitle(IconData icon, Color color, History history) {
  Common _common = Common();
  return InkWell(
    onTap: () {},
    child: Container(
      margin: EdgeInsets.only(bottom: 16.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
            child: Icon(
              icon,
              color: color,
              size: 32.0,
            ),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  history.name.toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 2.0,
                ),
                Text(
                  history.description.toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Column(
            children: [
              Text(
                _common.formatCurrency(history.total ?? 0),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 2.0,
              ),
              Text(
                history.date
                    .toString()
                    .substring(0, history.date.toString().lastIndexOf(":")),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    ),
  );
}
