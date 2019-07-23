import 'package:flutter/material.dart';

class TestData {
  static final bool isSignedUp = false;

  static final List<String> rules = <String>[
    'Only during the next 24 hours, you can ...',
    'Hand in your masterpiece before the deadline.',
    'Handing in no, an incomplete, or inappropriate work will get you disqualified',
    'If your did your best but didn\'t win, keep a smile on',
    'Badges, certificates, and XP will be distributed at the end of the competition',
    'The competition holder can use anything you include in your answer as their own.',
  ];

  static final List<IconData> icons = <IconData>[
    Icons.timer,
    Icons.hourglass_full,
    Icons.import_contacts,
    Icons.person_outline,
    Icons.http,
    Icons.info_outline,
  ];
}
