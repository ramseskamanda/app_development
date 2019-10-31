import 'package:get_it/get_it.dart';
import 'package:ui_dev0/service_models/database/base_database_service.dart';
import 'package:ui_dev0/service_models/database/fake_database.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingleton<BaseDatabaseService>(FakeDatabase());
}
