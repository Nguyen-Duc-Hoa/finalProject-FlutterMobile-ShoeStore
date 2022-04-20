import 'package:final_project_mobile/models/Product.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Rx<Product> productDetail = Product(id: 0, images: [], colors: [], title: '', price: 0.00, description: '').obs;

  // ignore: non_constant_identifier_names
  void SetProductDetail( Rx<Product> product){
    productDetail = product;
  }
}