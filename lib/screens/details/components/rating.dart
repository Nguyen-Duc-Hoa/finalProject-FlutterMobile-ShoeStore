import 'package:flutter/material.dart';
class Rating extends StatefulWidget {
  const Rating({Key? key}) : super(key: key);

  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("ĐÁNH GIÁ SẢN PHẨM",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
          SizedBox(height: 8),
          chartRow(context, '5', 89),
          chartRow(context, '4', 8),
          chartRow(context, '3', 2),
          chartRow(context, '2', 1),
          chartRow(context, '1', 0),
          SizedBox(height: 8),
        ],
      ),
    );
  }
  Widget chartRow(BuildContext context, String label, int pct) {
    return Row(
      children: [
        Text(label),
        SizedBox(width: 8),
        Icon(Icons.star, color:Colors.orange),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
          child:
          Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Text(''),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * (pct/100) * 0.7,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Text(''),
                ),
              ]

          ),
        ),

      ],
    );
  }
}
