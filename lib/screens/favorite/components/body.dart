import 'package:finalprojectmobile/components/product_card.dart';
import 'package:finalprojectmobile/models/Product.dart';
import 'package:finalprojectmobile/models/favorite.dart';
import 'package:finalprojectmobile/models/user.dart';
import 'package:finalprojectmobile/screens/favorite/components/favorite_card.dart';
import 'package:finalprojectmobile/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  CollectionReference favoriteCol =
      FirebaseFirestore.instance.collection('favorite');
  CollectionReference productCol =
      FirebaseFirestore.instance.collection('products');
  Users user = Users();

  @override
  Widget build(BuildContext context) {
    user = Provider.of<Users>(context);
    List<Product> listFavorite =
        demoProducts.where((element) => element.isFavourite).toList();
    return StreamBuilder<QuerySnapshot>(
        stream: favoriteCol.where('userId', isEqualTo: user.uid).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          List<int> lstProID = [];
          var dataList = snapshot.data?.docs.map((e) => e.data()).toList();
          Favorite favorite1 = Favorite();
          dataList?.forEach((element) {
            final Map<String, dynamic> doc = element as Map<String, dynamic>;
            favorite1 = Favorite(
                userId: doc['userId'],
                productId: doc['productId'],
                isFavorite: doc['isFavorite']);
            int item = favorite1.productId ?? -1;
            if (item != -1) {
              lstProID.add(item);
            }
            print(lstProID);
          });
          if (lstProID.isEmpty) {
            return const SizedBox.shrink();
          }
          return SafeArea(
            child: StreamBuilder<QuerySnapshot>(
                stream: productCol.where('id', whereIn: lstProID).snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }
                  List<Product> lstProduct = [];
                  // if (snapshot.connectionState == ConnectionState.waiting) {
                  //   return Text("Loading");
                  // }
                  var dataList =
                      snapshot.data?.docs.map((e) => e.data()).toList();
                  print(dataList?.length);
                  dataList?.forEach((element) {
                    List<String> images;
                    final Map<String, dynamic> doc =
                        element as Map<String, dynamic>;
                    images = doc["images"]?.cast<String>();
                    List<String> sColors = doc["colors"].cast<String>();
                    List<int> lstSize;
                    lstSize = doc["size"]?.cast<int>();
                    Product p = Product(
                        id: doc["id"],
                        images: images,
                        colors: sColors,
                        title: doc["title"].toString(),
                        price: doc["price"].toDouble(),
                        description: doc["description"].toString(),
                        category: doc["category"],
                        disCount: doc["discount"],
                        gender: doc["gender"],
                        rating: doc['rate'].toDouble(),
                        size: lstSize);
                    lstProduct.add(p);
                    print(p.title);
                  });

                  return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenHeight(10),
                          horizontal: getProportionateScreenWidth(10)),
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: getProportionateScreenWidth(8),
                        mainAxisSpacing: getProportionateScreenHeight(2),
                        childAspectRatio: (1 / 1.42),
                        children: [
                          ...List.generate(lstProduct.length, (index) {
                            return Container(
                              child: FavoriteCard(
                                  product: lstProduct[index],
                                  press: () {
                                    // c.productDetail(lstProduct[index]);
                                    // c.SetListImage(lstProduct[index], 0);
                                    // Get.to(DetailsScreen());
                                  }),
                            );
                            //   return Container(
                            //     color: Colors.black,
                            //   );
                          }),
                        ],
                      ));
                }),
          );
        });
  }
}
