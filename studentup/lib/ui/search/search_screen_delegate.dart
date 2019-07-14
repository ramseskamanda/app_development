import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreenDelegate extends SearchDelegate<String> {
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
        color: CupertinoColors.extraLightBackgroundGray,
        highlightColor: CupertinoColors.lightBackgroundGray,
        onPressed: () => query = '',
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
    final Random rand = Random();
    return ListView.builder(
      itemCount: rand.nextInt(15),
      itemExtent: 75.0,
      itemBuilder: (context, index) => ListTile(
        title: Text('Top ${rand.nextInt(100)} Employers in $query'),
        subtitle: Text('#${rand.nextInt(100)} will shock you!'),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemCount: query.isEmpty ? 10 : query.length,
      itemExtent: 75.0,
      itemBuilder: (context, index) => ListTile(
        title: Text('Top ${query.length} Employers in $query'),
        subtitle: Text('#${query.length} will shock you!'),
        onTap: () => close(context, query),
      ),
    );
  }
}
