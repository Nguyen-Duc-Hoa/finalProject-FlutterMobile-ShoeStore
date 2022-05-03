

import 'dart:ffi';
import 'package:flutter/cupertino.dart';

import 'Product.dart';

class Cart {
  final Product product;
  late int numOfItem;
  final int size;
  late Color color;
  Cart({required this.product, required this.numOfItem,required this.size, required this.color});
}

void IncreaseQuantity(Cart cart){
  var index = demoCarts.indexOf(cart);
  demoCarts[index].numOfItem += 1;
}

void DecreaseQuantity(Cart cart){
  var index = demoCarts.indexOf(cart);
  if(cart.numOfItem > 1){
    demoCarts[index].numOfItem -= 1;
  }
}

double TotalCart(List<Cart> lstCart){
  double total = 0;
  lstCart.forEach((product) {
    total += product.numOfItem * product.product.price;
  });
  return total;
}

int totalItem(List<Cart> lstCart){
  int totalitem = 0;
  lstCart.forEach((product) {
    totalitem += product.numOfItem;
  });
  return totalitem;
}
// Demo data for our cart

List<Cart> demoCarts = [
  Cart(product: demoProducts[0], numOfItem: 2,size: 37,color: Color(0xFFF6625E)),
  Cart(product: demoProducts[1], numOfItem: 1,size: 39,color: Color(0xFFF6625E)),
  Cart(product: demoProducts[3], numOfItem: 1,size: 38,color: Color(0xFFDECB9C)),
];
