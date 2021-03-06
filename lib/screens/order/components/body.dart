import 'package:finalprojectmobile/common.dart';
import 'package:finalprojectmobile/models/Order.dart';
import 'package:finalprojectmobile/screens/cart/CartController.dart';
import 'package:finalprojectmobile/screens/order_detail/order_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:finalprojectmobile/models/Cart.dart';
import 'package:get/get.dart';
import 'package:finalprojectmobile/screens/cart/components/cart_card.dart';
import 'package:rating_dialog/rating_dialog.dart';
import '../../../models/OrderItem.dart';
import '../../../models/user.dart';
import '../../../size_config.dart';
import "package:intl/intl.dart";
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../sign_in/login_screen.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.status}) : super(key: key);

  final int status;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final CartController _cartController = Get.find();
  final int page = 1;
  final int num = 10;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference orderItem =
  FirebaseFirestore.instance.collection('orderItem');
  final Common _common = Common();

  @override
  Widget build(BuildContext context) {

    // List<OrderItem> items = [
    //   OrderItem(orderId: '#DEFGH',
    //       productId: 1,
    //       productName: 'Nike Sport White - Man Pant',
    //       image: 'assets/images/shoe1.png',
    //       quantity: 1,
    //       price: 50.5,
    //       size: 36,
    //       color: Color(0xFFF6625E)),
    //   OrderItem(orderId: '#DEFGH',
    //       productId: 2,
    //       productName: 'Gloves XC Omega - Polygon',
    //       image: 'assets/images/shoe1.png',
    //       quantity: 2,
    //       price: 64.99,
    //       size: 40,
    //       color: Color(0xFF836DB8)),
    // ];

    final user = Provider.of<Users>(context);

    if (user == null) {
      return Center(
        child: Container(
            width: 250,
            height: 50,
            child: RaisedButton(
              onPressed: () {
                Get.to(Login());
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
                  constraints: BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                  alignment: Alignment.center,
                  child: Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            )),
      );
    } else {
      Query<Map<String, dynamic>> order;
      if(widget.status==3)
        order = FirebaseFirestore.instance.collection('order').where('status',whereIn: [3, 4]).where('userId', isEqualTo: user.uid).orderBy('orderDate', descending: true);

      else
        order = FirebaseFirestore.instance.collection('order').where('status', isEqualTo: widget.status).where('userId', isEqualTo: user.uid).orderBy('orderDate', descending: true);
      return StreamBuilder<QuerySnapshot>(
          stream: order.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            var dataList = snapshot.data?.docs.map((e) => e.data()).toList();


            List<Order> orders = [];
            dataList?.forEach((element) {
              final Map<String, dynamic> doc = element as Map<String, dynamic>;
              Order o = Order(
                  id: doc["id"],
                  userId: doc["userId"],
                  name: doc["name"],
                  orderDate: doc["orderDate"].toDate(),
                  phone: doc["phone"],
                  payment: doc["payment"],
                  total: doc["total"],
                  address: doc["address"],
                  status: doc["status"],
                  voucherId: doc["voucherId"],
                  voucherValue: doc["voucherValue"]);

              orders.add(o);
            });

            if (orders.isEmpty) {
              return Container();
            } else {
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(10)),
                child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Card(
                      color: Color(0xEDF3F3F3),
                      child: InkWell(
                        onTap: () {
                          Get.to(OrderDetail(
                            order: orders[index],
                          ));
                        },
                        child: Padding(
                          padding: EdgeInsets.all(
                            getProportionateScreenWidth(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        orders[index].name,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.black87),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "Ng??y ?????t: ${orders[index].orderDate.toString().substring(0, orders[index].orderDate.toString().lastIndexOf(":"))}",
                                        style: TextStyle(color: Colors.black87),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                              StreamBuilder(
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
                                          price: doc["price"].toDouble(),
                                          image: doc["image"],
                                          color: doc["color"],
                                          size: doc["size"],
                                          quantity: doc["quantity"],
                                          comment: doc['comment']
                                      );

                                      lstOrderItems.add(item);
                                    });

                                    items = lstOrderItems
                                        .where((element) => element.orderId == orders[index].id)

                                        .toList();
                                    return Column(
                                      children: [
                                        Container(
                                          color: Colors.white,
                                          child: Padding(padding: EdgeInsets.only(
                                              top: 10, bottom: 10, left: 3, right: 3),
                                            child: Row(
                                              children: [
                                                Container(
                                                    width: (MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width - 220) / 2,
                                                    height: 60,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius: BorderRadius
                                                            .circular(10),
                                                        boxShadow: [BoxShadow(
                                                            spreadRadius: 1,
                                                            blurRadius: 0.5,
                                                            color: Colors.orange
                                                        )
                                                        ],
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                                '${items[0].image}'),
                                                            fit: BoxFit.cover))
                                                ),
                                                SizedBox(width: 25,),
                                                Expanded(child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text('${items[0].productName}',
                                                      style: TextStyle(fontSize: 16,
                                                          fontWeight: FontWeight.w600),
                                                    ),
                                                    SizedBox(width: 15),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Text("${NumberFormat.currency(
                                                            locale: 'vi').format(
                                                            items[0].price)}",
                                                          style: TextStyle(fontSize: 15,
                                                              fontWeight: FontWeight
                                                                  .w500,
                                                              color: Colors.red),
                                                        ),
                                                        Container(

                                                          child: DecoratedBox(
                                                            decoration: BoxDecoration(
                                                              color:Color(int.parse(items[0].color)) ,
                                                              shape: BoxShape.circle,
                                                            ),
                                                          ),

                                                          width: 20,
                                                          height: 20,

                                                        ),
                                                        Text('${items[0].size}'),
                                                        Text("x${items[0].quantity}",
                                                          style: TextStyle(fontSize: 15,
                                                              fontWeight: FontWeight
                                                                  .w500),
                                                        ),
                                                      ],
                                                    )

                                                  ],
                                                )),

                                              ],
                                            ),

                                          ),

                                        ),
                                        if(items.length>1)
                                          Container(
                                            color: Colors.white,
                                            alignment: Alignment.center,
                                            child: Text('Xem th??m ${items.length-1} s???n ph???m',textAlign: TextAlign.center,),
                                          ),
                                      ],

                                    );
                                  }
                              ),



                              Divider(
                                thickness: 2,
                              ),

                              IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        const Text(
                                          "M?? ????n",
                                          style: TextStyle(
                                              color: Colors.grey),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          orders[index].id.toString()
                                              .padLeft(6, '0'),
                                          style: const TextStyle(
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                    const VerticalDivider(
                                      thickness: 1,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        const Text(
                                          "T???ng ti???n",
                                          style: TextStyle(
                                              color: Colors.grey),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                         '${NumberFormat.currency(locale: 'vi').format(orders[index].total-orders[index].voucherValue)}',
                                          style: const TextStyle(
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                    const VerticalDivider(
                                      thickness: 1,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        const Text(
                                          "Thanh to??n",
                                          style: TextStyle(
                                              color: Colors.grey),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          orders[index].payment,
                                          style: const TextStyle(
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              if(orders[index].status==0)
                                Padding(padding: EdgeInsets.only(top:10,right: 10,left: 10),
                                    child: FlatButton(onPressed: (){
                                      showDialog(context: context, builder: (BuildContext context)=>
                                          AlertDialog(

                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: const <Widget>[

                                                  Text('X??c nh???n h???y ????n h??ng?'),
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(context, 'Cancel'),
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () async{
                                                  final DocumentSnapshot data = snapshot.data!.docs[index];

                                                  FirebaseFirestore.instance
                                                      .collection('order')
                                                      .doc(data.id).update({'status':-1});
                                                  Navigator.pop(context, 'OK');
                                                },
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          )
                                      );


                                    },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.deepOrangeAccent,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        height: 40,

                                        child: Center(
                                          child: Text('Hu??? ????n h??ng',style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600
                                          ),),
                                        ),
                                      ),
                                    )
                                ),
                              if(orders[index].status==3)
                                Padding(padding: EdgeInsets.only(top:10,right: 10,left: 10),
                                    child: FlatButton(onPressed: () {

                                      final DocumentSnapshot data = snapshot.data!.docs[index];

                                      FirebaseFirestore.instance
                                          .collection('order')
                                          .doc(data.id).update({'status':4});

                                      FirebaseFirestore.instance.collection('ranking').where('userId', isEqualTo: user.uid).get().then((value) {
                                        if(orders[index].total>=500000&&orders[index].total<1000000)
                                          value.docs[0].reference.update({'score':value.docs[0].get('score')+10 });
                                        else if(orders[index].total>=1000000&&orders[index].total<2000000)
                                          value.docs[0].reference.update({'score':value.docs[0].get('score')+20 });
                                        else if(orders[index].total>=2000000)
                                          value.docs[0].reference.update({'score':value.docs[0].get('score')+30 });

                                      });

                                      FirebaseFirestore.instance.collection('rankingDetail').where('userId', isEqualTo: user.uid).get().then((value) {
                                        value.docs[0].reference.update({'totalPrice':value.docs[0].get('totalPrice')+orders[index].total });
                                        value.docs[0].reference.update({'numOfOrder':value.docs[0].get('numOfOrder')+1 });
                                      });

                                    },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.deepOrangeAccent,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        height: 40,

                                        child: Center(
                                          child: Text('???? nh???n ???????c h??ng',style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600
                                          ),),
                                        ),
                                      ),
                                    )
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          });
    }
  }
}