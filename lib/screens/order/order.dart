import 'package:finalprojectmobile/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';
import 'package:finalprojectmobile/screens/order/components/body.dart';

class Order extends StatefulWidget  {
  Order({Key? key}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 5, vsync: this, initialIndex: 0);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đơn mua", style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search), color: Colors.black,)
        ],
        bottom: TabBar(
          isScrollable: true,
          labelColor: kPrimaryColor,
          indicatorColor: kPrimaryColor,
          unselectedLabelColor: Colors.black,
          controller: _tabController,
          tabs: const [
            Tab(text: "Chờ xác nhận", ),
            Tab(text: "Chờ lấy hàng"),
            Tab(text: "Đang giao"),
            Tab(text: "Đã giao"),
            Tab(text: "Đã hủy")
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Container(
            color: Colors.white,
              child: const Body(status: 0,),
          ),
          Container(
            color: Colors.white,
            child: const Body(status: 1,),
          ),
          Container(
            color: Colors.white,
            child: const Body(status: 2,),
          ),
          Container(
            color: Colors.white,
            child: const Body(status: 3,),
          ),
          Container(
            color: Colors.white,
            child: const Body(status: -1,),
          ),
        ],
      ),

    );
  }
}
