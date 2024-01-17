import 'package:intl/intl.dart';

class Formatter {
  static String formatPrice(num price) {
    final numberFormat = NumberFormat("₹ #,##,###");
    return numberFormat.format(price);
  }

  static String formatDateWithTime(DateTime date) {
    DateTime localDate = date.toLocal();
    final dateFormat = DateFormat("dd MMM y, hh:mm a");
    return dateFormat.format(localDate);
  }

  static String formatDate(DateTime date) {
    DateTime localDate = date.toLocal();
    final dateFormat = DateFormat("dd MMM y");
    return dateFormat.format(localDate);
  }
}
