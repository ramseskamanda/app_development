import 'package:flutter/material.dart';
import 'package:ui_dev/notifiers/error_handling/view_error.dart';

abstract class ViewNotifier extends ChangeNotifier {
  bool _isLoading = false;
  ViewError _error;

  Future fetchData([dynamic data]);
  Future onRefresh();

  bool get isLoading => _isLoading ?? false;
  bool get hasError => _error != null ?? true;
  ViewError get error => _error;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set error(ViewError value) {
    _error = value;
    notifyListeners();
  }
}
