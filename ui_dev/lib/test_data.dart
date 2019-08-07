import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TestData {
  static final bool isSignedUp = false;
  static final String userId = 'sYP0IBARJtdYj9apnwYD';
  static final String projectId = '1sBtrLEZXIlNkxD8QOPn';

  static final List<String> rulesUser = <String>[
    'Only during the next 24 hours, you can ...',
    'Hand in your masterpiece before the deadline.',
    'Handing in no, an incomplete, or inappropriate work will get you disqualified',
    'If your did your best but didn\'t win, keep a smile on',
    'Badges, certificates, and XP will be distributed at the end of the Project',
    'The Project holder can use anything you include in your answer as their own.',
  ];

  static final List<String> rulesCompanies = <String>[
    'Only during the next 24 hours, you can ...',
    'Hand in your masterpiece before the deadline.',
    'Handing in no, an incomplete, or inappropriate work will get you disqualified',
  ];

  static final List<IconData> iconsUser = <IconData>[
    Icons.timer,
    Icons.hourglass_full,
    Icons.import_contacts,
    Icons.person_outline,
    Icons.http,
    Icons.info_outline,
  ];

  static final List<IconData> iconsCompanies = <IconData>[
    Icons.timer,
    Icons.hourglass_full,
    Icons.import_contacts,
  ];

  static final String randomPicture = 'https://picsum.photos/200';

  static String geoPointToLocation(GeoPoint geoPoint) {
    // ! TODO: write a function that transforms a geopoint into a string location
    return 'Maastricht, Netherlands';
  }

  static String format(Timestamp date, {bool allowNow = false}) {
    if (date == null) return allowNow ? 'now' : '404 Error';
    var format = DateFormat.yMMM();
    return format.format(date.toDate());
  }

  static String formatHour(DateTime time) {
    if (time == null) return 'Error';
    var format = DateFormat.Hm();
    return format.format(time);
  }
}
