import 'package:final_project_mobile/constants.dart';

import 'package:final_project_mobile/screens/cart/cart_screen.dart';
import 'package:final_project_mobile/screens/more/more_screen.dart';

import 'package:final_project_mobile/screens/address/address_screen.dart';
import 'package:final_project_mobile/screens/home/home_screen.dart';
import 'package:final_project_mobile/screens/order_detail/order_detail.dart';

import 'package:final_project_mobile/screens/page/page.dart';
import 'package:final_project_mobile/screens/payment/checkout.dart';
import 'package:final_project_mobile/screens/sign_in/login_screen.dart';
import 'package:final_project_mobile/services/auth.dart';
import 'package:final_project_mobile/size_config.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(
  //   name: "final project shoeStore",
  //   options: const FirebaseOptions(
  //     apiKey: "XXX",
  //     appId: "1:167447585480:android:8c8ba853f4a714b61b3bfd",
  //     messagingSenderId: "XXX",
  //     projectId: "final-project-shoestore",
  //   ),
  // );
  await Firebase.initializeApp(
    name: "final project shoeStore",
    options: const FirebaseOptions(
      apiKey: "XXX",
      appId: "1:851369785064:android:f7ed3b48ce4f4a919bbb5d",
      messagingSenderId: "XXX",
      projectId: "final-project-shoestore-334b6",
    ),
  );
  print('-- WidgetsFlutterBinding.ensureInitialized');
  String uid = await AuthService().getUid();
  runApp( MyApp(uid));
}

class MyApp extends StatelessWidget {
  final String uid;
  const MyApp(this.uid);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(uid);
    return StreamProvider<Users?>.value
    (value: AuthService().user,
    initialData: null,

    child:GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          fontFamily: "Muli",
          textTheme: const TextTheme(
              bodyText1: TextStyle(color: kTextColor),
              bodyText2: TextStyle(color: kTextColor))),
      // home: uid==null?Login():Pages(),
        home: Pages(),
        routes:{
          '/home': (context) =>Pages(),
          '/login': (context) =>Login(),
        }
    ));
  }
}

