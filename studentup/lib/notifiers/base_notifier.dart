import 'package:flutter/material.dart';

class BaseNotifier with ChangeNotifier {
  bool _isLoading = false;
  get isLoading => _isLoading;
  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  Object _error;
  bool _hasError = false;
  get hasError => _hasError;
  get error => _error;
  set error(value) {
    _error = value;
    _hasError = true;
    notifyListeners();
  }
}
