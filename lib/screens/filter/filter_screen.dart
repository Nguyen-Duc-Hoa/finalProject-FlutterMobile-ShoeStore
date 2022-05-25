import 'package:finalprojectmobile/common.dart';
import 'package:finalprojectmobile/constants.dart';
import 'package:finalprojectmobile/models/filter.dart';
import 'package:finalprojectmobile/models/mCategories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../filter/components/body.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  Common _common = new Common();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(AppLocalizations.of(context)!.filter),
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
            ListView.builder(
              shrinkWrap: true,
              itemCount: filterPrice.length,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        (filterPrice[index].price2 != 0 ? _common.formatCurrency(double.parse(
                                    filterPrice[index].price1.toString()))
                                : 'Trên ' +
                                    _common.formatCurrency(double.parse(
                                        filterPrice[index]
                                            .price1
                                            .toString()))) +
                            "-" +
                            (filterPrice[index].price2 != 0
                                ? _common.formatCurrency(double.parse(
                                    filterPrice[index].price2.toString()))
                                : ''),
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 17),
                      ),
                      SizedBox(
                        height: 25,
                        child: Checkbox(
                          value: false,
                          onChanged: (bool? newValue) {},
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            Text(
              "Categories",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: kPrimaryColor),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: filterGender.length,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        demoGender[index].name,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(
                        height: 25,
                        child: Checkbox(
                          value: false,
                          onChanged: (bool? newValue) {},
                        ),
                      )
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
