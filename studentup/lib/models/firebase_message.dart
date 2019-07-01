import 'package:studentup/util/message_type.dart';

class FirebaseMessage {
  Map<String, dynamic> _data;
  MessageType _type;
  String _id;

  FirebaseMessage.fromDoc(Map<String, dynamic> message) {
    _data = message;
    print(message);
    _type = MessageType.Event;
    _id = message['event_reference'] as String;
  }

  Map<String, dynamic> get data => _data ?? <String, dynamic>{};
  MessageType get type => _type ?? MessageType.Event;
  String get id => _id ?? '';
}
