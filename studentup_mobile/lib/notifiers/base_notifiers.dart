import 'package:flutter/material.dart';
import 'package:studentup_mobile/services/search/base_search_api.dart';
import 'package:studentup_mobile/services/storage/base_api.dart';
import 'package:studentup_mobile/services/locator.dart';

class NetworkError extends Error {
  final String message;

  NetworkError({this.message});

  @override
  String toString() {
    return 'NetworkError(message: $message)';
  }
}

abstract class BaseNetworkNotifier extends ChangeNotifier {
  bool _isLoading = false;
  NetworkError _error;

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

abstract class NetworkReader extends ChangeNotifier {
  bool _isLoading = false;
  NetworkError _error;

  BaseAPIReader _firestoreReader = Locator.of<BaseAPIReader>();

  Future<void> fetchData();

  BaseAPIReader get reader => _firestoreReader ?? Locator.of<BaseAPIReader>();

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

abstract class NetworkWriter extends ChangeNotifier {
  bool _isLoading = false;
  NetworkError _error;

  BaseAPIWriter _firestoreWriter = Locator.of<BaseAPIWriter>();

  Future<bool> sendData();

  BaseAPIWriter get writer => _firestoreWriter ?? Locator.of<BaseAPIWriter>();

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

abstract class NetworkIO extends ChangeNotifier {
  bool _isReading = false;
  bool _isWriting = false;
  NetworkError _readError;
  NetworkError _writeError;

  var _firestoreReader = Locator.of<BaseAPIReader>();
  var _firestoreWriter = Locator.of<BaseAPIWriter>();

  Future<void> fetchData();
  Future<bool> sendData([dynamic data]);

  BaseAPIReader get reader => _firestoreReader ?? Locator.of<BaseAPIReader>();
  BaseAPIWriter get writer => _firestoreWriter ?? Locator.of<BaseAPIWriter>();

  bool get isLoading => _isReading || _isWriting;
  bool get isReading => _isReading;
  bool get isWriting => _isWriting;
  bool get hasError => _readError != null || _writeError != null;
  bool get hasReadingError => _readError != null;
  bool get hasWritingError => _writeError != null;
  NetworkError get readError => _readError;
  NetworkError get writeError => _writeError;

  set isReading(bool value) {
    _isReading = value;
    notifyListeners();
  }

  set isWriting(bool value) {
    _isReading = value;
    notifyListeners();
  }

  set readError(NetworkError value) {
    _readError = value;
    _isReading = false;
    print(value.message);
    notifyListeners();
  }

  set writeError(NetworkError value) {
    _writeError = value;
    _isWriting = false;
    print(value.message);
    notifyListeners();
  }
}

abstract class NetworkSearch extends ChangeNotifier {
  bool _isLoading = false;
  NetworkError _error;

  BaseSearchAPI _firestoreReader = Locator.of<BaseSearchAPI>();

  Future<void> fetchData();

  BaseSearchAPI get searchEngine =>
      _firestoreReader ?? Locator.of<BaseSearchAPI>();

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
