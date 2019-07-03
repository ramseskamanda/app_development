import 'package:provider/provider.dart';
import 'package:studentup/notifiers/authentication_notifier.dart';

/// Sets up all necessary providers for the application to run smoothly
///   * AuthenticationNotifier
///   * ...
setupProviders() {
  return [
    ChangeNotifierProvider(builder: (_) => AuthenticationNotifier()),
  ];
}
