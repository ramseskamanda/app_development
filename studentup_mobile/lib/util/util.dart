import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class Util {
  static String formatCount(int count) {
    return count.toString();
  }

  static Future<String> geoPointToLocation(GeoPoint geoPoint) async {
    // if (geoPoint == null) return null;
    // List<Placemark> placemark = await Geolocator()
    //     .placemarkFromCoordinates(geoPoint.latitude, geoPoint.longitude);
    // if (placemark.length > 0)
    //   return '${placemark.first.locality}, ${placemark.first.country}';
    // return null;
    return '';
  }

  static String format(Timestamp date, {bool allowNow = false}) {
    if (date == null) return allowNow ? 'now' : '500 Error';
    var format = DateFormat.yMMM();
    return format.format(date.toDate());
  }

  static String formatHour(DateTime time) {
    if (time == null) return 'Error';
    var format = DateFormat.Hm();
    return format.format(time);
  }

  static Duration getDuration() {
    DateTime now = DateTime.now();

    // Find the last day of the month.
    DateTime lastDayDateTime = (now.month < 12)
        ? DateTime(now.year, now.month + 1, 0)
        : DateTime(now.year + 1, 1, 0);

    return lastDayDateTime.difference(now);
  }
}
