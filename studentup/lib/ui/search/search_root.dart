import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup/routers/search_router.dart';

class SearchRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SearchRouter router = SearchRouter();
    return WillPopScope(
      onWillPop: () async => false,
      child: Provider<SearchRouter>.value(
        value: router,
        child: Navigator(
          key: router.key,
          onGenerateRoute: router.generateRoutes,
          initialRoute: router.initialRoute(context),
        ),
      ),
    );
  }
}
