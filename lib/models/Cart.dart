
import 'dart:ffi';

import 'Product.dart';

class Cart {
  final Product product;
  late int numOfItem;

  Cart({required this.product, required this.numOfItem});
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
  Cart(product: demoProducts[0], numOfItem: 2),
  Cart(product: demoProducts[1], numOfItem: 1),
  Cart(product: demoProducts[3], numOfItem: 1),
];
