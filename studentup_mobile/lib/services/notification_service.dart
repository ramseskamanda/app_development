import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  FirebaseMessaging _firebaseMessaging;
  NotificationService() {
    _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> data) async {
        // ? TODO: do stuff with the navigation here maybe
        print(data);
      },
      onLaunch: (Map<String, dynamic> data) async {
        // ? TODO: do stuff with the navigation here maybe
        print(data);
      },
      onResume: (Map<String, dynamic> data) async {
        // ? TODO: do stuff with the navigation here maybe
        print(data);
      },
    );
  }

  Future test() async {
    print(await _firebaseMessaging.getToken());
  }
}
