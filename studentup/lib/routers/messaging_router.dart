import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:studentup/ui/home/chat_screen/chats.dart';
import 'package:studentup/ui/profile/friends_list.dart';

class MessagingRouter {
  static String get initialRoute => '/';

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/friends':
        return PageTransition(
          child: FriendsList(),
          type: PageTransitionType.rightToLeft,
        );
      default:
        return PageTransition(
          child: Chats(),
          type: PageTransitionType.rightToLeft,
        );
    }
  }
}
