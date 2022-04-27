import 'package:final_project_mobile/screens/home/components/home_header.dart';
import 'package:flutter/material.dart';

import '../favorite/components/body.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height + 5),
        child: Padding(
          padding: const EdgeInsets.only(top: 25.0, bottom: 15.0),
          child: HomeHeader(),
        ),
      ),
      body: Body(),
    );
  }
}
