import 'package:studentup/bloc/login_form_bloc.dart';
import 'package:studentup/bloc/notification_bloc.dart';
import 'package:studentup/bloc/signup_form_bloc.dart';
import 'package:studentup/services/local_storage_service.dart';
import 'package:studentup/services/messaging_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt();

///Sets up all singletons and services needed in the app's life-cycle:
/// * LocalStorageService
/// * AuthService
/// * EventsService
Future<void> setupLocator() async {
  var instance = await LocalStorageService.getInstance();
  locator.registerSingleton<LocalStorageService>(instance);
  locator.registerSingleton<MessagingService>(MessagingService());

  locator.registerSingleton<NotificationBloc>(NotificationBloc());

  locator.registerFactory(() => SignUpFormBloc());
  locator.registerFactory(() => LoginFormBloc());
}

///Disposes of all services and singletons
///For good practice add all services that use StreamSubscriptions
///and the likes to this method even though it never gets called ¯\\_(ツ)_/¯
void disposeLocatorResources() {
  locator<NotificationBloc>().dispose();
}
