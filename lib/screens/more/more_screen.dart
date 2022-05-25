import 'package:finalprojectmobile/constants.dart';
import 'package:finalprojectmobile/models/mCategories.dart';
import 'package:finalprojectmobile/screens/filter/filter_screen.dart';
import 'package:finalprojectmobile/screens/home/components/categories.dart';
import 'package:finalprojectmobile/screens/home/components/home_header.dart';
import 'package:finalprojectmobile/screens/more/components/more_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../more/components/body.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key, required this.categories, required this.gender})
      : super(key: key);
  final Gender gender;
  final mCategories categories;

  @override
  _MoreCreenState createState() => _MoreCreenState();
}

class _MoreCreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
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
            icon: Icon(Icons.search),
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
        child: Icon(Icons.filter),
        onPressed: () {
          Get.to(FilterScreen());
        },
      ),
    );
  }
}

class CustomSearch extends SearchDelegate{
  List<String> allData = ['a', 'b', 'c', 'd'];

  @override
  List<Widget>? buildActions(BuildContext context) {
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
