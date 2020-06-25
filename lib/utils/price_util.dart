import 'package:intl/intl.dart';

class PriceUtil {
  static String format(int price) {
    final oCcy = new NumberFormat("#,##0", "en_US");
    String result = oCcy.format(price);
    return result;
  }
}
