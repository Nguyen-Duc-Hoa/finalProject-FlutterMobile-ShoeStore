import 'package:flutter/widgets.dart';
import 'package:final_project_mobile/screens/cart/cart_screen.dart';
import 'package:final_project_mobile/screens/details/details_screen.dart';
import 'package:final_project_mobile/screens/home/home_screen.dart';
import 'package:final_project_mobile/screens/splash/splash_screen.dart';


// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
};