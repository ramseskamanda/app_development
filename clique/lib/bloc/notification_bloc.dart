import 'package:rxdart/rxdart.dart';

class NotificationBloc {
  BehaviorSubject<String> _notification = BehaviorSubject<String>();

  NotificationBloc();

  Sink<String> get sink => _notification.sink;
  Stream<String> get stream => _notification.stream;

  void dispose() {
    _notification.close();
  }
}
