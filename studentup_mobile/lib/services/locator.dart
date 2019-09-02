import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/notifiers/auth_notifier.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/profile_notifier.dart';
import 'package:studentup_mobile/services/algolia_service.dart';
import 'package:studentup_mobile/services/analytics_service.dart';
import 'package:studentup_mobile/services/auth_service.dart';
import 'package:studentup_mobile/services/firestore_service.dart';
import 'package:studentup_mobile/services/local_storage_service.dart';
import 'package:studentup_mobile/services/notification_service.dart';

class Locator {
  @protected
  static final GetIt _locator = GetIt();

  static List<SingleChildCloneableWidget> get providers {
    return [
      ChangeNotifierProvider(builder: (_) => AuthNotifier()),
    ];
  }

  static Future<void> setup() async {
    var instance = await LocalStorageService.getInstance();
    _locator.registerSingleton<LocalStorageService>(instance);
    _locator.registerSingleton<AuthService>(AuthService());
    _locator.registerSingleton<NotificationService>(NotificationService());
    _locator.registerSingleton<AnalyticsService>(AnalyticsService());
    _locator.registerSingleton(FirestoreReader());
    _locator.registerSingleton(FirestoreWriter());
    _locator.registerSingleton(AlgoliaService());
    _locator.registerSingleton(ProfileNotifier());
  }

  static T of<T>() => _locator.get<T>();
}
