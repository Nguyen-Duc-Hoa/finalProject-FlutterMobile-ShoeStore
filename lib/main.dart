import 'package:finalprojectmobile/constants.dart';
import 'package:finalprojectmobile/screens/page/page.dart';
import 'package:finalprojectmobile/screens/sign_in/login_screen.dart';
import 'package:finalprojectmobile/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'AppLocalizations.dart';
import 'models/user.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
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
      apiKey: "AIzaSyCozD7KnAwi1sq-UizuJjxUx0DO5vXxsVc",
      appId: "1:851369785064:android:0e32d387e41b200f9bbb5d",
      messagingSenderId: "XXX",
      projectId: "final-project-shoestore-334b6",
    ),
  );
  print('-- WidgetsFlutterBinding.ensureInitialized');
  String uid = await AuthService().getUid();
  runApp(MyApp(uid));
}

class MyApp extends StatelessWidget {
  final String uid;

  const MyApp(this.uid);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users?>.value(
        value: AuthService().user,
        initialData: null,
        child: GetMaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                fontFamily: "Muli",
                textTheme: const TextTheme(
                    bodyText1: TextStyle(color: kTextColor),
                    bodyText2: TextStyle(color: kTextColor))),
            // home: uid==null?Login():Pages(),
            supportedLocales: const [
              Locale('vi', ''),
              Locale('en', ''),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            // localeResolutionCallback: (locale, supportedLocales) {
            //   for (var supportedLocale in supportedLocales) {
            //     if (supportedLocale.languageCode == locale.languageCode &&
            //         supportedLocale.countryCode == locale.countryCode) {
            //       return supportedLocale;
            //     }
            //   }
            //   return supportedLocales.first;
            // },
            home: const Pages(
              selectedIndex: 0,
            ),
            routes: {
              '/home': (context) => const Pages (
                    selectedIndex: 0,
                  ),
              '/login': (context) => Login(),
            }));
  }
}
