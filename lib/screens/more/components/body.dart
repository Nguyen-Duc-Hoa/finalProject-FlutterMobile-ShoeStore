import 'package:final_project_mobile/components/product_card.dart';
import 'package:final_project_mobile/models/Product.dart';
import 'package:final_project_mobile/models/mCategories.dart';
import 'package:final_project_mobile/size_config.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.gender, required this.category}) : super(key: key);
  final Gender gender;
  final mCategories category;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late FirebaseFirestore firestore = FirebaseFirestore.instance;

  var products;

  @override
  void initState() {
    super.initState();
    products = FirebaseFirestore.instance
        .collection('products')
        .orderBy('title')
        .where("category", isEqualTo: widget.category.id)
        .where('gender', isEqualTo: widget.gender.id);
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
      stream: products.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        var dataList = snapshot.data?.docs.map((e) => e.data()).toList();
        List<Product> lstProduct = [];
        dataList?.forEach((element) {
          List<String> images;
          final Map<String, dynamic> doc = element as Map<String, dynamic>;
          images = doc["images"]?.cast<String>();

          List<String> sColors = doc["colors"].cast<String>();
          List<Color> lstColor = [];
          for (var element in sColors) {
            String valueString = element.split('(0x')[1].split(')')[0];
            int value = int.parse(valueString, radix: 16);
            lstColor.add(Color(value));
          }

          List<int> lstSize;
          lstSize = doc["size"]?.cast<int>();

          Product p = Product(
              id: doc["id"],
              images: images,
              colors: lstColor,
              title: doc["title"].toString(),
              price: doc["price"].toDouble(),
              description: doc["description"].toString(),
              category: doc["category"],
              disCount: doc["discount"],
              gender: doc["gender"],
              size: lstSize);
          lstProduct.add(p);
        });

        if (lstProduct.isEmpty) {
          return const SizedBox.shrink();
        }

        return SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(10),
                  horizontal: getProportionateScreenWidth(10)),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: getProportionateScreenWidth(8),
                mainAxisSpacing: getProportionateScreenHeight(2),
                childAspectRatio: (1 / 1.3),
                children: [
                  ...List.generate(lstProduct.length, (index) {
                    return Container(
                      child: ProductCard(
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
              )),
        );
      }
    );
  }
}
