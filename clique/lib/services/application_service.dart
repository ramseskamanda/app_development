import 'package:clique/services/messaging_service.dart';
import 'package:clique/services/service_locator.dart';
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
  locator<MessagingService>().setupMessagingService();
  //TODO: add a check to see the firebaseMessaging token vs firestore token
}
