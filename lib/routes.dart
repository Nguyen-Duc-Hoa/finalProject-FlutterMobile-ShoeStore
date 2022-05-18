
import 'package:finalprojectmobile/screens/address/address_screen.dart';
import 'package:finalprojectmobile/screens/order_detail/order_detail.dart';
import 'package:finalprojectmobile/screens/payment/checkout.dart';
import 'package:finalprojectmobile/screens/profile/profile.dart';
import 'package:finalprojectmobile/screens/sign_in/login_screen.dart';
import 'package:finalprojectmobile/screens/sign_up/signup.dart';
import 'package:finalprojectmobile/screens/voucher/voucher.dart';
import 'package:flutter/widgets.dart';
import 'package:finalprojectmobile/screens/cart/cart_screen.dart';
import 'package:finalprojectmobile/screens/details/details_screen.dart';
import 'package:finalprojectmobile/screens/home/home_screen.dart';
import 'package:finalprojectmobile/screens/splash/splash_screen.dart';


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
  VoucherScreen.routeName:(context) => VoucherScreen(),
  Profile.routeName:(context) => Profile(),
};
