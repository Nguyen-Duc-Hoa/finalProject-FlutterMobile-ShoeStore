import 'package:finalprojectmobile/common.dart';
import 'package:finalprojectmobile/components/default_button.dart';
import 'package:finalprojectmobile/models/favorite.dart';
import 'package:finalprojectmobile/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finalprojectmobile/models/Product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProductDescription extends StatefulWidget {
  const ProductDescription({
    Key? key,
    required this.product,
    this.pressOnSeeMore,
  }) : super(key: key);

  final Product product;
  final GestureTapCallback? pressOnSeeMore;

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference favoriteCol =
      FirebaseFirestore.instance.collection('favorite');

  final Common _common = Common();

  bool isLike = false;
  Users user = Users();
  String documentID = '';

  @override
  Widget build(BuildContext context) {
    user = Provider.of<Users>(context);
    // return StreamBuilder<QuerySnapshot>(
    //     stream: favorite.snapshots(),
    //     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //       if (snapshot.hasError) {
    //         return Text('Something went wrong');
    //       }
    //       var dataList = snapshot.data?.docs.map((e) => e.data()).toList();
    //       Favorite favorite = Favorite();
    //       print('2222222222222222');
    //       dataList?.forEach((element) {
    //         print('1111111111111111111111111111');
    //         print(element);
    //         final Map<String, dynamic> doc = element as Map<String, dynamic>;
    //         favorite = Favorite(
    //             userId: doc['userId'],
    //             productId: doc['productId'],
    //             isFavorite: doc['isFavorite']);
    //
    //         print(favorite);
    //         if (favorite != null) {
    //           isFavorite = true;
    //         }
    //       });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Text(
            widget.product.title,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        if (widget.product.disCount != 0)
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(30)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _common.formatCurrency(widget.product.price),
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(13),
                      fontWeight: FontWeight.w600,
                      color: kSecondaryColor,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ]),
          ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _common.formatCurrency(widget.product.disCount == 0
                    ? widget.product.price
                    : widget.product.price *
                        (1 - widget.product.disCount / 100)),
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(16),
                  fontWeight: FontWeight.w600,
                  color: kPrimaryColor,
                ),
              ),
            ],
          ),
        ),
        if (user != null)
          StreamBuilder<QuerySnapshot>(
              //stream: favorite.snapshots(),
              stream: favoriteCol
                  .where('userId', isEqualTo: user.uid)
                  .where("productId", isEqualTo: widget.product.id)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                var dataList =
                    snapshot.data?.docs.map((e) => e.data()).toList();

                Favorite favorite1 = Favorite();
                dataList?.forEach((element) {
                  final Map<String, dynamic> doc =
                      element as Map<String, dynamic>;
                  favorite1 = Favorite(
                      userId: doc['userId'],
                      productId: doc['productId'],
                      isFavorite: doc['isFavorite']);

                  if (favorite1 != null) {
                    isLike = true;
                  }
                });

                return Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: (){
                      setState((){
                        if (isLike) {
                          favorite1 = Favorite(
                              userId: user.uid,
                              productId: widget.product.id,
                              isFavorite: false);
                          deleteLike(favorite1);
                          if(true){
                            isLike = !isLike;
                          }
                        } else {
                          Favorite favorite2 = Favorite(
                              userId: user.uid,
                              productId: widget.product.id,
                              isFavorite: true);

                          addLike(favorite2);

                          isLike = !isLike;
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(15)),
                      width: getProportionateScreenWidth(64),
                      decoration: BoxDecoration(
                        color: isLike ? Color(0xFFFFE6E6) : Color(0xFFF5F6F9),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/Heart Icon_2.svg",
                        color: isLike ? Color(0xFFFF4848) : Color(0xFFDBDEE4),
                        height: getProportionateScreenWidth(16),
                      ),
                    ),
                  ),
                );
              }),
        if (user == null)
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(15)),
                width: getProportionateScreenWidth(64),
                decoration: BoxDecoration(
                  color: isLike ? Color(0xFFFFE6E6) : Color(0xFFF5F6F9),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: SvgPicture.asset(
                  "assets/icons/Heart Icon_2.svg",
                  color: isLike ? Color(0xFFFF4848) : Color(0xFFDBDEE4),
                  height: getProportionateScreenWidth(16),
                ),
              ),
            ),
          ),
        Padding(
            padding: EdgeInsets.only(
              left: getProportionateScreenWidth(20),
              right: getProportionateScreenWidth(64),
            ),
            child: DescriptionText(text: widget.product.description)
            // Text(
            //   product.description,
            //   maxLines: 3,
            // ),
            ),
      ],
    );
  }

  Future<bool> deleteLike(Favorite favorite) async {
    bool result = false;
    String favoriteId = "";
    await FirebaseFirestore.instance
        .collection('favorite')
        .where('userId', isEqualTo: favorite.userId)
        .where('productId', isEqualTo: favorite.productId)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        favoriteId = doc.id;

      });
    });
    // Call the user's CollectionReference to add a new user
    if (favoriteId != "") {
      await favoriteCol.doc(favoriteId).delete().then((value) {
        print('delete ok');
        result = true;
        isLike = false;
        return;
      }).catchError((error) => () {
        print("Failed to add user: $error");
        return;
      });
    }
    return result;
  }

  Future<bool> addLike(Favorite favorite) async {
    bool result = false;
    await favoriteCol.add({
      'userId': favorite.userId,
      "productId": favorite.productId,
      'isFavorite': favorite.isFavorite
    }).then((value) {
      result = true;
    }).catchError((error) {
      print("Failed to add user: $error");
      result = false;
    });
    return result;
  }
}

class DescriptionText extends StatefulWidget {
  final String text;

  const DescriptionText({required this.text});

  @override
  DescriptionTextState createState() => DescriptionTextState();
}

class DescriptionTextState extends State<DescriptionText> {
  late String firstHalf;
  late String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 50) {
      firstHalf = widget.text.substring(0, 50);
      secondHalf = widget.text.substring(50, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: secondHalf.isEmpty
          ? Text(firstHalf)
          : Column(
              children: <Widget>[
                Text(flag ? (firstHalf + "...") : (firstHalf + secondHalf)),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      flag
                          ? Row(
                              children: const [
                                Text(
                                  "Xem thêm",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: kPrimaryColor),
                                ),
                                SizedBox(width: 5),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 12,
                                  color: kPrimaryColor,
                                ),
                              ],
                            )
                          : Row(
                              children: const [
                                Icon(
                                  Icons.arrow_back_ios,
                                  size: 12,
                                  color: kPrimaryColor,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Thu gọn",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: kPrimaryColor),
                                ),
                              ],
                            ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),
              ],
            ),
    );
  }
}
