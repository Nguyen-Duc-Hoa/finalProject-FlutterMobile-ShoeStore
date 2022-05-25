import 'package:finalprojectmobile/constants.dart';
import 'package:finalprojectmobile/models/mCategories.dart';
import 'package:finalprojectmobile/screens/filter/filter_screen.dart';
import 'package:finalprojectmobile/screens/home/components/categories.dart';
import 'package:finalprojectmobile/screens/home/components/home_header.dart';
import 'package:finalprojectmobile/screens/more/components/more_header.dart';
import 'package:finalprojectmobile/screens/search/components/body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, required this.name}) : super(key: key);

  final String name;
  // final Gender gender;
  // final mCategories categories;

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
        title: Text(AppLocalizations.of(context)!.search),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: CustomSearch());
            },
            icon: Icon(Icons.search),
            color: Colors.white,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        child: Icon(Icons.filter),
        onPressed: () {
          Get.to(FilterScreen());
        },
      ),
      body: Body(name: widget.name),
    );
  }
}

class CustomSearch extends SearchDelegate {
  List<String> allData = ['a', 'b', 'c', 'd'];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var item in allData)
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }

    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
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
