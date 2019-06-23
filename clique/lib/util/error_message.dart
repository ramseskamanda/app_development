import 'package:meta/meta.dart';

class ErrorMessage {
  final String _code;
  final String _details;
  final String _stack;
  final ErrorImportance _importance;
  const ErrorMessage({
    @required String code,
    String details,
    String stack,
    @required ErrorImportance importance,
  })  : _code = code,
        _details = details,
        _stack = stack,
        _importance = importance;

  String get code => _code;
  String get details => _details ?? 'No details provided.';
  String get stack => _stack ?? 'No stack provided...';
  ErrorImportance get importance => _importance;

  @override
  String toString() {
    return '[ErrorMessage -- $importance -- code: $code, details: $details]'
        'Stack: ($stack)';
  }
}

enum ErrorImportance { none, medium, fatal }
