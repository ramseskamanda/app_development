import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/enum/connectivity_status.dart';
import 'package:studentup_mobile/notifiers/theme_notifier.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/profile_notifier.dart';
import 'package:studentup_mobile/router.dart';
import 'package:studentup_mobile/services/search/algolia_service.dart';
import 'package:studentup_mobile/services/analytics/analytics_service.dart';
import 'package:studentup_mobile/services/connectivity_service.dart';
import 'package:studentup_mobile/services/search/base_search_api.dart';
import 'package:studentup_mobile/services/storage/base_api.dart';
import 'package:studentup_mobile/services/storage/base_file_storage_api.dart';
import 'package:studentup_mobile/services/storage/firebase/firebase_storage.dart';
import 'package:studentup_mobile/services/storage/firebase/firestore_reader.dart';
import 'package:studentup_mobile/services/storage/firebase/firestore_writer.dart';
import 'package:studentup_mobile/services/storage/local_storage_service.dart';
import 'package:studentup_mobile/services/notifications/notification_service.dart';
import 'package:studentup_mobile/services/web_service.dart';

import 'authentication/base_auth.dart';

class Locator {
  @protected
  static final GetIt _locator = GetIt();

  static List<SingleChildCloneableWidget> get providers {
    print('Setting Up App Wide Providers...');
    return [
      Provider(
        builder: (_) => InnerRouter(
            initialNavBarTab: _locator<NotificationService>().initialRoute),
        dispose: (_, InnerRouter instance) => instance.dispose(),
      ),
      StreamProvider<ConnectivityStatus>(
        builder: (_) => ConnectivityService().connectionStatusController.stream,
        updateShouldNotify: (a, b) => true,
      ),
      StreamProvider<ProfileNotifier>(
        builder: (_) => Locator.of<BaseAuth>().subject,
        catchError: (_, err) => null,
        updateShouldNotify: (a, b) => true,
      ),
    ];
  }

  static List<SingleChildCloneableWidget> get userProviders {
    print('Setting Up User Specific Providers...');
    return [
      ChangeNotifierProvider<ThemeNotifier>(builder: (_) => ThemeNotifier()),
    ];
  }

  static Future<void> setup() async {
    var instance = await LocalStorageService.getInstance();
    _locator.registerSingleton<LocalStorageService>(instance);
    _locator.registerSingleton<BaseAuth>(FirebaseAuthService());
    _locator.registerSingleton<NotificationService>(NotificationService());
    _locator.registerSingleton<AnalyticsService>(AnalyticsService());
    _locator.registerSingleton<BaseAPIReader>(FirestoreReader());
    _locator.registerSingleton<BaseAPIWriter>(FirestoreWriter());
    _locator.registerSingleton<BaseFileStorageAPI>(FirebaseStorageService());
    _locator.registerSingleton<BaseSearchAPI>(AlgoliaService());
    _locator.registerSingleton<WebService>(WebService());
  }

  static T of<T>() => _locator.get<T>();
}
