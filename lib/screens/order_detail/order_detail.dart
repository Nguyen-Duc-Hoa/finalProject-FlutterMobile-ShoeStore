import 'package:flutter/material.dart';

import '../../models/Order.dart';
import '../../models/OrderItem.dart';
import "package:intl/intl.dart";

class OrderDetail extends StatelessWidget {
  static String routeName = "/orderdetail";
  const OrderDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<OrderItem> items=[
      OrderItem(orderId: 'awueter162432', productId: 1, productName: 'Nike Sport White - Man Pant', image: 'assets/images/shoe1.png',
          quantity: 1, price: 50.5, size: 36, color: Color(0xFFF6625E)),
      OrderItem(orderId: 'awueter162432', productId: 2, productName: 'Gloves XC Omega - Polygon', image: 'assets/images/shoe1.png',
          quantity: 2, price: 64.99, size: 40, color: Color(0xFF836DB8)),
    ];
    Order order=
    Order(id: "#DEFGH",
        userId: 1,
        name: "Nguyen Duc Hoa",
        datetime: DateTime.now(),
        phone: "0123456789",
        payment: "payment",
        total: 100.00,
        address: "165 1st, Pham Van Dong, HCM",
        voucherId: "",
        discount: 0,
        status: 0);


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        title: Text('Thông tin đơn hàng'),
      ),
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.orange,


            ),
            child:  Padding(padding: EdgeInsets.only(top: 20,bottom: 20,left: 20,right: 20),

              child: Text('Đơn hàng ${order.status} \nMã đơn hàng: ${order.id} \nNgày đặt hàng:${order.datetime}',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w600),)


            ),
          ),
          Container(
            decoration: BoxDecoration(

              border: Border(
                  bottom: BorderSide(color: Colors.black)
              ),

            ),
            child:  Padding(padding: EdgeInsets.only(top: 10,bottom: 10),

              child: ListTile(
                title: Text('Địa chỉ nhận hàng'),
                leading: Icon(Icons.location_on_outlined,color: Colors.red),

                subtitle: Text('${order.name} \n${order.phone} \n${order.address}'),

              ),


            ),
          ),
          Column(
              children:
              List.generate(2, (index) {
                return Padding(padding: EdgeInsets.only(top: 10,right: 25,left: 25,bottom: 10),
                  child: Row(
                    children: [
                      Container(
                          width: (MediaQuery.of(context).size.width-100)/2,
                          height: 100,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [BoxShadow(
                                  spreadRadius: 1,
                                  blurRadius: 0.5,
                                  color: Colors.orange
                              )],
                              image: DecorationImage(image: AssetImage('${items[index].image}'),
                                  fit:BoxFit.cover))
                      ),
                      SizedBox(width: 25,),
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${items[index].productName}',
                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                          ),
                          SizedBox(width: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${NumberFormat.currency(locale: 'vi').format(items[index].price)}",
                                style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.red),
                              ),
                              Container(

                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: items[index].color,
                                    shape: BoxShape.circle,
                                  ),
                                ),

                                width: 20,
                                height: 20,

                              ),
                              Text('${items[index].size}'),
                              Text("x${items[index].quantity}",
                                style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),
                              ),
                            ],
                          )

                        ],
                      ))
                    ],

                  ),
                );

              }

              )

          ),
          Padding(padding: EdgeInsets.only(top: 20,right: 25,left: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tổng thanh toán', style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600,color: Colors.black.withOpacity(0.5)),),
                Text('${NumberFormat.currency(locale: 'vi').format(order.total-order.total*(order.discount/100))}', style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600,color: Colors.red),),

              ],

            ),
          ),


          Padding(padding: EdgeInsets.only(bottom: 25),

              child: ListTile(
                  title: Text('Payment'),

                  trailing:  Text('Thanh toán khi nhận hàng')

              )



          ),



        ],
      )
    );
  }
}
