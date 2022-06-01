
import 'mCategories.dart';

class FilterPrice{
  final int? id;
  final double? price1;
  final double? price2;
  FilterPrice({ this.id, this.price1,  this.price2});
}
List<FilterPrice> filterPrice =[
  FilterPrice(id: 0, price1: 0, price2: 500000),
  FilterPrice(id: 1, price1: 500000, price2: 1000000),
  FilterPrice(id: 2, price1: 1000000, price2: 1500000),
  FilterPrice(id: 3, price1: 1500000, price2: 2000000),
  FilterPrice(id: 4, price1: 2000000, price2: 3000000),
  FilterPrice(id: 5, price1: 2000000, price2: 0),
];

List<Gender> filterGender = [
  Gender(id: 0, name: "Male"),
  Gender(id: 1, name: "Female"),
  Gender(id: 2, name: "Kid"),
];