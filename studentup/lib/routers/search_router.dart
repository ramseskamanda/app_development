import 'package:studentup/ui/search/search.dart';
import 'package:studentup/ui/search/search_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SearchRouter {
  // Search routes
  /// SearchTab-level routes SHOULD ALWAYS have a '/' in front
  /// That is to mean it's relative to the initial route
  static const String root = '/';
  static const String category = '/category';

  static String get initialRoute => root;

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case root:
        return PageTransition(
          child: SearchTab(),
          type: PageTransitionType.fade,
        );
      case category:
        return PageTransition(
          child: CategoryScreen(category: settings.arguments),
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
