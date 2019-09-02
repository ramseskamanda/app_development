import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SystemPreferences {
  static Future<void> initialize() async {
    Provider.debugCheckInvalidValueType = null;
    // await SystemChrome.setEnabledSystemUIOverlays([
    //   SystemUiOverlay.top,
    // ]);
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
