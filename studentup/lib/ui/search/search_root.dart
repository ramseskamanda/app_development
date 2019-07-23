import 'package:flutter/material.dart';
import 'package:studentup/routers/search_router.dart';

class SearchRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Navigator(
        key: GlobalKey<NavigatorState>(),
        onGenerateRoute: SearchRouter.generateRoutes,
        initialRoute: SearchRouter.initialRoute,
      ),
    );
  }
}
