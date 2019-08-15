import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/notifiers/auth_notifier.dart';
import 'package:studentup_mobile/services/auth_service.dart';
import 'package:studentup_mobile/services/local_storage_service.dart';

class Locator {
  @protected
  static final GetIt locator = GetIt();

  static List<SingleChildCloneableWidget> get providers {
    return [
      ChangeNotifierProvider(builder: (_) => AuthNotifier()),
    ];
  }

  static Future<void> setup() async {
    var instance = await LocalStorageService.getInstance();
    locator.registerSingleton<LocalStorageService>(instance);
    locator.registerSingleton<AuthService>(AuthService());
  }

  static T of<T>() => locator.get<T>();
}
