import 'package:finalprojectmobile/common.dart';
import 'package:finalprojectmobile/models/favorite.dart';
import 'package:finalprojectmobile/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finalprojectmobile/models/Product.dart';

import 'package:finalprojectmobile/constants.dart';
import 'package:finalprojectmobile/screens/details/details_screen.dart';
import 'package:finalprojectmobile/screens/home/HomeController.dart';
import 'package:finalprojectmobile/size_config.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class FavoriteCard extends StatefulWidget {
  FavoriteCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
    required this.press,
    this.sPopular = "",
  }) : super(key: key);

  final double width, aspectRetio;
  final Product product;
  final String sPopular;
  final GestureTapCallback press;

  @override
  State<FavoriteCard> createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  HomeController c = Get.put(HomeController());

  CollectionReference favoriteCol =
  FirebaseFirestore.instance.collection('favorite');
  Users user = Users();

  @override
  Widget build(BuildContext context) {
    bool isFavourite = true;
    user = Provider.of<Users>(context);

    Common _common = Common();
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(widget.width),
        child: GestureDetector(
          onTap: (){
            c.productDetail(widget.product);
            c.SetListImage(widget.product, 0);
            Get.to(DetailsScreen());
          },// Detailcreen
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.02,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Hero(
                    tag: widget.product.id.toString()+widget.sPopular,
                    child: Image.asset(widget.product.images[0]),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.product.title,
                style: TextStyle(color: Colors.black),
                maxLines: 2,

              ),
              Row(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _common.formatCurrency(widget.product.disCount == 0 ? widget.product.price : widget.product.price * (1 - widget.product.disCount / 100)),
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(15),
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {},
                    child: GestureDetector(
                      onTap: (){
                        Favorite favorite = Favorite(productId: widget.product.id, userId: user.uid, isFavorite: true);
                        deleteLike(favorite);
                      },
                      child: Container(
                        padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                        height: getProportionateScreenWidth(28),
                        width: getProportionateScreenWidth(28),
                        decoration: BoxDecoration(
                          color: isFavourite
                              ? kPrimaryColor.withOpacity(0.15)
                              : kSecondaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          "assets/icons/Heart Icon_2.svg",
                          color: isFavourite
                              ? Color(0xFFFF4848)
                              : Color(0xFFDBDEE4),
                        ),
                      ),
                    ),
                  ),

                ],
              )
            ],
          ),
        ),
      ),
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
        return;
      }).catchError((error) => () {
        print("Failed to add user: $error");
        return;
      });
    }
    return result;
  }
}
