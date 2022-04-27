import 'package:final_project_mobile/models/address.dart';
import 'package:final_project_mobile/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressScreen extends StatelessWidget {
  static String routeName = "/address";
  const AddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Address> items = [
      Address(id: 1, name: 'Nguyễn Thị Bích Phương',phone: '0984736927',address: 'Thủ Đức,TPHCM'),
      Address(id: 2, name: 'Nguyễn Đức Hòa',phone: '0983273682',address: 'Thủ Đức,TPHCM'),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text('Địa chỉ nhận hàng'),
      ),
      backgroundColor: Colors.white,
      body:  ListView(
        children: [

          Column(
              children:
              List.generate(2, (index) {
                return  Container(
                  decoration: BoxDecoration(

                      border: Border.all(
                          color: Colors.black12
                      ),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child:  Padding(padding: EdgeInsets.only(top: 20,bottom: 25),

                    child: ListTile(

                      leading: Icon(Icons.location_on_outlined,color: Colors.red),
                      trailing: IconButton(
                        onPressed: (){

                        },
                        icon: Icon(Icons.edit),
                        hoverColor: Colors.white,
                        highlightColor: Colors.white,
                        splashColor: Colors.white,
                        color: Colors.black,
                      ),
                      title: Text('${items[index].name} \n${items[index].phone} \n${items[index].address}'),
                      onTap: ()=>Get.back(result: items[index]),
                    ),


                  ),
                );

              }

              )

          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Add address',
        child: const Icon(Icons.add),
      ),
    )
     ;
  }
}
