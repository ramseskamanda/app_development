import 'package:studentup/routers/base_router.dart';
import 'package:studentup/ui/search/search.dart';
import 'package:studentup/ui/search/search_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SearchRouter extends BaseRouter {
  // Search routes
  /// SearchTab-level routes SHOULD ALWAYS have a '/' in front
  /// That is to mean it's relative to the initial route
  static const String root = '/';
  static const String category = '/category';

  SearchRouter() : super(key: GlobalKey<NavigatorState>());

  @override
  String initialRoute(BuildContext context) => root;

  @override
  Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case root:
        return PageTransition(
          child: SearchTab(),
          type: PageTransitionType.fade,
        );
      case category:
        return PageTransition(
          child: SearchCategoryView(searchCategory: settings.arguments),
          type: PageTransitionType.rightToLeft,
        );
      default:
        return PageTransition(
          child: SearchTab(),
          type: PageTransitionType.downToUp,
        );
    }
  }
}
