import 'package:final_project_mobile/models/Cart.dart';
import 'package:final_project_mobile/models/address.dart';
import 'package:final_project_mobile/models/voucher.dart';
import 'package:final_project_mobile/screens/address/address_screen.dart';
import 'package:final_project_mobile/screens/voucher/voucher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/Product.dart';
import "package:intl/intl.dart";

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Address address=Address(id: 1, name: 'Nguyễn Thị Bích Phương', phone: '09886435482', address: 'Thủ Đức,TPHCM');
  Voucher voucher= Voucher();
  @override
  Widget build(BuildContext context) {
    List<Cart> items = [
      Cart(product: demoProducts[0], numOfItem: 2,size: 37,color: Color(0xFFF6625E)),
      Cart(product: demoProducts[1], numOfItem: 1,size: 39,color: Color(0xFFF6625E)),
      Cart(product: demoProducts[3], numOfItem: 1,size: 38,color: Color(0xFFDECB9C)),
    ];


    return ListView(
      children: [
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
              trailing: IconButton(
                onPressed: () async {

                 Address _address = await Get.to(AddressScreen());
                 if(_address!=null){
                   setState(() {
                     address=_address;

                   });
                 }


                    print(address.name);
                },
                icon: Icon(Icons.edit),
                hoverColor: Colors.white,
                highlightColor: Colors.white,
                splashColor: Colors.white,
                color: Colors.black,
              ),
               subtitle: Text('${address.name} \n${address.phone} \n${address.address}'),
            //
            ),


          ),
        ),

        Column(
            children:
            List.generate(3, (index) {
              return Padding(padding: EdgeInsets.only(top: 10,right: 25,left: 25,bottom: 10),
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
                            image: DecorationImage(image: AssetImage('${items[index].product.images[0]}'),
                                fit:BoxFit.cover))
                    ),
                    SizedBox(width: 25,),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${items[index].product.title}',
                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                        ),
                        SizedBox(width: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${NumberFormat.currency(locale: 'vi').format(items[index].product.price)}",
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
                            Text("x${items[index].numOfItem}",
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
        Padding(padding: EdgeInsets.only(bottom: 25),

            child: ListTile(
              onTap: () async {
                Voucher _voucher=await Get.to(VoucherScreen());
                if(_voucher!=null){
                  setState(() {
                    voucher=_voucher;

                  });
                }

              },
                title: Text('Mã giảm giá'),

                trailing:  voucher.voucherName==null ? Text('Chọn mã giảm giá',) :Text('${voucher.voucherName}',style: TextStyle(color: Colors.red,fontSize: 15))

            )



        ),
        Padding(padding: EdgeInsets.only(top: 20,right: 25,left: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tổng', style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black.withOpacity(0.5)),),
              Text('${NumberFormat.currency(locale: 'vi').format(500000)}', style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black),),

            ],

          ),
        ),
        Padding(padding: EdgeInsets.only(right: 25,left: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Vận chuyển', style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,color: Colors.black.withOpacity(0.5)),),
              Text('${NumberFormat.currency(locale: 'vi').format(30000)}', style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,color: Colors.black),),

            ],

          ),
        ),
        if(voucher.voucherId!=null)
          Padding(padding: EdgeInsets.only(right: 25,left: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Giảm giá', style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,color: Colors.black.withOpacity(0.5)),),
                Text('-${NumberFormat.currency(locale: 'vi').format(voucher.voucherValue)}', style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,color: Colors.red),)
              ],

            ),
          ),
        Padding(padding: EdgeInsets.only(right: 25,left: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Thanh toán', style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black.withOpacity(0.5)),),
              Text('${NumberFormat.currency(locale: 'vi').format(530000)}', style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.red),),

            ],

          ),
        ),

        Padding(padding: EdgeInsets.only(bottom: 25),

            child: ListTile(
                title: Text('Payment'),

                trailing:  Text('Thanh toán khi nhận hàng')

            )



        ),



        SizedBox(height: 50),
      ],
    );
  }
}


