import 'package:provider/provider.dart';
import 'package:studentup/notifiers/authentication_notifier.dart';
import 'package:studentup/notifiers/message_notifier.dart';
import 'package:studentup/notifiers/saved_profiles_notifier.dart';
import 'package:studentup/notifiers/userprofile_notifier.dart';
import 'package:studentup/routers/global_router.dart';

/// Sets up all necessary providers for the application to run smoothly
///   * AuthenticationNotifier
///   * ...
get appWideProviders {
  return <SingleChildCloneableWidget>[
    ChangeNotifierProvider(builder: (_) => AuthenticationNotifier()),
    Provider(builder: (_) => GlobalRouter()),
  ];
}

/// Sets up all providers that need an authenticated user to operate
///   * UserProfileNotifier
///   * SavedProfilesNotifier
///   * ...
get userBasedProviders {
  return <SingleChildCloneableWidget>[
    ChangeNotifierProvider<UserProfileNotifier>(
        builder: (_) => UserProfileNotifier()..initialize()),
    ChangeNotifierProvider<SavedProfilesNotifier>(
        builder: (_) => SavedProfilesNotifier()),
    ChangeNotifierProvider<MessageNotifier>(builder: (_) => MessageNotifier()),
  ];
}
