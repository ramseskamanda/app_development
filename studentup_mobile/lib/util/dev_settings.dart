import 'package:catcher/catcher_plugin.dart';

class DevSettings {
  static final CatcherOptions debugOptions = CatcherOptions(
    DialogReportMode(),
    [ConsoleHandler()],
  );
  static final CatcherOptions releaseOptions = CatcherOptions(
    DialogReportMode(),
    [
      EmailManualHandler(
        ["rkamanda@studentup.com"],
        emailTitle: 'Bug Report From Studentup Mobile Application',
        emailHeader: 'I found a bug in your application',
      ),
    ],
  );
  static final CatcherOptions profileOptions = CatcherOptions(
    NotificationReportMode(),
    [ConsoleHandler(), ToastHandler()],
    handlerTimeout: 10000,
  );
}
