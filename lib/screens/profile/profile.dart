import 'package:finalprojectmobile/common.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common.dart';
import '../../constants.dart';
import '../../models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../services/auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../sign_in/login_screen.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Profile extends StatefulWidget {
  static String routeName = "/profile";
 Profile({Key? key}) : super(key: key);
  File imageFile=new File('');
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {

    final AuthService auth=AuthService();
    final _formKeyEdit=GlobalKey<FormState>();
    final _formKeyChangePass=GlobalKey<FormState>();
    final users = Provider.of<Users>(context);
    String oldpassword='';
    String newpassword='';
    String error='';
    String url='';
    _getFromGallery(snapshot) async {
      PickedFile? pickedFile = await ImagePicker().getImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (pickedFile != null) {

          widget.imageFile = File(pickedFile.path);

        final fileName = basename(widget.imageFile.path);
          try{

            Reference storageReference = FirebaseStorage.instance.ref().child("/$fileName");
            final UploadTask uploadTask = storageReference.putFile(widget.imageFile);
            final TaskSnapshot downloadUrl = (await uploadTask);

            url = await downloadUrl.ref.getDownloadURL();
            final FirebaseAuth _auth =FirebaseAuth.instance;
            User? user  = _auth.currentUser;

            await user?.updatePhotoURL(url).then((value) {

            }).catchError((error) {

              print(error);

            });
            final DocumentSnapshot data = snapshot.data!.docs[0];
            FirebaseFirestore.instance
                .collection('user')
                .doc(data.id).update({
              'avatar':url,
            });
          }
          catch(e)
          {
            print(e);
          }

      }

    }
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

    _showDialog(title, value,type,snapshot) async {
      String change=value;

      await showDialog<String>(
          context: context,

          builder: (context) {
            return Form(
              key:  _formKeyEdit,
              child: AlertDialog(
                contentPadding: const EdgeInsets.all(16.0),
                content: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: TextFormField(
                        autofocus: true,
                        initialValue: value,

                        validator: (value){
                          if(type=='name')
                          {
                            if(value!.isEmpty)
                              return 'Please enter your name';
                            else return null;
                          }
                          else if(type=='phone')
                          {
                            Common().validateMobile(value!);
                          }
                          else if(type=='email')
                          {
                            if(value!.isEmpty)
                              return 'Please enter your email';
                            else {
                              if(Common().validateEmail(value))
                                return null;
                              else
                                return 'Email invalid';

                            }

                          }
                        },

                        onChanged: (_value){

                          change=_value.toString().trim();

                        },
                        decoration: new InputDecoration(
                            labelText: '${title}'),
                      ),
                    )
                  ],
                ),
                actions: <Widget>[
                  new FlatButton(
                      child: const Text(
                          'Cancel', style: TextStyle(color: Colors.red)),

                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  // ignore: deprecated_member_use
                  new FlatButton(
                      child: const Text(
                          'Save', style: TextStyle(color: Colors.blue)),
                      onPressed: () async{
                        if(_formKeyEdit.currentState!.validate()){
                          if(type=='name')
                          {
                            final DocumentSnapshot data = snapshot.data!.docs[0];
                            FirebaseFirestore.instance
                                .collection('user')
                                .doc(data.id).update({
                              'name':change,
                            });

                            Navigator.pop(context);
                          }
                          else if(type=='phone'){
                            final DocumentSnapshot data = snapshot.data!.docs[0];
                            FirebaseFirestore.instance
                                .collection('user')
                                .doc(data.id).update({
                              'phone':change,
                            });

                            Navigator.pop(context);
                          }
                          else if(type=='email')
                          {



                            final FirebaseAuth _auth =FirebaseAuth.instance;
                            User? user  = _auth.currentUser;


                            await user?.updateEmail(change).then((value) {
                              final DocumentSnapshot data = snapshot.data!.docs[0];
                              FirebaseFirestore.instance
                                  .collection('user')
                                  .doc(data.id).update({
                                'email':change,
                              });

                              Navigator.pop(context);
                            }).catchError((error) {

                              if (error.code == 'email-already-in-use')
                                showToastMessage("Email đã tồn tại");
                              else if(error.code=='requires-recent-login')
                                Get.offNamed('/login');

                            });

                          }
                        }

                      })
                ],
              ),
            );
          });
    }
    _changePassword() async {
      await showDialog<String>(
          context: context,

          builder: (context) {
            return Form(
              key: _formKeyChangePass,
              child: AlertDialog(
                title: Text('Đổi mật khẩu',
                  style: TextStyle(color: kPrimaryColor, fontSize: 18),),
                contentPadding: const EdgeInsets.all(16.0),
                content:
                SingleChildScrollView(
                  child: Column(
                    children: [

                      TextFormField(
                        obscureText: true,
                        autofocus: true,
                        initialValue: null,
                        validator: (value) {
                          value!.isEmpty?"Please enter current password":null;
                        },
                        onChanged: (_value){

                          oldpassword=_value.toString().trim();

                        },
                        decoration: new InputDecoration(
                            labelText: 'Current Password'),
                      ),

                      TextFormField(
                        obscureText: true,
                        autofocus: true,
                        initialValue: null,
                        validator: (value) {
                          if(value!.isEmpty)
                            return 'Please enter new password';
                          else {
                            if(Common().validatePassword(value))
                              return null;
                            else
                              return 'Weak password';

                          }
                        },
                        onChanged: (_value){

                          newpassword=_value.toString().trim();

                        },
                        decoration: new InputDecoration(
                            labelText: 'New Password'),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  new FlatButton(
                      child: const Text(
                          'Cancel', style: TextStyle(color: Colors.red)),

                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  new FlatButton(
                      child: const Text(
                          'Save', style: TextStyle(color: Colors.blue)),
                      onPressed: () async{

                        if(_formKeyChangePass.currentState!.validate())
                        {

                          final FirebaseAuth _auth =FirebaseAuth.instance;
                          User user = _auth.currentUser!;

                          var credential = EmailAuthProvider.credential(
                              email:user.email??'',
                              password: oldpassword.trim()
                          );

                          await user.reauthenticateWithCredential(credential).then((value) {
                            error='';

                          }).catchError((errors) {

                            print(errors.code);
                            error='Incorrect Password';
                            if(error!='')
                            {
                              showToastMessage('Incorrect current password');
                            }
                          });
                          if(error=='')
                          {
                            final FirebaseAuth _auth =FirebaseAuth.instance;
                            User? user  = _auth.currentUser;


                            await user?.updatePassword(newpassword).then((value) {
                              showToastMessage('Success');
                              Navigator.pop(context);
                            }).catchError((error) {

                              print(error);

                            });

                          }
                        }
                      })
                ],
              ),
            );
          });
    }
    if (users != null) {
      Query<Map<String, dynamic>> u = FirebaseFirestore.instance.collection(
          'user').where('uid', isEqualTo: users.uid);


      return Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            title: Text('Thông tin người dùng'),
          ),
          body: StreamBuilder(
              stream: u.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }
                dynamic data = snapshot.data?.docs.map((e) => e.data()).toList().first;
                Users user = Users();
                user = Users(
                  uid: data["uid"],
                  name: data["name"],
                  phone:data["phone"],
                  email: data["email"],
                  avatar: data["avatar"],

                );
                return Container(
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Container(
                        height: 115,
                        width: 115,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage("${user.avatar.toString()}"),
                              //backgroundImage:  AssetImage("assets/images/user.png")
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                onPressed: () {
                                  _getFromGallery(snapshot);
                                },
                                icon: Icon(Icons.edit),
                                hoverColor: Colors.white,
                                highlightColor: Colors.white,
                                splashColor: Colors.white,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: ListView(

                          children: [
                            Container(
                              margin: EdgeInsets.all(5),

                              child: ListTile(
                                  title: Text('Full Name'),
                                  leading: Icon(Icons.account_circle_outlined,
                                    color: Colors.black,),
                                  trailing: IconButton(
                                    onPressed: () {
                                      _showDialog('Full Name', user.name,'name',snapshot);
                                    },
                                    icon: Icon(Icons.edit),
                                    hoverColor: Colors.white,
                                    highlightColor: Colors.white,
                                    splashColor: Colors.white,
                                    color: Colors.black,
                                  ),
                                  subtitle: Text('${user.name}')

                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(5),

                              child: ListTile(
                                  title: Text('Email'),
                                  leading: Icon(
                                    Icons.email_outlined, color: Colors.black,),
                                  trailing: IconButton(
                                    onPressed: () {
                                      _showDialog('Email', user.email,'email',snapshot);
                                    },
                                    icon: Icon(Icons.edit),
                                    hoverColor: Colors.white,
                                    highlightColor: Colors.white,
                                    splashColor: Colors.white,
                                    color: Colors.black,
                                  ),
                                  subtitle: Text('${user.email}')

                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(5),

                              child: ListTile(
                                  title: Text('Phone'),
                                  leading: Icon(
                                    Icons.phone, color: Colors.black,),
                                  trailing: IconButton(
                                    onPressed: () {
                                      _showDialog('Phone', user.phone,'phone',snapshot);
                                    },
                                    icon: Icon(Icons.edit),
                                    hoverColor: Colors.white,
                                    highlightColor: Colors.white,
                                    splashColor: Colors.white,
                                    color: Colors.black,
                                  ),
                                  subtitle: Text('${user.phone}')

                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(5),

                              child: ListTile(
                                title: Text('Đổi mật khẩu'),
                                leading: Icon(
                                  Icons.lock_outline, color: Colors.black,),
                                onTap: () {
                                  _changePassword();
                                },


                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }

          )


      );
    }
    else {
      return Container();
    }
  }
}



// class Profile extends StatelessWidget {
//   static String routeName = "/profile";
//
//    Profile({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final AuthService auth=AuthService();
//     final _formKeyEdit=GlobalKey<FormState>();
//     final _formKeyChangePass=GlobalKey<FormState>();
//     final users = Provider.of<Users>(context);
//     String oldpassword='';
//     String newpassword='';
//     String error='';
//     File imageFile;
//     bool checkCurrent=true;
//     _getFromGallery() async {
//       PickedFile? pickedFile = await ImagePicker().getImage(
//         source: ImageSource.gallery,
//         maxWidth: 1800,
//         maxHeight: 1800,
//       );
//       if (pickedFile != null) {
//         setState(() {
//           imageFile = File(pickedFile.path);
//         });
//       }
//     }
//     void showToastMessage(String message){
//       Fluttertoast.showToast(
//           msg: message, //message to show toast
//           toastLength: Toast.LENGTH_LONG, //duration for message to show
//           gravity: ToastGravity.BOTTOM, //where you want to show, top, bottom
//           backgroundColor: Colors.black87, //background Color for message
//           textColor: Colors.white, //message text color
//           fontSize: 16.0 //message font size
//       );
//     }
//
//     _showDialog(title, value,type,snapshot) async {
//       String change=value;
//
//       await showDialog<String>(
//           context: context,
//
//           builder: (context) {
//             return Form(
//               key:  _formKeyEdit,
//               child: AlertDialog(
//                 contentPadding: const EdgeInsets.all(16.0),
//                 content: new Row(
//                   children: <Widget>[
//                     new Expanded(
//                       child: TextFormField(
//                         autofocus: true,
//                         initialValue: value,
//
//                         validator: (value){
//                           if(type=='name')
//                             {
//                               if(value!.isEmpty)
//                                 return 'Please enter your name';
//                               else return null;
//                             }
//                           else if(type=='phone')
//                             {
//                              Common().validateMobile(value!);
//                             }
//                           else if(type=='email')
//                             {
//                               if(value!.isEmpty)
//                                 return 'Please enter your email';
//                               else {
//                                 if(Common().validateEmail(value))
//                                   return null;
//                                 else
//                                   return 'Email invalid';
//
//                               }
//
//                             }
//                         },
//
//                         onChanged: (_value){
//
//                             change=_value.toString().trim();
//
//                         },
//                         decoration: new InputDecoration(
//                             labelText: '${title}'),
//                       ),
//                     )
//                   ],
//                 ),
//                 actions: <Widget>[
//                   new FlatButton(
//                       child: const Text(
//                           'Cancel', style: TextStyle(color: Colors.red)),
//
//                       onPressed: () {
//                         Navigator.pop(context);
//                       }),
//                   // ignore: deprecated_member_use
//                   new FlatButton(
//                       child: const Text(
//                           'Save', style: TextStyle(color: Colors.blue)),
//                       onPressed: () async{
//                         if(_formKeyEdit.currentState!.validate()){
//                           if(type=='name')
//                           {
//                             final DocumentSnapshot data = snapshot.data!.docs[0];
//                             FirebaseFirestore.instance
//                                 .collection('user')
//                                 .doc(data.id).update({
//                               'name':change,
//                             });
//
//                             Navigator.pop(context);
//                           }
//                           else if(type=='phone'){
//                             final DocumentSnapshot data = snapshot.data!.docs[0];
//                             FirebaseFirestore.instance
//                                 .collection('user')
//                                 .doc(data.id).update({
//                               'phone':change,
//                             });
//
//                             Navigator.pop(context);
//                           }
//                           else if(type=='email')
//                           {
//
//
//
//                             final FirebaseAuth _auth =FirebaseAuth.instance;
//                             User? user  = _auth.currentUser;
//
//
//                             await user?.updateEmail(change).then((value) {
//                               final DocumentSnapshot data = snapshot.data!.docs[0];
//                               FirebaseFirestore.instance
//                                   .collection('user')
//                                   .doc(data.id).update({
//                                 'email':change,
//                               });
//
//                               Navigator.pop(context);
//                             }).catchError((error) {
//
//                               if (error.code == 'email-already-in-use')
//                                 showToastMessage("Email đã tồn tại");
//                               else if(error.code=='requires-recent-login')
//                                 Get.offNamed('/login');
//
//                             });
//
//                           }
//                         }
//
//                       })
//                 ],
//               ),
//             );
//           });
//     }
//     _changePassword() async {
//       await showDialog<String>(
//           context: context,
//
//           builder: (context) {
//             return Form(
//               key: _formKeyChangePass,
//               child: AlertDialog(
//                 title: Text('Đổi mật khẩu',
//                   style: TextStyle(color: kPrimaryColor, fontSize: 18),),
//                 contentPadding: const EdgeInsets.all(16.0),
//                 content:
//                 SingleChildScrollView(
//                   child: Column(
//                     children: [
//
//                       TextFormField(
//                         obscureText: true,
//                         autofocus: true,
//                         initialValue: null,
//                       validator: (value) {
//                         value!.isEmpty?"Please enter current password":null;
//                       },
//                       onChanged: (_value){
//
//                         oldpassword=_value.toString().trim();
//
//                       },
//                         decoration: new InputDecoration(
//                             labelText: 'Current Password'),
//                       ),
//
//                       TextFormField(
//                         obscureText: true,
//                         autofocus: true,
//                         initialValue: null,
//                         validator: (value) {
//                           if(value!.isEmpty)
//                             return 'Please enter new password';
//                           else {
//                             if(Common().validatePassword(value))
//                               return null;
//                             else
//                               return 'Weak password';
//
//                           }
//                         },
//                         onChanged: (_value){
//
//                           newpassword=_value.toString().trim();
//
//                         },
//                         decoration: new InputDecoration(
//                             labelText: 'New Password'),
//                       ),
//                     ],
//                   ),
//                 ),
//                 actions: <Widget>[
//                   new FlatButton(
//                       child: const Text(
//                           'Cancel', style: TextStyle(color: Colors.red)),
//
//                       onPressed: () {
//                         Navigator.pop(context);
//                       }),
//                   new FlatButton(
//                       child: const Text(
//                           'Save', style: TextStyle(color: Colors.blue)),
//                       onPressed: () async{
//
//                         if(_formKeyChangePass.currentState!.validate())
//                           {
//
//                             final FirebaseAuth _auth =FirebaseAuth.instance;
//                             User user = _auth.currentUser!;
//
//                             var credential = EmailAuthProvider.credential(
//                                 email:user.email??'',
//                                 password: oldpassword.trim()
//                             );
//
//                            await user.reauthenticateWithCredential(credential).then((value) {
//                              error='';
//
//                             }).catchError((errors) {
//
//                               print(errors.code);
//                               error='Incorrect Password';
//                               if(error!='')
//                                 {
//                                   showToastMessage('Incorrect current password');
//                                 }
//                             });
//                            if(error=='')
//                              {
//                                final FirebaseAuth _auth =FirebaseAuth.instance;
//                                User? user  = _auth.currentUser;
//
//
//                                await user?.updatePassword(newpassword).then((value) {
//                                  showToastMessage('Success');
//                                  Navigator.pop(context);
//                                }).catchError((error) {
//
//                                 print(error);
//
//                                });
//
//                              }
//                           }
//                       })
//                 ],
//               ),
//             );
//           });
//     }
//     if (users != null) {
//       Query<Map<String, dynamic>> u = FirebaseFirestore.instance.collection(
//           'user').where('uid', isEqualTo: users.uid);
//
//
//       return Scaffold(
//           appBar: AppBar(
//             backgroundColor: kPrimaryColor,
//             title: Text('Thông tin người dùng'),
//           ),
//           body: StreamBuilder(
//               stream: u.snapshots(),
//               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (snapshot.hasError) {
//                   return Text('Something went wrong');
//                 }
//
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Text("Loading");
//                 }
//                 dynamic data = snapshot.data?.docs.map((e) => e.data()).toList().first;
//                 Users user = Users();
//                 user = Users(
//                   uid: data["uid"],
//                   name: data["name"],
//                   phone:data["phone"],
//                   email: data["email"],
//                   avatar: data["avatar"],
//
//                 );
//                 return Container(
//                   child: Column(
//                     children: [
//                       SizedBox(height: 30),
//                       Container(
//                         height: 115,
//                         width: 115,
//                         child: Stack(
//                           fit: StackFit.expand,
//                           children: [
//                             CircleAvatar(
//                               backgroundImage: AssetImage("${user.avatar}"),
//                               //backgroundImage:  AssetImage("assets/images/user.png")
//                             ),
//                             Align(
//                               alignment: Alignment.bottomRight,
//                               child: IconButton(
//                                 onPressed: () {
//
//                                 },
//                                 icon: Icon(Icons.edit),
//                                 hoverColor: Colors.white,
//                                 highlightColor: Colors.white,
//                                 splashColor: Colors.white,
//                                 color: Colors.black,
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       Expanded(
//                         child: ListView(
//
//                           children: [
//                             Container(
//                               margin: EdgeInsets.all(5),
//
//                               child: ListTile(
//                                   title: Text('Full Name'),
//                                   leading: Icon(Icons.account_circle_outlined,
//                                     color: Colors.black,),
//                                   trailing: IconButton(
//                                     onPressed: () {
//                                       _showDialog('Full Name', user.name,'name',snapshot);
//                                     },
//                                     icon: Icon(Icons.edit),
//                                     hoverColor: Colors.white,
//                                     highlightColor: Colors.white,
//                                     splashColor: Colors.white,
//                                     color: Colors.black,
//                                   ),
//                                   subtitle: Text('${user.name}')
//
//                               ),
//                             ),
//                             Container(
//                               margin: EdgeInsets.all(5),
//
//                               child: ListTile(
//                                   title: Text('Email'),
//                                   leading: Icon(
//                                     Icons.email_outlined, color: Colors.black,),
//                                   trailing: IconButton(
//                                     onPressed: () {
//                                       _showDialog('Email', user.email,'email',snapshot);
//                                     },
//                                     icon: Icon(Icons.edit),
//                                     hoverColor: Colors.white,
//                                     highlightColor: Colors.white,
//                                     splashColor: Colors.white,
//                                     color: Colors.black,
//                                   ),
//                                   subtitle: Text('${user.email}')
//
//                               ),
//                             ),
//                             Container(
//                               margin: EdgeInsets.all(5),
//
//                               child: ListTile(
//                                   title: Text('Phone'),
//                                   leading: Icon(
//                                     Icons.phone, color: Colors.black,),
//                                   trailing: IconButton(
//                                     onPressed: () {
//                                       _showDialog('Phone', user.phone,'phone',snapshot);
//                                     },
//                                     icon: Icon(Icons.edit),
//                                     hoverColor: Colors.white,
//                                     highlightColor: Colors.white,
//                                     splashColor: Colors.white,
//                                     color: Colors.black,
//                                   ),
//                                   subtitle: Text('${user.phone}')
//
//                               ),
//                             ),
//                             Container(
//                               margin: EdgeInsets.all(5),
//
//                               child: ListTile(
//                                 title: Text('Đổi mật khẩu'),
//                                 leading: Icon(
//                                   Icons.lock_outline, color: Colors.black,),
//                                 onTap: () {
//                                   _changePassword();
//                                 },
//
//
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 );
//               }
//
//           )
//
//
//       );
//     }
//     else {
//       return Container();
//     }
//   }
// }