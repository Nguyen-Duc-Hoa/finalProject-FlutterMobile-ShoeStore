import 'package:finalprojectmobile/models/Product.dart';
import 'package:finalprojectmobile/screens/home/components/categories.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<Categories> lstCategory = [].cast<Categories>().obs;

  Rx<Product> productDetail = Product(
      id: 0,
      images: [],
      colors: [],
      title: '',
      price: 0.00,
      description: '',
      disCount: 0,
      gender: 0,
      size: []).obs;

  // ignore: non_constant_identifier_names
  void SetProductDetail(Rx<Product> product) {
    productDetail = product;
  }

  RxList<String> lstImage = [].cast<String>().obs;

  void SetListImage(Product product, int startIndex) {
    List<String> lstImage = [];
    for (int i = startIndex;
        i < startIndex + 5 && i < product.images.length;
        i++) {
      lstImage.add(product.images[i]);
    }
    this.lstImage = lstImage.obs;
    update();
  }

  void setListCategory( List<Categories> lstcategory){
    lstCategory = lstcategory.obs;
    update();
  }

  RxInt indexSelectedColor = 0.obs;

  void ChangeColor(RxInt indexOfSelectedColor) {
    indexSelectedColor = indexOfSelectedColor;
    update();
  }
}
