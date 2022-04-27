import 'package:final_project_mobile/models/Cart.dart';
import 'package:get/get.dart';

class CartController extends GetxController{
  RxList<Cart> lstC = demoCarts.obs;
  RxList<Cart> listOrder = [].cast<Cart>().obs;

  void resetListOrder(){
    listOrder = [].cast<Cart>().obs;
  }

  void increaseQuantity(Cart cart){
    var index = lstC.indexOf(cart);
    lstC[index].numOfItem += 1;
    // lstC.where((p) => p.product.id == cart.product.id).first.numOfItem += 1;
    update();
  }

  void decreaseQuantity(Cart cart){
    var index = lstC.indexOf(cart);
    if(cart.numOfItem > 1){
      lstC[index].numOfItem -= 1;
    }
    update();
  }

  void addListOrder(Cart cart){
    var index = listOrder.indexOf(cart);
    if(index == -1){
      listOrder.add(cart);
    }
    update();
  }

  void removeListOrder(Cart cart){
    var index = listOrder.indexOf(cart);
    if(index != -1){
      listOrder.remove(cart);
    }
    update();
  }

  void removeAt(int index){
    lstC.removeAt(index);
    demoCarts.removeAt(index);
    update();
  }

  double totalCart(List<Cart> lstCart){
    double total = 0;
    lstCart.forEach((product) {
      total += product.numOfItem * product.product.price;
    });
    return double.parse(total.toStringAsFixed(2));
  }

  int totalItem(List<Cart> lstCart){
    int totalitem = lstCart.length;
    return totalitem;
  }
}