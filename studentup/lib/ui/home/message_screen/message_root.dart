import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:studentup/routers/messaging_router.dart';
import 'package:studentup/util/env.dart';

class MessagingRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PageController controller = Provider.of<PageController>(context);
    return WillPopScope(
      onWillPop: () async {
        await controller.animateToPage(
          controller.initialPage,
          duration: Environment.pageTransitionDuration,
          curve: Environment.pageTransitionCurve,
        );
        return false;
      },
      child: Navigator(
        key: MessagingRouter.key,
        onGenerateRoute: MessagingRouter.generateRoutes,
        initialRoute: MessagingRouter.initialRoute,
      ),
    );
  }
}
