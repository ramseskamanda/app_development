import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static LocalStorageService _instance;
  static SharedPreferences _preferences;

  static Future<LocalStorageService> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance;
  }

  dynamic getFromDisk(String key) {
    var value = _preferences.get(key);
    print('(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }

  void saveToDisk(String key, dynamic content) {
    switch (content.runtimeType) {
      case String:
        _preferences.setString(key, content);
        break;
      case bool:
        _preferences.setBool(key, content);
        break;
      default:
        print(
          "[LocalStorage -- Error] : content.runtimeType != String || bool",
        );
        break;
    }
  }
}
