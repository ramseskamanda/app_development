import 'package:flutter/services.dart';

///Sets up all the necessities of a mobile app like:
/// * Preferred Device Orientation
/// * Connectivity (???)
/// * etc.
Future<void> setupApplicationSettings() async {
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  //TODO: add a check to see the firebaseMessaging token vs firestore token
}
