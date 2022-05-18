
import "package:intl/intl.dart";
import 'dart:math';

class Common{
  String formatCurrency(double price){
    return NumberFormat.currency(locale: 'vi').format(price);
  }

  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}