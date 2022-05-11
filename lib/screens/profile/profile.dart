import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../models/user.dart';

class Profile extends StatelessWidget {
  static String routeName = "/profile";
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<Users>(context);
    _showDialog(title,value) async {
      await showDialog<String>(
        context: context,

      builder:(context){
         return AlertDialog(
           contentPadding: const EdgeInsets.all(16.0),
           content: Row(
             children: <Widget>[
               Expanded(
                 child: TextFormField(
                   autofocus: true,
                   initialValue: value,
                   decoration: InputDecoration(
                       labelText: '${title}'),
                 ),
               )
             ],
           ),
           actions: <Widget>[
             FlatButton(
                 child: const Text('Cancel',style: TextStyle(color: Colors.red)),

                 onPressed: () {
                   Navigator.pop(context);
                 }),
             FlatButton(
                 child: const Text('Save',style: TextStyle(color: Colors.blue)),
                 onPressed: () {

                 })
           ],
         );
      });


    }
    _changePassword() async {
      await showDialog<String>(
          context: context,

          builder:(context){
            return AlertDialog(
              title: Text('Đổi mật khẩu',style: TextStyle(color: kPrimaryColor,fontSize: 18),),
              contentPadding: const EdgeInsets.all(16.0),
              content:
              SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      obscureText: true,
                      autofocus: true,
                      initialValue: null,
                      decoration: new InputDecoration(
                          labelText: 'Current Password'),
                    ),
                    TextFormField(
                      obscureText: true,
                      autofocus: true,
                      initialValue: null,
                      decoration: new InputDecoration(
                          labelText: 'New Password'),
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text('Thông tin người dùng'),
        ),
      body: Container(
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
                    backgroundImage: user.avatar==null? AssetImage("assets/images/user.png"):AssetImage("${user.avatar}"),
                    //backgroundImage:  AssetImage("assets/images/user.png")
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      onPressed: (){

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
                        leading: Icon(Icons.account_circle_outlined,color: Colors.black,),
                        trailing: IconButton(
                          onPressed: (){
                            _showDialog('Full Name',user.name);
                          },
                          icon: Icon(Icons.edit),
                          hoverColor: Colors.white,
                          highlightColor: Colors.white,
                          splashColor: Colors.white,
                          color: Colors.black,
                        ),
                        subtitle: user.name==null? Text(''):Text('${user.name}')

                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),

                    child: ListTile(
                        title: Text('Email'),
                        leading: Icon(Icons.email_outlined,color: Colors.black,),
                        trailing: IconButton(
                          onPressed: (){
                            _showDialog('Email',user.email);
                          },
                          icon: Icon(Icons.edit),
                          hoverColor: Colors.white,
                          highlightColor: Colors.white,
                          splashColor: Colors.white,
                          color: Colors.black,
                        ),
                        subtitle: user.email==null? Text(''):Text('${user.email}')

                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),

                    child: ListTile(
                        title: Text('Phone'),
                        leading: Icon(Icons.phone,color: Colors.black,),
                        trailing: IconButton(
                          onPressed: (){
                            _showDialog('Phone',user.phone);
                          },
                          icon: Icon(Icons.edit),
                          hoverColor: Colors.white,
                          highlightColor: Colors.white,
                          splashColor: Colors.white,
                          color: Colors.black,
                        ),
                        subtitle:  user.phone==null? Text(''):Text('${user.phone}')

                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),

                    child: ListTile(
                        title: Text('Đổi mật khẩu'),
                        leading: Icon(Icons.lock_outline,color: Colors.black,),
                        onTap: (){
                          _changePassword();
                        },


                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
class _SystemPadding extends StatelessWidget {
  final Widget? child;
  const _SystemPadding({Key? key,this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return new AnimatedContainer(
        padding: mediaQuery.viewInsets,
        duration: const Duration(milliseconds: 300),
        child: child);
  }
}
