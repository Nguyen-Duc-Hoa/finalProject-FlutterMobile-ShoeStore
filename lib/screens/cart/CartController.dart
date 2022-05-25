import 'package:finalprojectmobile/models/Cart.dart';
import 'package:finalprojectmobile/models/Product.dart';
import 'package:finalprojectmobile/models/voucher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../models/address.dart';

class CartController extends GetxController {
  RxList<Cart> lstC = [].cast<Cart>().obs;
  RxList<Cart> listOrder = [].cast<Cart>().obs;
  Rx<Voucher> voucher = Voucher().obs;
  Rx<Address> address = Address().obs;
  RxInt numberCart = 0.obs;
  void setListCart(List<Cart> lstCart) {
    lstC = lstCart.obs;
    update();
  }

  void setNumCart(int num){
    numberCart = num.obs;
    update();
  }

  void setVoucher(Voucher item){
    voucher = item.obs;
    update();
  }
  void setAddress(Address item){
    address= item.obs;
    update();
  }

  void resetListOrder() {
    print('reset');
    listOrder = [].cast<Cart>().obs;
    update();
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
    List<Cart> tmpList = listOrder;
    if (listOrder.isEmpty) {
      listOrder.add(cart);
    } else {
      var tmpCart = listOrder
          .where((p) =>
              p.productId == cart.productId &&
              p.userId == cart.userId &&
              p.color == cart.color &&
              p.size == cart.size)
          .toList();
      if (tmpCart.isEmpty) {
        listOrder.add(cart);
      }
    }
    update();
  }

  void removeListOrder(Cart cart) {
    if (listOrder.isNotEmpty) {
      var tmpCart = listOrder
          .where((p) =>
              p.productId == cart.productId &&
              p.userId == cart.userId &&
              p.color == cart.color &&
              p.size == cart.size)
          .toList();
      if (tmpCart.length == 1) {
        listOrder.remove(cart);
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
      total += cart.numOfItem * (cart.product.price*(1-cart.product.disCount/100));
    });
    return double.parse(total.toStringAsFixed(2));
  }

  double totalFinalOrder(List<Cart> lstCart, Rx<Voucher> voucher, double ship){
    double total = 0;
    lstCart.forEach((cart) {
      total += cart.numOfItem * cart.product.price + 30000;
    });
    if(voucher.value.voucherValue != null){
      total = total - int.parse(voucher.value.voucherValue.toString());
    };
    return double.parse(total.toStringAsFixed(2));
  }

  int totalItem(List<Cart> lstCart) {
    int totalitem = lstCart.length;
    return totalitem;
  }

  bool isExist(Cart cart){
    if (listOrder.isNotEmpty){
      var tmpCart = listOrder
          .where((p) =>
      p.productId == cart.productId &&
          p.userId == cart.userId &&
          p.color == cart.color &&
          p.size == cart.size)
          .toList();
      if (tmpCart.length == 1) {
        return true;
      }
    }
    return false;
  }
}
