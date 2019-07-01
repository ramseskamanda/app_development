import 'dart:async';

import 'package:studentup/models/firebase_message.dart';
import 'package:rxdart/rxdart.dart';

class NotificationBloc {
  BehaviorSubject<Map<String, dynamic>> _notification =
      BehaviorSubject<Map<String, dynamic>>();

  NotificationBloc();

  Sink<Map<String, dynamic>> get sink => _notification.sink;
  Stream<FirebaseMessage> get stream =>
      _notification.stream.transform(_streamTransformer);

  StreamTransformer<Map<String, dynamic>, FirebaseMessage> _streamTransformer =
      StreamTransformer<Map<String, dynamic>, FirebaseMessage>.fromHandlers(
    handleData: (value, sink) {
      if (value != null) sink.add(FirebaseMessage.fromDoc(value));
    },
    handleError: (Object error, _, EventSink sink) => sink.addError(error),
    handleDone: (sink) => sink.close(),
  );

  void dispose() {
    _notification.close();
  }
}
