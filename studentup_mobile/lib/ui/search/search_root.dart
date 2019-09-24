import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:studentup_mobile/enum/search_enum.dart';
import 'package:studentup_mobile/ui/inner_drawer/inner_drawer.dart';
import 'package:studentup_mobile/ui/search/search_category.dart';
import 'package:studentup_mobile/ui/search/search_screen_delegate.dart';
import 'package:studentup_mobile/util/util.dart';

class SearchRoot extends StatelessWidget {
  double _getSize(int index) => index == 0
      ? 150.0
      : (index == SearchCategory.values.length - 2 ? 250 : 200);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: InnerDrawerMenu(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: true,
        title: const Text('Search'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(CupertinoIcons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchScreenDelegate(null),
              );
            },
          ),
        ],
      ),
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
    final String _categoryString = toString(SearchCategory.values[index]);
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
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Util.getRandomColor(),
            ),
          ),
          FractionallySizedBox(
            widthFactor: 0.8,
            alignment: Alignment.center,
            child: Text(
              _categoryString,
              textAlign: TextAlign.center,
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
