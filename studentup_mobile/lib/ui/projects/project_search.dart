import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentup_mobile/enum/search_enum.dart';
import 'package:studentup_mobile/models/project_model.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/services/search/base_search_api.dart';
import 'package:studentup_mobile/ui/projects/projects_root.dart';

class ProjectSearchDelegate extends SearchDelegate {
  final BaseSearchAPI _algoliaService = Locator.of<BaseSearchAPI>();

  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context).copyWith(
          primaryColor: Theme.of(context).scaffoldBackgroundColor,
          iconTheme: Theme.of(context).iconTheme,
          appBarTheme: AppBarTheme(
            color: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0.0,
          ),
        );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    //FIXME: There's something going on here after a search result is selected,
    // the field can't be cleared
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
    return FutureBuilder<List<ProjectModel>>(
      future: _algoliaService.searchProjects(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        if (snapshot.hasError)
          return Center(child: Text(snapshot.error.toString()));
        if (snapshot.data.isEmpty)
          return Center(child: Text('No results found for: $query'));
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListView.separated(
            itemCount: snapshot.data.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16.0),
            itemBuilder: (context, index) =>
                ProjectPost(model: snapshot.data[index]),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ListView(
        children: <Widget>[
          for (String typeahead in SearchCategory.values
              .map((c) => c.toString().split('.')[1].toLowerCase()))
            ListTile(
              title: Text('$query $typeahead'),
              onTap: () {
                query = '$query $typeahead';
                showResults(context);
              },
            ),
        ],
      ),
    );
  }
}
