import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:studentup_mobile/enum/search_enum.dart';
import 'package:studentup_mobile/models/user_info_model.dart';
import 'package:studentup_mobile/ui/internal_router.dart';
import 'package:studentup_mobile/ui/search/search_category.dart';
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

  double _getSize(int index) => index == 0
      ? 150.0
      : (index == SearchCategory.values.length - 2 ? 250 : 200);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: SearchCategory.values.length,
        itemBuilder: (BuildContext context, int index) =>
            SearchCard(index: index),
        staggeredTileBuilder: (int index) =>
            StaggeredTile.extent(2, _getSize(index)),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    );
  }
}

class SearchCard extends StatelessWidget {
  final int index;

  const SearchCard({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String s =
        SearchCategory.values[index].toString().split('.')[1].toLowerCase();
    final String categoryName = '${s[0].toUpperCase()}${s.substring(1)}';

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) =>
                CategoryScreen(category: SearchCategory.values[index]),
          ),
        );
      },
      child: Stack(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: 'https://via.placeholder.com/50',
            placeholder: (_, url) => Container(
              color: CupertinoColors.lightBackgroundGray,
            ),
            errorWidget: (_, __, error) => Container(
              color: CupertinoColors.lightBackgroundGray,
              child: Center(child: const Icon(Icons.error)),
            ),
            imageBuilder: (_, image) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: image,
                  ),
                ),
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: CupertinoColors.darkBackgroundGray.withOpacity(0.44),
            ),
          ),
          Center(
            child: Text(
              categoryName.toString(),
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
