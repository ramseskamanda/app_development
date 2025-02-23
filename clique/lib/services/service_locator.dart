import 'package:clique/bloc/login_form_bloc.dart';
import 'package:clique/bloc/notification_bloc.dart';
import 'package:clique/bloc/signup_form_bloc.dart';
import 'package:clique/services/authentication_service.dart';
import 'package:clique/services/events_service.dart';
import 'package:clique/services/friends_manager_service.dart';
import 'package:clique/services/local_storage_service.dart';
import 'package:clique/services/location_service.dart';
import 'package:clique/services/market_service.dart';
import 'package:clique/services/messaging_service.dart';
import 'package:clique/services/user_service.dart';
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
  locator.registerSingleton<GeoLocationService>(GeoLocationService());
  locator.registerSingleton<AuthService>(AuthService());
  locator.registerSingleton<EventsService>(EventsService());
  locator.registerSingleton<MarketService>(MarketService());
  locator.registerFactory<FriendsManagerService>(() => FriendsManagerService());
  locator.registerSingleton<UserService>(UserService());

  locator.registerSingleton<NotificationBloc>(NotificationBloc());

  locator.registerFactory(() => SignUpFormBloc());
  locator.registerFactory(() => LoginFormBloc());
}

///Disposes of all services and singletons
///For good practice add all services that use StreamSubscriptions
///and the likes to this method even though it never gets called ¯\\_(ツ)_/¯
void disposeLocatorResources() {
  locator<AuthService>().dispose();
  locator<NotificationBloc>().dispose();
}
