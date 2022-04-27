import 'package:final_project_mobile/constants.dart';
import 'package:final_project_mobile/screens/home/components/home_header.dart';
import 'package:final_project_mobile/screens/more/components/more_header.dart';
import 'package:flutter/material.dart';

import '../more/components/body.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);


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
        title: Text("Dày thể thao"),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search), color: Colors.white,)
        ],
      ),
      body: Body(),
    );
  }
}
