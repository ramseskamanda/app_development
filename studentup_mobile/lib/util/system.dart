import 'package:flutter/services.dart';

class SystemPreferences {
  static Future<void> initialize() async {
    await SystemChrome.setEnabledSystemUIOverlays([
      SystemUiOverlay.top,
    ]);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // await SystemChrome.setApplicationSwitcherDescription(
    //   ApplicationSwitcherDescription(
    //     label: 'Studentup',
    //   ),
    // );
  }
}
