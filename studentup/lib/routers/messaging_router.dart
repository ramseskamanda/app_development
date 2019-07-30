import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:studentup/ui/home/chat_screen/chats.dart';

class MessagingRouter {
  static String get initialRoute => '/';

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      default:
        return PageTransition(
          child: Chats(),
          type: PageTransitionType.rightToLeft,
        );
    }
  }
}
