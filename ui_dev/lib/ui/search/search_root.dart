import 'package:flutter/material.dart';
import 'package:ui_dev/ui/search/search.dart';

class SearchRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SearchTab();
  }
}

/*
WillPopScope(
  onWillPop: () async => false,
  child: Navigator(
    key: GlobalKey<NavigatorState>(),
    onGenerateRoute: SearchRouter.generateRoutes,
    initialRoute: SearchRouter.initialRoute,
  ),
);
*/
