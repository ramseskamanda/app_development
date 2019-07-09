import 'package:provider/provider.dart';
import 'package:studentup/notifiers/authentication_notifier.dart';
import 'package:studentup/ui/ui.dart';
import 'package:studentup/util/enums/login_types.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Router {
  //Default routes
  ///Default Sign Up route, therefore should NOT have a / in front of it
  static const String onboarding = 'onboarding';
  static const String signupRoute = 'signup';
  static const String loginRoute = 'login';
  static const String errorRoute = 'error';
  static const String disclaimer = 'disclaimer';
  //App routes
  ///App-level routes SHOULD have a / in front
  static const String homeRoute = '/app';
  static const String friendsListRoute = '/friends';

  static String initialRoute(BuildContext context) {
    final AuthenticationNotifier auth =
        Provider.of<AuthenticationNotifier>(context);
    final bool signedUp = auth.hasSignedUp;
    final bool signedIn = auth.isLoggedIn;
    return signedUp ? (signedIn ? homeRoute : loginRoute) : signupRoute;
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return PageTransition(
          child: Application(),
          type: PageTransitionType.fade,
        );
      case friendsListRoute:
        return PageTransition(
          child: FriendsList(),
          type: PageTransitionType.downToUp,
        );
      case onboarding:
        return PageTransition(
          child: Onboarding(),
          type: PageTransitionType.fade,
        );
      case signupRoute:
        return PageTransition(
          child: SignUp(),
          type: PageTransitionType.fade,
        );
      case loginRoute:
        return PageTransition(
          child: Login(error: settings.arguments as bool),
          type: PageTransitionType.fade,
        );
      case disclaimer:
        return PageTransition<bool>(
          child: Disclaimer(type: settings.arguments as LoginType),
          type: PageTransitionType.downToUp,
        );
      default:
        return PageTransition(
          child: ErrorScreen(settings: settings),
          type: PageTransitionType.downToUp,
        );
    }
  }
}
