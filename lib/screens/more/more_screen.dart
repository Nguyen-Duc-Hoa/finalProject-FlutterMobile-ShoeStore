import 'package:finalprojectmobile/constants.dart';
import 'package:finalprojectmobile/models/Product.dart';
import 'package:finalprojectmobile/models/mCategories.dart';
import 'package:finalprojectmobile/screens/filter/filter_screen.dart';
import 'package:finalprojectmobile/screens/more/ProductController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../more/components/body.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key, required this.categories, required this.gender})
      : super(key: key);
  final Gender gender;
  final mCategories categories;

  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {

  final ProductController _productController = Get.put(ProductController());
  late FirebaseFirestore firestore = FirebaseFirestore.instance;

  var products;

  @override
  void initState() {
    super.initState();
    products = FirebaseFirestore.instance
        .collection('products')
        .orderBy('title')
        .where("category", isEqualTo: widget.categories.id)
        .where('gender', isEqualTo: widget.gender.id);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: products.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        var dataList = snapshot.data?.docs.map((e) => e.data()).toList();
        List<Product> lstProduct = [];
        List<String> lstName = [];
        dataList?.forEach((element) {
          List<String> images;
          final Map<String, dynamic> doc = element as Map<String, dynamic>;
          images = doc["images"]?.cast<String>();

          List<String> sColors = doc["colors"].cast<String>();
          // List<Color> lstColor = [];
          // for (var element in sColors) {
          //   String valueString = element.split('(0x')[1].split(')')[0];
          //   int value = int.parse(valueString, radix: 16);
          //   lstColor.add(Color(value));
          // }

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
              rating: doc["rate"].toDouble(),
              size: lstSize);
          lstProduct.add(p);
          lstName.add(p.title);
        });

        _productController.setLstCurrentProduct(lstProduct);
        _productController.setLstName(lstName);



        return Scaffold(
          // appBar: PreferredSize(
          //   preferredSize: Size.fromHeight(AppBar().preferredSize.height + 5),
          //   child: Padding(
          //     padding: const EdgeInsets.only(top: 25.0, bottom: 15.0),
          //     child: HomeHeader(),
          //   ),
          // ),
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            title: Text(widget.categories.name),
            actions: [
              IconButton(
                onPressed: (){showSearch(context: context, delegate: CustomSearch());},
                icon: const Icon(Icons.search),
                color: Colors.white,
              )
            ],
          ),
          body: Body(
            gender: widget.gender,
            category: widget.categories,
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: kPrimaryColor,
            child: const Icon(Icons.filter),
            onPressed: () {
              Get.to(const FilterScreen());
            },
          ),
        );
      }
    );
  }
}

class CustomSearch extends SearchDelegate{
  List<String> allData = [];
  ProductController _productController = Get.find();

  @override
  List<Widget>? buildActions(BuildContext context) {
    allData = _productController.lstName.value;
    return [
      IconButton(onPressed: (){
        query = '';
      }, icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return
      IconButton(onPressed: (){
        close(context, null);
      }, icon: const Icon(Icons.arrow_back));

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for(var item in allData)
      if(item.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(item);
      }
    
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index){
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }
}
