import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:studentup/ui/home/message_screen/message_list.dart';
import 'package:studentup/ui/profile/friends_list.dart';

class MessagingRouter {
  static final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  static final String initialRoute = '/';

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/friends':
        return PageTransition(
          child: FriendsList(),
          type: PageTransitionType.rightToLeft,
        );
      default:
        return PageTransition(
          child: MessagesList(),
          type: PageTransitionType.rightToLeft,
        );
    }
  }
}
