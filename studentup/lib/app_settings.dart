import 'package:catcher/catcher_plugin.dart';

class Settings {
  static final CatcherOptions debugOptions =
      CatcherOptions(DialogReportMode(), [ConsoleHandler()]);
  static final CatcherOptions releaseOptions = CatcherOptions(
    DialogReportMode(),
    [
      EmailManualHandler(["recipient@email.com"]),
    ],
  );
}
