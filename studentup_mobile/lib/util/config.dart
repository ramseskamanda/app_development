import 'package:flutter/material.dart';

const SIGNUP_STORAGE_KEY = '_signupKey';
const HEADER_LOGO_HERO_TAG = '_heroLogo';
const NUM_ITEM_PREVIEW = 8;
const NUM_ITEM_LIST = 20;

const defaultImageUrl =
    'https://firebasestorage.googleapis.com/v0/b/studentup-nl.appspot.com/o/default_files%2Fblack-and-white-black-and-white-rough-978503.jpg?alt=media&token=8cba65e5-d0c1-4828-9c25-ad66836ee658';

const List<String> rulesUser = <String>[
  'Only during the next 24 hours, you can ...',
  'Hand in your masterpiece before the deadline.',
  'Handing in no, an incomplete, or inappropriate work will get you disqualified',
  'If your did your best but didn\'t win, keep a smile on',
  'Badges, certificates, and XP will be distributed at the end of the Project',
  'The Project holder can use anything you include in your answer as their own.',
];

const List<String> rulesCompanies = <String>[
  'Only during the next 24 hours, you can ...',
  'Hand in your masterpiece before the deadline.',
  'Handing in no, an incomplete, or inappropriate work will get you disqualified',
];

const List<IconData> iconsUser = <IconData>[
  Icons.timer,
  Icons.hourglass_full,
  Icons.import_contacts,
  Icons.person_outline,
  Icons.http,
  Icons.info_outline,
];

const List<IconData> iconsCompanies = <IconData>[
  Icons.timer,
  Icons.hourglass_full,
  Icons.import_contacts,
];

const String termsAndConditions = 'TERMS AND CONDITIONS / PRIVACY POLICY';
