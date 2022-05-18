
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Rating extends StatelessWidget {
  final int id;
  const Rating({Key? key,required this.id}) : super(key: key);


  @override

  Widget build(BuildContext context) {
    int one=0;
    int two=0;
    int three=0;
    int four=0;
    int five=0;
     FirebaseFirestore.instance.collection('rate').where('productId', isEqualTo: id).where('rate', isEqualTo: 1)..get().then((value) {
       one=value.size;
     });
     FirebaseFirestore.instance.collection('rate').where('productId', isEqualTo: id).where('rate', isEqualTo: 2)..get().then((value) {
       two=value.size;
     });
     FirebaseFirestore.instance.collection('rate').where('productId', isEqualTo: id).where('rate', isEqualTo: 3)..get().then((value) {
       three=value.size;
     });
     FirebaseFirestore.instance.collection('rate').where('productId', isEqualTo: id).where('rate', isEqualTo: 4)..get().then((value) {
       four=value.size;
     });
     FirebaseFirestore.instance.collection('rate').where('productId', isEqualTo: id).where('rate', isEqualTo: 5)..get().then((value) {
       five=value.size;
     });
    return Container(
      margin: EdgeInsets.all(15),
      child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("ĐÁNH GIÁ SẢN PHẨM",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
          SizedBox(height: 8),
          chartRow(context, '5', five),
          chartRow(context, '4', four),
          chartRow(context, '3', three),
          chartRow(context, '2', two),
          chartRow(context, '1', one),
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



