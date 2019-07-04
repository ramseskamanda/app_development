import 'package:studentup/services/messaging_service.dart';
import 'package:studentup/services/service_locator.dart';
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
}
