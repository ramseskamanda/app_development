import 'package:jiffy/jiffy.dart';

class DateTimeUtils {
  static formatDateTime(DateTime dateTime) {
    return Jiffy(dateTime).format("MMM dd, HH:mm");
  }
}
