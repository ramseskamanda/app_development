import 'package:flutter/material.dart';

const PRIVACY_POLICY_URL = 'https://studentup.com/products-privacy-policy.html';
const TERMS_OF_USE_URL = 'https://studentup.com/terms-of-use.html';

const SIGNUP_STORAGE_KEY = '_signupKey';
const HEADER_LOGO_HERO_TAG = '_heroLogo';
const ACCOUNTS_LIST = 'user_accounts';
const NUM_ITEM_PREVIEW = 8;
const NUM_ITEM_LIST = 20;

const defaultImageUrl =
    'https://studentup-e62de.firebaseapp.com/default-profile.png';
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

const String termsAndConditions =
    'All users must accept the Terms of Use and Privacy Policy to use our app'
    'Do read the documents as they outline the rules to follow as a user and the laws protecting you and your data.';
