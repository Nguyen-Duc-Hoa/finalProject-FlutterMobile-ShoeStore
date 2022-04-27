
import 'package:final_project_mobile/screens/address/address_screen.dart';
import 'package:final_project_mobile/screens/order_detail/order_detail.dart';
import 'package:final_project_mobile/screens/payment/checkout.dart';
import 'package:final_project_mobile/screens/sign_in/login_screen.dart';
import 'package:final_project_mobile/screens/sign_up/signup.dart';
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
  Login.routeName: (context) => Login(),
  Signup.routeName: (context) => Signup(),
  Checkout.routeName: (context) => Checkout(),
  AddressScreen.routeName: (context) => AddressScreen(),
  OrderDetail.routeName: (context) => OrderDetail(),
};
