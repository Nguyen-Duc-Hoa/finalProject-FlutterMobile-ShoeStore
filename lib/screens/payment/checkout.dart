import 'package:final_project_mobile/constants.dart';
import 'package:flutter/material.dart';
import "package:intl/intl.dart";
import '../payment/components/body.dart';
class Checkout extends StatefulWidget {
  static String routeName = "/checkout";
  const Checkout({Key? key}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text('Thanh toán'),
        ),
        body: Body(),
        bottomSheet: Container(

            color: Colors.white,
            height: 80,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
               Padding(padding: EdgeInsets.only(top: 20),
                 child:   Column(

                   children: [
                     Text("Tổng tiền"),
                     Text("${NumberFormat.currency(locale: 'vi').format(530000)}", style: TextStyle( color: Colors.red,fontSize: 15,fontWeight: FontWeight.w600)),
                   ],
                 ),
               ),


                Padding(padding: EdgeInsets.only(right: 10,left: 10),
                    child: FlatButton(onPressed: (){},
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.deepOrangeAccent,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        height: 50,
                        width: 100,
                        child: Center(
                          child: Text('Thanh toán',style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                          ),),
                        ),
                      ),
                    )
                )
              ],
            )


        ),
      );
  }
}


