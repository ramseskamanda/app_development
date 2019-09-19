import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/profile_notifier.dart';
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
    final String fullKey = Locator.of<ProfileNotifier>().info.uid + key;
    return getFromDisk(fullKey);
  }

  Future<void> saveToUserDisk(String key, dynamic content) async {
    final String fullKey = Locator.of<ProfileNotifier>().info.uid + key;
    await saveToDisk(fullKey, content);
  }

  Future<void> saveToDisk(String key, dynamic content) async {
    switch (content.runtimeType) {
      case String:
        await _preferences.setString(key, content);
        break;
      case bool:
        await _preferences.setBool(key, content);
        break;
      default:
        print(
          "[LocalStorage -- Error] : content.runtimeType != String || bool",
        );
        break;
    }
  }
}
