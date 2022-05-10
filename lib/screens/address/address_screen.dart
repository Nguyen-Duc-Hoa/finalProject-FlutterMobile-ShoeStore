import 'package:final_project_mobile/constants.dart';
import 'package:final_project_mobile/models/address.dart';
import 'package:final_project_mobile/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';

class AddressScreen extends StatelessWidget {
  static String routeName = "/address";
  const AddressScreen({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
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
if(user!= null) {
  Query<Map<String, dynamic>> address = FirebaseFirestore.instance.collection(
      'address').where('userId', isEqualTo: user.uid);
  return Scaffold(
    appBar: AppBar(
      backgroundColor: kPrimaryColor,
      title: Text('Địa chỉ nhận hàng'),
    ),
    backgroundColor: Colors.white,
    body:
    user!=null?
    StreamBuilder(
      stream: address.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        var dataList = snapshot.data?.docs.map((e) => e.data()).toList();


        List<Address> items = [];
        dataList?.forEach((element) {
          final Map<String, dynamic> doc = element as Map<String, dynamic>;
          Address o = Address(
            userId: doc["userId"],
            name: doc["name"],
            phone: doc["phone"],
            address: doc["address"],
            isDefault: doc["isDefault"],
          );

          items.add(o);
        });
        return ListView(
          children: [

            Column(
                children:
                List.generate(items.length, (index) {
                  bool? val=items[index].isDefault;
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
                          value: true,
                          groupValue: val,
                          onChanged: (bool? value) async{
                            await FirebaseFirestore.instance.collection('address').get().then((value) {
                              for(var val in value.docs)
                              {
                                val.reference.update({'isDefault':false});
                              }
                            });


                            final DocumentSnapshot data = snapshot.data!.docs[index];

                            FirebaseFirestore.instance
                                .collection('address')
                                .doc(data.id).update({'isDefault':true});


                            val=value;


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
        );
      },
    ):Container(),

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
else{
  return Scaffold(
    appBar: AppBar(
      backgroundColor: kPrimaryColor,
      title: Text('Địa chỉ nhận hàng'),
    ),
    backgroundColor: Colors.white,
    body:
    Container(),

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
}


// class AddressScreen extends StatefulWidget {
//   static String routeName = "/address";
//   const AddressScreen({Key? key}) : super(key: key);
//
//   @override
//   _AddressScreenState createState() => _AddressScreenState();
// }
//
// class _AddressScreenState extends State<AddressScreen> {
//   _showDialogAdd() async {
//     await showDialog<String>(
//         context: context,
//
//         builder:(context){
//           return AlertDialog(
//             contentPadding: const EdgeInsets.all(16.0),
//             title: Text('Thêm địa chỉ mới',style: TextStyle(color: kPrimaryColor,fontSize: 18)),
//             content:
//              SingleChildScrollView(
//                child: Column(
//
//                  children: [
//
//                    TextFormField(
//                      autofocus: true,
//                      initialValue: null,
//                      decoration: new InputDecoration(
//                          labelText: 'Name'),
//                    ),
//                    TextFormField(
//                      autofocus: true,
//                      initialValue: null,
//                      decoration: new InputDecoration(
//                          labelText: 'Phone'),
//                    ),
//                    TextFormField(
//                      autofocus: true,
//                      initialValue: null,
//                      decoration: new InputDecoration(
//                          labelText: 'Address'),
//                    ),
//
//                  ],
//
//                ),
//              ),
//             actions: <Widget>[
//               new FlatButton(
//                   child: const Text('Cancel',style: TextStyle(color: Colors.red)),
//
//                   onPressed: () {
//                     Navigator.pop(context);
//                   }),
//               new FlatButton(
//                   child: const Text('Save',style: TextStyle(color: Colors.blue)),
//                   onPressed: () {
//
//                   })
//             ],
//           );
//         });
//
//
//   }
//   _showDialogEdit(value) async {
//     await showDialog<String>(
//         context: context,
//
//         builder:(context){
//           return AlertDialog(
//             contentPadding: const EdgeInsets.all(16.0),
//             title: Text('Sửa địa chỉ',style: TextStyle(color: kPrimaryColor,fontSize: 18),),
//             content:
//             SingleChildScrollView(
//               child: Column(
//
//                 children: [
//
//                   TextFormField(
//                     autofocus: true,
//                     initialValue: value.name,
//                     decoration: new InputDecoration(
//                         labelText: 'Name'),
//                   ),
//                   TextFormField(
//                     autofocus: true,
//                     initialValue: value.phone,
//                     decoration: new InputDecoration(
//                         labelText: 'Phone'),
//                   ),
//                   TextFormField(
//                     autofocus: true,
//                     initialValue: value.address,
//                     decoration: new InputDecoration(
//                         labelText: 'Address'),
//                   ),
//
//                 ],
//
//               ),
//             ),
//             actions: <Widget>[
//               new FlatButton(
//                   child: const Text('Cancel',style: TextStyle(color: Colors.red)),
//
//                   onPressed: () {
//                     Navigator.pop(context);
//                   }),
//               new FlatButton(
//                   child: const Text('Save',style: TextStyle(color: Colors.blue)),
//                   onPressed: () {
//
//                   })
//             ],
//           );
//         });
//
//
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<Users>(context);
//     FirebaseFirestore firestore = FirebaseFirestore.instance;
//     Query<Map<String, dynamic>> address = FirebaseFirestore.instance.collection('address').where('userId',isEqualTo:user.uid );
//     // List<Address> items = [
//     //   Address(userId: 1, name: 'Nguyễn Thị Bích Phương',phone: '0984736927',address: 'Thủ Đức,TPHCM',isDefault: true),
//     //   Address(userId: 2, name: 'Nguyễn Đức Hòa',phone: '0983273682',address: 'Thủ Đức,TPHCM',isDefault: false),
//     // ];
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: kPrimaryColor,
//         title: Text('Địa chỉ nhận hàng'),
//       ),
//       backgroundColor: Colors.white,
//       body:StreamBuilder(
//         stream: address.snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
//           if (snapshot.hasError) {
//             return Text('Something went wrong');
//           }
//
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Text("Loading");
//           }
//
//           var dataList = snapshot.data?.docs.map((e) => e.data()).toList();
//
//
//           List<Address> items = [];
//           dataList?.forEach((element) {
//             final Map<String, dynamic> doc = element as Map<String, dynamic>;
//             Address o = Address(
//                 userId: doc["userId"],
//                 name: doc["name"],
//                 phone: doc["phone"],
//                 address: doc["address"],
//                 isDefault: doc["isDefault"],
//                );
//
//             items.add(o);
//           });
//           return ListView(
//             children: [
//
//               Column(
//                   children:
//                   List.generate(items.length, (index) {
//                     bool? val=items[index].isDefault;
//                     return  Container(
//                       decoration: BoxDecoration(
//
//                           border: Border.all(
//                               color: Colors.black12
//                           ),
//                           borderRadius: BorderRadius.circular(10)
//                       ),
//                       child:  Padding(padding: EdgeInsets.only(top: 20,bottom: 25),
//
//                         child: ListTile(
//
//                           leading: Radio(
//                             value: true,
//                             groupValue: val,
//                             onChanged: (bool? value){
//                               setState(() {
//                                 val=value;
//
//                                 print(val);
//                               });
//                             },
//                             activeColor: kPrimaryColor,
//                           ),
//                           trailing: IconButton(
//                             onPressed: (){
//                               _showDialogEdit(items[index]);
//                             },
//                             icon: Icon(Icons.edit),
//                             hoverColor: Colors.white,
//                             highlightColor: Colors.white,
//                             splashColor: Colors.white,
//                             color: Colors.black,
//                           ),
//                           title: Text('${items[index].name} \n${items[index].phone} \n${items[index].address}'),
//                           onTap: ()=>Get.back(result: items[index]),
//                         ),
//
//
//                       ),
//                     );
//
//                   }
//
//                   )
//
//               ),
//
//             ],
//           );
//         },
//       ),
//
//
//       floatingActionButton: FloatingActionButton(
//         onPressed: (){
//           _showDialogAdd();
//         },
//         backgroundColor: kPrimaryColor,
//         tooltip: 'Add address',
//         child: const Icon(Icons.add),
//       ),
//     )
//     ;
//   }
// }


