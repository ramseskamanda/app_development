import 'package:ui_dev/notifiers/error_handling/view_error.dart';

class NetworkError extends ViewError {
  NetworkError(String message) : super(message);

  @override
  String toString() {
    return message;
  }
}
