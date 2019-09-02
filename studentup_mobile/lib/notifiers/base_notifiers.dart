import 'package:flutter/material.dart';

class NetworkError extends Error {
  final String message;

  NetworkError({this.message});

  @override
  String toString() {
    return 'NetworkError(message: $message)';
  }
}

abstract class NetworkNotifier extends ChangeNotifier {
  bool _isLoading = false;
  NetworkError _error;

  @protected
  Future fetchData();
  Future onRefresh();

  bool get isLoading => _isLoading ?? false;
  bool get hasError => _error != null ?? true;
  NetworkError get error => _error;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set isLoadingWithoutNotifiers(bool value) => _isLoading = value;

  set error(NetworkError value) {
    _error = value;
    print(value.message);
    notifyListeners();
  }
}
