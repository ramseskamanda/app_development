import 'package:flutter/material.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/services/storage/local_storage_service.dart';
import 'package:studentup_mobile/util/user_config.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.system;

  ThemeNotifier() {
    _mode =
        _getMode(Locator.of<LocalStorageService>().getFromUserDisk(THEME_KEY));
  }

  ThemeMode get mode => _mode ?? ThemeMode.system;
  set mode(ThemeMode mode) {
    _mode = mode;
    notifyListeners();
  }

  ThemeMode _getMode(String m) {
    switch (m) {
      case 'ThemeMode.dark':
        return ThemeMode.dark;
      case 'ThemeMode.light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }
}
