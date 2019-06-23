import 'dart:io';

class MessagingService {
  //Object _firebaseMessaging;

  MessagingService() {
    //_firebaseMessaging = null;
    print("(TRACE) MessagingService is being created...");
  }

  Future<String> get deviceToken async =>
      'testToken'; //_firebaseMessaging.getToken()

  void setupMessagingService() {
    if (Platform.isIOS) _iOSPersmissionsRequest();

    /* _firebaseMessaging.getToken().then((token) {
      print(token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    ); */
  }

  void _iOSPersmissionsRequest() {
    print('[Requesting iOS Notification Permissions] - started');
    /* _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    }); */
  }
}
