import 'package:catcher/catcher_plugin.dart';

class DevSettings {
  static final CatcherOptions debugOptions = CatcherOptions(
    DialogReportMode(),
    [ConsoleHandler()],
  );
  static final CatcherOptions releaseOptions = CatcherOptions(
    DialogReportMode(),
    [
      EmailManualHandler(["support@studentup.com"]),
    ],
  );
  static final CatcherOptions profileOptions = CatcherOptions(
    NotificationReportMode(),
    [ConsoleHandler(), ToastHandler()],
    handlerTimeout: 10000,
    customParameters: {"example": "example_parameter"},
  );
}
