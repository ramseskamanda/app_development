import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_dev/models/user_info_model.dart';
import 'package:ui_dev/notifiers/view_notifiers/search_notifier.dart';
import 'package:ui_dev/ui/search/search_user_profile_card.dart';

class SearchScreenDelegate extends SearchDelegate<String> {
  final SearchNotifier notifier;

  SearchScreenDelegate(this.notifier);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    if (query.isEmpty) return null;
    return <Widget>[
      IconButton(
        icon: Icon(CupertinoIcons.clear_circled_solid),
        color: CupertinoColors.lightBackgroundGray,
        splashColor: Theme.of(context).accentColor,
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<UserInfoModel>>(
      future: notifier.searchFor(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        if (snapshot.hasError)
          return Center(child: Text(snapshot.error.toString()));
        if (snapshot.data.isEmpty)
          return Center(child: Text('No results found for: $query'));
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: GridView.builder(
            itemCount: snapshot.data.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
            ),
            itemBuilder: (context, index) =>
                UserProfileCard(model: snapshot.data[index]),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List _suggestions;
    if (query.isEmpty)
      _suggestions = _getSuggestions(initial: true);
    else
      _suggestions = _getSuggestions();
    return ListView.separated(
      itemCount: _suggestions.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) => ListTile(
        title: Text(_suggestions[index]),
        subtitle: Text('#4 will shock you!'),
        onTap: () => close(context, query),
      ),
    );
  }

  List _getSuggestions({initial = false}) {
    if (initial) {
      return Iterable.generate(10)
          .map((i) => 'This is a generic query...')
          .toList();
    } else {
      return Iterable.generate(10)
          .map((i) => 'You might be interested din $query')
          .toList();
    }
  }
}
