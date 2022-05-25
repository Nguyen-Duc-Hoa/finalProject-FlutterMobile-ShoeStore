import 'package:finalprojectmobile/constants.dart';
import 'package:finalprojectmobile/screens/home/HomeController.dart';
import 'package:finalprojectmobile/screens/home/components/category_product.dart';
import 'package:finalprojectmobile/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../../AppLocalizations.dart';
import 'discount_banner.dart';
import 'popular_product.dart';
import 'special_offers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:finalprojectmobile/models/mCategories.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference category =
      FirebaseFirestore.instance.collection('categories');

  List<Gender> lstCate = demoGender;
  // HomeController _homeController =

  int selectedIndex = 0;

  double getHeight() {
    return 800;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
    print('language');
    print(AppLocalizations.of(context)!.helloWorld);
    TabController _tabController =
        TabController(length: demoGender.length, vsync: this);
    return StreamBuilder<QuerySnapshot>(
        stream: category.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return Text("Loading");
          // }



          var dataList = snapshot.data?.docs.map((e) => e.data()).toList();
          List<mCategories> lstCategories = [];
          dataList?.forEach((element) {
            final Map<String, dynamic> doc = element as Map<String, dynamic>;
            mCategories cate = mCategories(id: doc["id"], name: doc["name"]);

            lstCategories.add(cate);
          });
          // return SafeArea(
          //   child: SingleChildScrollView(
          //     child: Column(
          //       children: [
          //         // SizedBox(
          //         //   height: getProportionateScreenWidth(20),
          //         // ),
          //         // HomeHeader(),
          //         SizedBox(
          //           height: getProportionateScreenWidth(30),
          //         ),
          //         DiscountBanner(),
          //         //Categories(),
          //         SpecialOffers(),
          //         SizedBox(height: getProportionateScreenWidth(30)),
          //         PopularProducts(),
          //         SizedBox(height: getProportionateScreenWidth(30)),
          //         // SizedBox(
          //         //   height: getProportionateScreenHeight(50),
          //         //   child: ListView.builder(
          //         //     scrollDirection: Axis.horizontal,
          //         //     itemCount: lstCate.length,
          //         //     itemBuilder: (context, index) =>
          //         //         buildCategory(context, index),
          //         //   ),
          //         // ),
          //         Container(
          //             child: TabBar(
          //               isScrollable: true,
          //               labelColor: kPrimaryColor,
          //               indicatorColor: kPrimaryColor,
          //               unselectedLabelColor: Colors.black,
          //               controller: _tabController,
          //           tabs: [
          //             ...List.generate(demoType.length, (index) {
          //               return Tab(text: demoType[index].name);
          //             }),
          //           ],
          //         )),
          //         Container(
          //           height: 300,
          //             child: TabBarView(
          //               controller: _tabController,
          //           children: [
          //             ...List.generate(demoType.length, (index) {
          //               return SingleChildScrollView(child: Column(children: [ Text(demoType[index].name)]));}),
          //           ],
          //         )),
          //
          //         SizedBox(height: getProportionateScreenHeight(30)),
          //         ...List.generate(lstCategories.length, (index) {
          //           return CategoryProducts(category: lstCategories[index]);
          //         }),
          //       ],
          //     ),
          //   ),
          // );

          return SafeArea(
            child: Stack(
              children: [
                DefaultTabController(
                  length: 3,
                  child: NestedScrollView(
                    headerSliverBuilder: (context, value) {
                      return [
                        SliverAppBar(
                            backgroundColor: Colors.white,
                            collapsedHeight: 700,
                            flexibleSpace: Column(children: [
                              // SizedBox(
                              //   height: getProportionateScreenWidth(20),
                              // ),
                              // HomeHeader(),
                              SizedBox(
                                height: getProportionateScreenWidth(30),
                              ),
                              DiscountBanner(),
                              //Categories(),
                              SpecialOffers(),
                              SizedBox(height: getProportionateScreenWidth(30)),
                              PopularProducts(),
                            ])),
                        // SliverPersistentHeader(
                        //   pinned: true,
                        //   delegate: _SliverAppBarDelegate(
                        //     minHeight: 90,
                        //     maxHeight: 90,
                        //     child: Container(
                        //       height: getHeight() * (1 / 11),
                        //       width: double.infinity,
                        //       color: Colors.green[200],
                        //       child: Center(
                        //         child: Text(
                        //           "TEXT",
                        //           style: TextStyle(
                        //             fontSize: 32,
                        //             color: Colors.white,
                        //             fontWeight: FontWeight.bold,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        SliverPersistentHeader(

                          pinned: true,
                          delegate: _SliverAppBarDelegate(
                            minHeight: 60,
                            maxHeight: 60,
                            child: Container(
                              color: Colors.white,
                              child: TabBar(
                                isScrollable: true,
                                labelColor: kPrimaryColor,
                                indicatorColor: kPrimaryColor,
                                unselectedLabelColor: Colors.black,
                                controller: _tabController,
                                tabs: [
                                  ...List.generate(demoGender.length, (index) {
                                    return Tab(
                                        child: Container(
                                      alignment: Alignment.center,
                                      width: getProportionateScreenWidth(80),
                                      child: Text(
                                        demoGender[index].name,
                                        //AppLocalizations.of(context)!.translate(demoGender[index].name).toString(),
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ));
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ];
                    },
                    body: TabBarView(
                      controller: _tabController,
                      children: [
                        ...List.generate(demoGender.length, (i) {
                          return SingleChildScrollView(
                              child: Column(
                            children: [
                              SizedBox(
                                  height: getProportionateScreenHeight(30)),
                              ...List.generate(lstCategories.length, (index) {
                                return CategoryProducts(
                                    gender: demoGender[i],
                                    category: lstCategories[index]);
                              }),
                            ],
                          ));
                        })
                      ],
                    ),
                  ),
                ),
                // Container(
                //   height: 90,
                //   padding: EdgeInsets.symmetric(horizontal: 15),
                //   child: InkWell(
                //     onTap: () {},
                //     child: Icon(Icons.arrow_back),
                //   ),
                // ),
              ],
            ),
          );
        });
  }

  Widget buildCategory(BuildContext context, int index) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            demoGender[index].name,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color:
                    selectedIndex == index ? Colors.black : Color(0xFF656464)),
          ),
          Container(
            margin: EdgeInsets.only(top: getProportionateScreenWidth(10) / 4),
            height: getProportionateScreenHeight(3),
            width: getProportionateScreenWidth(30),
            color: selectedIndex == index ? Colors.black : Colors.transparent,
          )
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
