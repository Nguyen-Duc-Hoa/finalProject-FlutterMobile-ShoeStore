import 'package:final_project_mobile/constants.dart';
import 'package:final_project_mobile/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "final project shoeStore",
    options: const FirebaseOptions(
      apiKey: "XXX",
      appId: "1:167447585480:android:8c8ba853f4a714b61b3bfd",
      messagingSenderId: "XXX",
      projectId: "final-project-shoestore",
    ),
  );
  print('-- WidgetsFlutterBinding.ensureInitialized');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          fontFamily: "Muli",
          textTheme: const TextTheme(
              bodyText1: TextStyle(color: kTextColor),
              bodyText2: TextStyle(color: kTextColor))),
      home: HomeScreen(),
    );
  }
}

