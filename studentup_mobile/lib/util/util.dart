import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:random_color/random_color.dart';

class Util {
  static final RandomColor _randomColor = RandomColor();

  static String formatCount(int count) {
    return count.toString();
  }

  static GeoPoint locationToGeoPoint(String location) {
    // if (geoPoint == null) return null;
    // List<Placemark> placemark = await Geolocator()
    //     .placemarkFromCoordinates(geoPoint.latitude, geoPoint.longitude);
    // if (placemark.length > 0)
    //   return '${placemark.first.locality}, ${placemark.first.country}';
    // return null;
    return GeoPoint(0, 0);
  }

  static String geoPointToLocation(GeoPoint geoPoint) {
    // if (geoPoint == null) return null;
    // List<Placemark> placemark = await Geolocator()
    //     .placemarkFromCoordinates(geoPoint.latitude, geoPoint.longitude);
    // if (placemark.length > 0)
    //   return '${placemark.first.locality}, ${placemark.first.country}';
    // return null;
    return 'Maastricht, Netherlands';
  }

  static String format(Timestamp date, {bool allowNow = false}) {
    if (date == null) return allowNow ? 'now' : 'No Date Given';
    var format = DateFormat.yMMM();
    return format.format(date.toDate());
  }

  static String formatDateTime(
    DateTime date, {
    bool allowNow = false,
    bool deadline = false,
  }) {
    if (date == null) return allowNow ? 'now' : '500 Error';
    var format = deadline ? DateFormat.yMMMd() : DateFormat.yMMM();
    return format.format(date);
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

  static Color getRandomColor() {
    return _randomColor
        .randomColor(colorSaturation: ColorSaturation.random)
        .withOpacity(0.67);
  }

  static Timestamp algoliaTimestamp(Map<String, dynamic> map) =>
      Timestamp(map['_seconds'], map['_nanoseconds']);
}
