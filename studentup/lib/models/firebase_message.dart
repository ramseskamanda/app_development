import 'package:studentup/util/enums/notification_types.dart';

class FirebaseMessage {
  Map<String, dynamic> _data;
  NotificationType _type;
  String _id;

  FirebaseMessage.fromDoc(Map<String, dynamic> message) {
    _data = message;
    print(message);
    _type = NotificationType.Event;
    _id = message['event_reference'] as String;
  }

  Map<String, dynamic> get data => _data ?? <String, dynamic>{};
  NotificationType get type => _type ?? NotificationType.Event;
  String get id => _id ?? '';
}
