import 'package:final_project_mobile/constants.dart';
import 'package:flutter/material.dart';

import '../filter/components/body.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text("Bộ lọc"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Price",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: kPrimaryColor),
            ),

            Text(
              "Categories",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: kPrimaryColor),
            )
          ],
        ),
      ),
    );
  }
}
