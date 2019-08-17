import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:studentup_mobile/models/user_info_model.dart';
import 'package:studentup_mobile/ui/internal_router.dart';
import 'package:studentup_mobile/ui/search/search_screen_delegate.dart';
// import 'package:studentup_mobile/ui/search/search.dart';

class SearchRoot extends Router {
  static const String home = '/';
  static const String category = '/category';

  SearchRoot() : super(home: home);

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return PageRouteBuilder(
          pageBuilder: (c, a1, a2) => SearchTab(),
          transitionsBuilder: (c, anim, a2, child) => child,
        );
      case category:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: Scaffold(),
        );
      default:
        return PageRouteBuilder(
          pageBuilder: (c, a1, a2) => SearchTab(),
          transitionsBuilder: (c, anim, a2, child) => child,
        );
    }
  }

  @override
  Route<dynamic> onErrorRoute(RouteSettings settings) {
    return PageTransition(
      type: PageTransitionType.upToDown,
      child: Scaffold(
        body: Center(
          child: const Text('Page Not Found'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => super.build(context);
}

class SearchTab extends StatelessWidget {
  Future<void> _onSearch(BuildContext context) async {
    UserInfoModel result = await showSearch<UserInfoModel>(
      context: context,
      delegate: SearchScreenDelegate(),
    );
    print(result?.givenName ?? 'None chosen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: const Text('Search'),
          onPressed: () => _onSearch(context),
        ),
      ),
    );
  }
}
