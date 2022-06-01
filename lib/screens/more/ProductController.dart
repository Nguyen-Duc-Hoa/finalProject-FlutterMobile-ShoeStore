import 'package:finalprojectmobile/models/Cart.dart';
import 'package:finalprojectmobile/models/Product.dart';
import 'package:finalprojectmobile/models/voucher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../models/address.dart';

class ProductController extends GetxController {
  RxList<Product> lstCurrentProduct = [].cast<Product>().obs;
  RxList<String> lstName = [].cast<String>().obs;

  setLstCurrentProduct(List<Product> lstProduct){
    //danh sach san pham hien tai khi chon seemore
    lstCurrentProduct = lstProduct.obs;
  }

  setLstName(List<String> lst){
    lstName = lst.obs;
  }



}