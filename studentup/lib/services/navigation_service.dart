import 'package:catcher/core/catcher.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:studentup/ui/profile/friends_list.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> messagingNavigator =
      GlobalKey<NavigatorState>();

  static get globalNavigator => Catcher.navigatorKey;

  static Route<dynamic> generateMessagingRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/friends':
        return PageTransition(
          child: FriendsList(),
          type: PageTransitionType.rightToLeft,
        );
      default:
        return PageTransition(
          child: FriendsList(),
          type: PageTransitionType.rightToLeft,
        );
    }
  }
}
