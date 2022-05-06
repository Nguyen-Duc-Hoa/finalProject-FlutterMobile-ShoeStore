import 'package:final_project_mobile/constants.dart';
import 'package:final_project_mobile/models/address.dart';
import 'package:final_project_mobile/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressScreen extends StatefulWidget {
  static String routeName = "/address";
  const AddressScreen({Key? key}) : super(key: key);

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  _showDialogAdd() async {
    await showDialog<String>(
        context: context,

        builder:(context){
          return AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            title: Text('Thêm địa chỉ mới',style: TextStyle(color: kPrimaryColor,fontSize: 18)),
            content:
             SingleChildScrollView(
               child: Column(

                 children: [

                   TextFormField(
                     autofocus: true,
                     initialValue: null,
                     decoration: new InputDecoration(
                         labelText: 'Name'),
                   ),
                   TextFormField(
                     autofocus: true,
                     initialValue: null,
                     decoration: new InputDecoration(
                         labelText: 'Phone'),
                   ),
                   TextFormField(
                     autofocus: true,
                     initialValue: null,
                     decoration: new InputDecoration(
                         labelText: 'Address'),
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
                  onPressed: () {

                  })
            ],
          );
        });


  }
  _showDialogEdit(value) async {
    await showDialog<String>(
        context: context,

        builder:(context){
          return AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            title: Text('Sửa địa chỉ',style: TextStyle(color: kPrimaryColor,fontSize: 18),),
            content:
            SingleChildScrollView(
              child: Column(

                children: [

                  TextFormField(
                    autofocus: true,
                    initialValue: value.name,
                    decoration: new InputDecoration(
                        labelText: 'Name'),
                  ),
                  TextFormField(
                    autofocus: true,
                    initialValue: value.phone,
                    decoration: new InputDecoration(
                        labelText: 'Phone'),
                  ),
                  TextFormField(
                    autofocus: true,
                    initialValue: value.address,
                    decoration: new InputDecoration(
                        labelText: 'Address'),
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
                  onPressed: () {

                  })
            ],
          );
        });


  }
 int val=0;
  @override
  Widget build(BuildContext context) {
    List<Address> items = [
      Address(id: 1, name: 'Nguyễn Thị Bích Phương',phone: '0984736927',address: 'Thủ Đức,TPHCM'),
      Address(id: 2, name: 'Nguyễn Đức Hòa',phone: '0983273682',address: 'Thủ Đức,TPHCM'),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
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

                      leading: Radio(
                        value: index,
                        groupValue: val,
                        onChanged: (value){
                          setState(() {
                            val=int.parse(value.toString());
                            print(val);
                          });
                        },
                        activeColor: kPrimaryColor,
                      ),
                      trailing: IconButton(
                        onPressed: (){
                          _showDialogEdit(items[index]);
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
        onPressed: (){
          _showDialogAdd();
        },
        backgroundColor: kPrimaryColor,
        tooltip: 'Add address',
        child: const Icon(Icons.add),
      ),
    )
    ;
  }
}


