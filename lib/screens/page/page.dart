import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalprojectmobile/constants.dart';
import 'package:finalprojectmobile/screens/favorite/favorite_screen.dart';
import 'package:finalprojectmobile/screens/home/home_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../account/account.dart';
import '../order/order.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Pages extends StatefulWidget {
  const Pages({Key? key, required this.selectedIndex}) : super(key: key);
  final int selectedIndex;

  @override
  _PagesState createState() => _PagesState();
}

class _PagesState extends State<Pages> {

  late int _selectedIndex;
  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    FavoriteScreen(),
    Order(),
    Account(),
  ];

  @override
  void initState(){
    _selectedIndex = widget.selectedIndex;
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.black38,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Yêu thích'),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt), label: 'Đơn hàng'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Tài khoản'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kPrimaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
