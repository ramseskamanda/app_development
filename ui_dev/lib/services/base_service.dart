import 'package:flutter/material.dart';

abstract class BaseService extends ChangeNotifier {
  bool _isLoading;
  Error _error;

  @mustCallSuper
  BaseService() {
    _isLoading = false;
    _error = null;
  }

  bool get isLoading => _isLoading ?? false;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get hasError => _error != null;
  Error get error => _error;
  set error(Error value) {
    _error = value;
    notifyListeners();
  }
}
