import 'package:finalprojectmobile/common.dart';
import 'package:finalprojectmobile/models/OrderTracking.dart';
import 'package:finalprojectmobile/screens/order_tracking/order_tracking.dart';
import 'package:finalprojectmobile/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants.dart';
import '../../models/Order.dart';
import '../../models/OrderItem.dart';
import "package:intl/intl.dart";
import 'package:rating_dialog/rating_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class OrderDetail extends StatelessWidget {
  static String routeName = "/orderdetail";

  Order order;
  OrderDetail({Key? key,required this.order}) : super(key: key);
  FirebaseFirestore firestore = FirebaseFirestore.instance;



  @override
  Widget build(BuildContext context) {
   final String status;
    if(order.status==0)
      status='Chờ xác nhận';
    else if(order.status==1)
      status='Chờ lấy hàng';
    else if(order.status==2)
      status='Đang giao';
    else if(order.status==3||order.status==4)
      status='Đã giao';
    else
      status='Đã hủy';
   Query<Map<String, dynamic>> orderItem = FirebaseFirestore.instance.collection('orderItem').where('orderId', isEqualTo: order.id);
   Query<Map<String, dynamic>> orderTracking = FirebaseFirestore.instance.collection('orderTracking').where('orderId', isEqualTo: order.id).orderBy('time',descending: true);
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
    void _showRatingAppDialog(productId,snapshot,index) {
      final _ratingDialog = RatingDialog(
          initialRating: 5.0,
          title: Text(
            'Đánh giá sản phẩm',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          enableComment: true,
          message: Text(
            'Hãy cho chúng tôi biết sự hài lòng của bạn về sản phẩm này nhé ',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15),
          ),
          submitButtonText: 'Submit',
          onCancelled: () => print('cancelled'),
          onSubmitted: (response) async{

            int one=0;
            int two=0;
            int three=0;
            int four=0;
            int five=0;
            num oldrating=0;
            num newrating=0;
       await FirebaseFirestore.instance.collection('rate').where('productId', isEqualTo: productId).where('rate', isEqualTo: 1).get().then((value) {
          one=value.size;
        });
         await   FirebaseFirestore.instance.collection('rate').where('productId', isEqualTo: productId).where('rate', isEqualTo: 2).get().then((value) {
              two=value.size;
            });
           await FirebaseFirestore.instance.collection('rate').where('productId', isEqualTo: productId).where('rate', isEqualTo: 3).get().then((value) {
              three=value.size;
            });
         await   FirebaseFirestore.instance.collection('rate').where('productId', isEqualTo: productId).where('rate', isEqualTo: 4).get().then((value) {
              four=value.size;

            });
          await FirebaseFirestore.instance.collection('rate').where('productId', isEqualTo: productId).where('rate', isEqualTo: 5).get().then((value) {
              five=value.size;

            });
          await  FirebaseFirestore.instance.collection('products').where('id', isEqualTo: productId).get().then((value) {
              oldrating=value.docs[0].get('rate');
              int total=one+two+three+four+five;

                newrating=(oldrating*(total)+response.rating)/(total+1);

            });

            final rate =FirebaseFirestore.instance.collection('rate').doc();
            final json={
              'userId':order.userId,
              'productId':productId,
              'rate':response.rating,
              'comment':response.comment
            };
           await rate.set(json);

           FirebaseFirestore.instance.collection('products').where('id', isEqualTo: productId).get().then((value) {

             value.docs[0].reference.update({'rate':num.parse(newrating.toStringAsFixed(1)) });
           });
            FirebaseFirestore.instance.collection('ranking').where('userId', isEqualTo: order.userId).get().then((value) {
              if(response.comment=='')
              value.docs[0].reference.update({'score':value.docs[0].get('score')+3 });
              else
                value.docs[0].reference.update({'score':value.docs[0].get('score')+5 });
            });
            final DocumentSnapshot data = snapshot.data!.docs[index];

            FirebaseFirestore.instance
                .collection('orderItem')
                .doc(data.id).update({'comment':true});

           showToastMessage('Thank you');

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
              comment: doc['comment']
            );

            items.add(item);
          });

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
              StreamBuilder(
                stream: orderTracking.snapshots(),
                  builder:(context, AsyncSnapshot<QuerySnapshot> snapshot){
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }
                    OrderTracking tracking = OrderTracking();

                    if(snapshot.data?.docs.length!=0)
                      {

                        dynamic data = snapshot.data?.docs.map((e) => e.data()).toList().first;
                        tracking = OrderTracking(orderId: data["orderId"],
                          time: data["time"].toDate(),
                          note: data["note"],

                        );
                      }


                      if(tracking.orderId==null)
                        {

                          return Container();
                        }
else

                return  Container(
                  decoration: BoxDecoration(

                    border: Border(
                        bottom: BorderSide(color: Colors.grey)
                    ),

                  ),
                  child:  Padding(padding: EdgeInsets.only(top: 10,bottom: 10),

                    child: ListTile(
                      onTap: (){Get.to(Order_tracking(orderId: order.id));},
                      title: Text('Thông tin vận chuyển'),
                      leading: Icon(Icons.delivery_dining,color: Colors.black),
                        trailing: Icon(Icons.keyboard_arrow_right_sharp),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8,),
                          Text('${tracking.note}',style: TextStyle(color: Color(0xFF27AA69),fontSize: 15),),
                          SizedBox(height: 5,),
                          Text('${tracking.time.toString().substring(0, tracking.time.toString().lastIndexOf(":"))}')
                        ],
                      )


                    ),


                  ),
                );
                  }
              ),
              Container(
                decoration: BoxDecoration(

                  border: Border(
                      bottom: BorderSide(color: Colors.grey)
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
                          if(order.status==4 && items[index].comment==false)

                            Padding(padding: EdgeInsets.only(top:10,right: 20,left: 20),
                                child: FlatButton(onPressed: (){_showRatingAppDialog(items[index].productId,snapshot,index);},
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
                            ),
                          if(order.status==4 && items[index].comment==true)

                            Padding(padding: EdgeInsets.only(top:10,right: 20,left: 20),
                                child: FlatButton(onPressed: (){},
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    height: 40,

                                    child: Center(
                                      child: Text('Đã đánh giá',style: TextStyle(
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
