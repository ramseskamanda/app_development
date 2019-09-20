import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentup_mobile/services/authentication/base_auth.dart';
import 'package:studentup_mobile/services/locator.dart';

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
    //print('(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }

  dynamic getFromUserDisk(String key) {
    final String fullKey = Locator.of<BaseAuth>().currentUserId + key;
    return getFromDisk(fullKey);
  }

  Future<void> saveToUserDisk(String key, dynamic content) async {
    final String fullKey = Locator.of<BaseAuth>().currentUserId + key;
    await saveToDisk(fullKey, content);
  }

  Future<void> saveToDisk(String key, dynamic content) async {
    if (content is List<String>) {
      await _preferences.setStringList(key, content.cast<String>());
      return;
    }
    switch (content.runtimeType) {
      case String:
        await _preferences.setString(key, content);
        break;
      case bool:
        await _preferences.setBool(key, content);
        break;
      default:
        print("\n===\n");
        print(
          "[LocalStorage -- Error] : content.runtimeType != String || bool\n\nType is: ${content.runtimeType}",
        );
        print("\n===\n");
        break;
    }
  }
}
