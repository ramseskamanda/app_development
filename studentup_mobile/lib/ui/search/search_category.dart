import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/enum/search_enum.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/search_category_notifier.dart';
import 'package:studentup_mobile/ui/search/search_screen_delegate.dart';
import 'package:studentup_mobile/ui/search/search_user_profile_card.dart';

class CategoryScreen extends StatelessWidget {
  final SearchCategory category;

  const CategoryScreen({Key key, @required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final s =
        category.toString().split('.')[1].toLowerCase().replaceAll('_', ' ');

    return ChangeNotifierProvider<SearchCategoryNotifier>(
      builder: (_) => SearchCategoryNotifier(category),
      child: Scaffold(
        appBar: AppBar(
          title: Text('${s[0].toUpperCase()}${s.substring(1)}'),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0.0,
          centerTitle: true,
          actions: <Widget>[
            Consumer<SearchCategoryNotifier>(
              builder: (context, notifier, child) {
                return IconButton(
                  icon: const Icon(CupertinoIcons.search),
                  iconSize: 28.0,
                  onPressed: () async {
                    await showSearch(
                      context: context,
                      delegate: SearchScreenDelegate(category),
                    );
                  },
                );
              },
            ),
            IconButton(
              icon: Icon(CupertinoIcons.heart),
              onPressed: () => print('Go To Saved Profiles'),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Consumer<SearchCategoryNotifier>(
            builder: (context, notifier, child) {
              if (notifier.isLoading)
                return Center(
                  child: CircularProgressIndicator(),
                );
              if (notifier.hasError)
                return Center(
                  child: Text(notifier.error.message),
                );
              if (notifier.users.isEmpty)
                return Center(
                  child: Text('Couldn\'t find a match for $s'),
                );
              return GridView.builder(
                itemCount: notifier.users.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemBuilder: (context, index) =>
                    UserProfileCard(model: notifier.users[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}
