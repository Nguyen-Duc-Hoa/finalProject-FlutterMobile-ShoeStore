
import "package:intl/intl.dart";

class Common{
  String formatCurrency(double price){
    return NumberFormat.currency(locale: 'vi').format(price);
  }
}