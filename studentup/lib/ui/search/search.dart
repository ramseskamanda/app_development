import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:studentup/notifiers/saved_profiles_notifier.dart';
import 'package:studentup/ui/search/search_card.dart';
import 'package:studentup/ui/search/search_screen_delegate.dart';
import 'package:studentup/ui/widgets/notifiable_icon.dart';
import 'package:studentup/ui/widgets/profile_drawer_button.dart';
import 'package:studentup/util/env.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  double _getSize(int index) => index == 0
      ? 150.0
      : (index == Environment.searchCategories.length - 2 ? 250 : 200);

  Future<void> _onSearch(BuildContext context) async {
    String result = await showSearch(
      context: context,
      delegate: SearchScreenDelegate(),
    );
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          heroTag: 'search_screen',
          child: const Icon(CupertinoIcons.add),
          onPressed: () =>
              Provider.of<SavedProfilesNotifier>(context).incrementNumSaved(),
        ),
        appBar: AppBar(
          title: const Text('Search Engine'),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0.0,
          centerTitle: true,
          leading: ProfileDrawerButton(),
          actions: <Widget>[
            IconButton(
              icon: const Icon(CupertinoIcons.search),
              iconSize: 28.0,
              onPressed: () => _onSearch(context),
            ),
            IconButton(
              icon: NotifiableIcon<SavedProfilesNotifier>(
                  iconData: CupertinoIcons.heart),
              onPressed: () => print('Go To Saved Profiles'),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: 8,
            itemBuilder: (BuildContext context, int index) =>
                SearchCard(index: index),
            staggeredTileBuilder: (int index) =>
                StaggeredTile.extent(2, _getSize(index)),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          ),
        ),
      ),
    );
  }
}
