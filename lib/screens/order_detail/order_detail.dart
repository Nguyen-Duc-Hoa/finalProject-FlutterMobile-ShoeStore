import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants.dart';
import '../../models/Order.dart';
import '../../models/OrderItem.dart';
import "package:intl/intl.dart";
import 'package:rating_dialog/rating_dialog.dart';

class OrderDetail extends StatelessWidget {
  static String routeName = "/orderdetail";

  Order order;
  OrderDetail({Key? key,required this.order}) : super(key: key);
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference orderItem = FirebaseFirestore.instance.collection('orderItem');


  @override
  Widget build(BuildContext context) {
   final String status;
    if(order.status==0)
      status='Chờ xác nhận';
    else if(order.status==1)
      status='Chờ lấy hàng';
    else if(order.status==2)
      status='Đang giao';
    else if(order.status==3)
      status='Đã giao';
    else
      status='Đã hủy';
    void _showRatingAppDialog(index) {
      final _ratingDialog = RatingDialog(
          initialRating: 5.0,
          title: Text(
            'Đánh giá sản phẩm ${index}',
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
    // List<OrderItem> items=[
    //   OrderItem(orderId: 'awueter162432', productId: 1, productName: 'Nike Sport White - Man Pant', image: 'assets/images/shoe1.png',
    //       quantity: 1, price: 50.5, size: 36, color: '0xFFF6625E'),
    //   OrderItem(orderId: 'awueter162432', productId: 2, productName: 'Gloves XC Omega - Polygon', image: 'assets/images/shoe1.png',
    //       quantity: 2, price: 64.99, size: 40, color: '0xFF836DB8'),
    // ];
    // Order order=
    // Order(id: "#DEFGH",
    //     userId: '',
    //     name: "Nguyen Duc Hoa",
    //     orderDate: DateTime.now(),
    //     phone: "0123456789",
    //     payment: "payment",
    //     total: 100.00,
    //     address: "165 1st, Pham Van Dong, HCM",
    //     voucherId: "",
    //     voucherValue: 0,
    //     status: 3);


    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text('Thông tin đơn hàng',),

      ),
      body: StreamBuilder(
        stream: orderItem.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          var dataList = snapshot.data?.docs.map((e) => e.data()).toList();

          List<OrderItem> lstOrderItems = [];
          List<OrderItem> items = [];
          dataList?.forEach((element) {
            final Map<String, dynamic> doc = element as Map<String, dynamic>;
            OrderItem item = OrderItem(orderId: doc["orderId"],
              productId: doc["productId"],
              productName: doc["productName"],
              price: doc["price"],
              image: doc["image"],
              color: doc["color"],
              size: doc["size"],
              quantity: doc["quantity"],
            );

            lstOrderItems.add(item);
          });

          items = lstOrderItems
              .where((element) => element.orderId == order.id)
              .toList();
          return  ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.orange,


                ),
                child:  Padding(padding: EdgeInsets.only(top: 20,bottom: 20,left: 20,right: 20),

                    child: Text('Đơn hàng ${status} \nMã đơn hàng: ${order.id} \nNgày đặt hàng: ${order.orderDate.toString().substring(0, order.orderDate.toString().lastIndexOf(":"))}',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w600),)


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
                  List.generate(items.length, (index) {
                    return
                      Column(
                        children: [
                          Padding(padding: EdgeInsets.only(top: 10,right: 25,left: 25,bottom: 10),
                            child: Row(
                              children: [
                                Container(
                                    width: (MediaQuery.of(context).size.width-170)/2,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(20),
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
                                              color:Color(int.parse(items[index].color)) ,
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
                                child: FlatButton(onPressed: (){_showRatingAppDialog(items[index].productId);},
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
                    Text('Tổng thanh toán', style: TextStyle(fontSize: 17,fontWeight: FontWeight.w300,color: Colors.black.withOpacity(0.5)),),
                    Text('${NumberFormat.currency(locale: 'vi').format(order.total-order.voucherValue)}', style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.red),),

                  ],

                ),
              ),


              Padding(padding: EdgeInsets.only(bottom: 10),

                  child: ListTile(
                      title: Text('Payment'),

                      trailing:  Text('${order.payment}')

                  )



              ),



            ],
          );
        },
      )

    );
  }
}
