import 'package:final_project_mobile/models/Cart.dart';
import 'package:final_project_mobile/models/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  RxList<Cart> lstC = [].cast<Cart>().obs;
  RxList<Cart> listOrder = [].cast<Cart>().obs;

  void setListCart(List<Cart> lstCart) {
    lstC = lstCart.obs;
  }

  void resetListOrder() {
    print('reset');
    listOrder = [].cast<Cart>().obs;
  }

  void increaseQuantity(Cart cart) {
    var index = lstC.indexOf(cart);
    lstC[index].numOfItem += 1;
    // lstC.where((p) => p.product.id == cart.product.id).first.numOfItem += 1;
    update();
  }

  void decreaseQuantity(Cart cart) {
    var index = lstC.indexOf(cart);
    if (cart.numOfItem > 1) {
      lstC[index].numOfItem -= 1;
    }
    update();
  }

  void updateQuantity(Cart cart, Product product, int quantity) {
    cart.product = product;
    var index = listOrder.indexOf(cart);
    listOrder[index].numOfItem += quantity;
    update();
  }

  void addListOrder(Cart cart, Product product) {
    cart.product = product;
    if (listOrder.isEmpty) {
      listOrder.add(cart);
    } else {
      Cart tmpCart = listOrder
          .where((p) =>
              p.productId == cart.productId &&
              p.userId == cart.userId &&
              p.color == cart.color &&
              p.size == cart.size)
          .single;
      if (tmpCart.isBlank) {
        listOrder.add(cart);
      }
    }
    update();
  }

  void removeListOrder(Cart cart) {
    if (listOrder.isNotEmpty) {
      Cart tmpCart = listOrder
          .where((p) =>
              p.productId == cart.productId &&
              p.userId == cart.userId &&
              p.color == cart.color &&
              p.size == cart.size)
          .first;
      if (!tmpCart.isBlank) {
        listOrder.remove(tmpCart);
      }
    }
    update();
  }

  void removeAt(int index) {
    lstC.removeAt(index);
    demoCarts.removeAt(index);
    update();
  }

  double totalCart(List<Cart> lstCart) {
    double total = 0;
    lstCart.forEach((cart) {
      total += cart.numOfItem * cart.product.price;
    });
    return double.parse(total.toStringAsFixed(2));
  }

  int totalItem(List<Cart> lstCart) {
    int totalitem = lstCart.length;
    return totalitem;
  }
}
