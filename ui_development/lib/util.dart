import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime) {
  DateFormat dateFormat = DateFormat("MMM dd, HH:mm");
  // return DateFormat.MMMEd().format(dateTime);
  return dateFormat.format(dateTime);
}
