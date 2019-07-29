import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_dev/search/search_enum.dart';
import 'package:ui_dev/search/search_screen_delegate.dart';
import 'package:ui_dev/search/search_user_profile_card.dart';

class CategoryScreen extends StatelessWidget {
  final SearchCategory category;

  const CategoryScreen({Key key, @required this.category}) : super(key: key);

  Future<void> _onSearch(BuildContext context) async {
    String result = await showSearch(
      context: context,
      delegate: SearchScreenDelegate(),
    );
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    final s = category.toString().split('.')[1].toLowerCase();

    return Scaffold(
      appBar: AppBar(
        title: Text('${s[0].toUpperCase()}${s.substring(1)}'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(CupertinoIcons.search),
            iconSize: 28.0,
            onPressed: () => _onSearch(context),
          ),
          IconButton(
            icon: Icon(CupertinoIcons.heart),
            onPressed: () => print('Go To Saved Profiles'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: GridView.builder(
          itemCount: 20,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
          ),
          itemBuilder: (context, index) => UserProfileCard(),
        ),
      ),
    );
  }
}
