
import "package:intl/intl.dart";

class Common{
  String formatCurrency(double price){
    return NumberFormat.currency(locale: 'vi').format(price);
  }
  String? validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    }
    else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }
}