import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../models/Order.dart';
import '../../models/OrderItem.dart';
import "package:intl/intl.dart";
import 'package:rating_dialog/rating_dialog.dart';

class OrderDetail extends StatelessWidget {
  static String routeName = "/orderdetail";
  const OrderDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _showRatingAppDialog(index) {
      final _ratingDialog = RatingDialog(
          initialRating: 5.0,
          title: Text(
            'Đánh giá ${index}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),

          message: Text(
            'Hãy cho chúng tôi biết sự hài lòng của bạn về sản phẩm này nhé ',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15),
          ),

          submitButtonText: 'Submit',
          onCancelled: () => print('cancelled'),
          onSubmitted: (response) {
            print('rating: ${response.rating}, '
                'comment: ${response.comment}');

          }
      );

      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => _ratingDialog,
      );
    }
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
        status: 3);


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
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
                return
                  Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 10,right: 25,left: 25,bottom: 10),
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
                      ),
                      if(order.status==3)
                      Padding(padding: EdgeInsets.only(top:10,right: 20,left: 20),
                          child: FlatButton(onPressed: (){_showRatingAppDialog(index);},
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.deepOrangeAccent,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              height: 40,

                              child: Center(
                                child: Text('Đánh giá',style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600
                                ),),
                              ),
                            ),
                          )
                      )
                    ],

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
