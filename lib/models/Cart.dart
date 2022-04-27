
import 'package:flutter/material.dart';

import 'Product.dart';

class Cart {
  final Product product;
  final int numOfItem;
final int size;
final Color color;
  Cart({required this.product, required this.numOfItem,required this.size,required this.color});
}

// Demo data for our cart

List<Cart> demoCarts = [
  Cart(product: demoProducts[0], numOfItem: 2,size: 37,color: Color(0xFFF6625E)),
  Cart(product: demoProducts[1], numOfItem: 1,size: 39,color: Color(0xFFF6625E)),
  Cart(product: demoProducts[3], numOfItem: 1,size: 38,color: Color(0xFFDECB9C)),
];
