import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentup/notifiers/saved_profiles_notifier.dart';
import 'package:studentup/ui/search/search_screen_delegate.dart';
import 'package:studentup/ui/widgets/notifiable_icon.dart';
import 'package:studentup/util/theme.dart';

class SearchCategoryView extends StatelessWidget {
  final String searchCategory;

  const SearchCategoryView({Key key, @required this.searchCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> _onSearch() async {
      String result = await showSearch(
        context: context,
        delegate: SearchScreenDelegate(),
      );
      print(result);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(searchCategory),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(CupertinoIcons.search),
            iconSize: 28.0,
            onPressed: _onSearch,
          ),
          IconButton(
            icon: NotifiableIcon<SavedProfilesNotifier>(
                iconData: CupertinoIcons.heart),
            onPressed: () => print('Go To Saved Profiles'),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: 10,
        separatorBuilder: (context, index) => SizedBox(height: 16.0),
        itemBuilder: (context, index) => SearchUserCard(),
      ),
    );
  }
}

class SearchUserCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(6.0),
          boxShadow: AppTheme.getSimpleBoxShadow(
            color: Theme.of(context).accentColor,
          ),
        ),
        child: ListTile(
          title: const Text('Ramses Kamanda'),
          subtitle: const Text(
            'This man has a great bio and has accomplished a lot.',
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () => print('😄'),
        ),
      ),
    );
  }
}
