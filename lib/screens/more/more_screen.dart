import 'package:final_project_mobile/constants.dart';
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
      appBar: AppBar(
        title: Text("Dày thể thao", style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        actions: <Widget>[
          MoreHeader()
        ],
        ),
      body: Body(),
    );
  }
}
