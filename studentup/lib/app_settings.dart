import 'package:catcher/catcher_plugin.dart';

class Settings {
  static final CatcherOptions debugOptions =
      CatcherOptions(DialogReportMode(), [
    ConsoleHandler(
      enableApplicationParameters: false,
      enableCustomParameters: false,
      enableDeviceParameters: false,
      enableStackTrace: true,
    )
  ]);
  static final CatcherOptions releaseOptions = CatcherOptions(
    DialogReportMode(),
    [
      EmailManualHandler(["recipient@email.com"]),
    ],
  );
}
