import 'package:flutter/cupertino.dart';
import 'package:studentup/services/navigation_service.dart';
import 'package:studentup/ui/home/message_screen/message_list.dart';

class MessagingRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      navigatorKey: NavigationService.messagingNavigator,
      onGenerateRoute: NavigationService.generateMessagingRoutes,
      builder: (context) => MessagesList(),
    );
  }
}
