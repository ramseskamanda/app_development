import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/notifiers/auth_notifier.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/profile_notifier.dart';
import 'package:studentup_mobile/router.dart';
import 'package:studentup_mobile/services/search/algolia_service.dart';
import 'package:studentup_mobile/services/analytics/analytics_service.dart';
import 'package:studentup_mobile/services/authentication/auth_service.dart';
import 'package:studentup_mobile/services/connectivity_service.dart';
import 'package:studentup_mobile/services/search/base_search_api.dart';
import 'package:studentup_mobile/services/storage/base_api.dart';
import 'package:studentup_mobile/services/storage/firebase/firebase_storage.dart';
import 'package:studentup_mobile/services/storage/firebase/firestore_reader.dart';
import 'package:studentup_mobile/services/storage/firebase/firestore_writer.dart';
import 'package:studentup_mobile/services/storage/local_storage_service.dart';
import 'package:studentup_mobile/services/notifications/notification_service.dart';

class Locator {
  @protected
  static final GetIt _locator = GetIt();

  static List<SingleChildCloneableWidget> get providers {
    return [
      ChangeNotifierProvider(builder: (_) => AuthNotifier()),
      Provider(
        builder: (_) => InnerRouter(),
        dispose: (_, InnerRouter instance) => instance.dispose(),
      ),
      StreamProvider(
        builder: (_) => ConnectivityService().connectionStatusController.stream,
        updateShouldNotify: (a, b) => a != b,
      ),
    ];
  }

  static Future<void> setup() async {
    var instance = await LocalStorageService.getInstance();
    _locator.registerSingleton<LocalStorageService>(instance);
    _locator.registerSingleton<AuthService>(AuthService());
    _locator.registerSingleton<NotificationService>(NotificationService());
    _locator.registerSingleton<AnalyticsService>(AnalyticsService());
    _locator.registerSingleton<BaseAPIReader>(FirestoreReader());
    _locator.registerSingleton<BaseAPIWriter>(FirestoreWriter());
    _locator.registerSingleton(FirebaseStorageService());
    _locator.registerSingleton<BaseSearchAPI>(AlgoliaService());
    _locator.registerSingleton<ProfileNotifier>(ProfileNotifier());
  }

  static T of<T>() => _locator.get<T>();
}
