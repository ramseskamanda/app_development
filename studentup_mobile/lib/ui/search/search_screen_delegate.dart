import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentup_mobile/enum/search_enum.dart';
import 'package:studentup_mobile/models/chat_model.dart';
import 'package:studentup_mobile/models/user_info_model.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/services/search/base_search_api.dart';
import 'package:studentup_mobile/ui/profile/other_profile.dart';

class SearchScreenDelegate extends SearchDelegate<UserInfoModel> {
  final BaseSearchAPI _algoliaService = Locator.of<BaseSearchAPI>();
  final SearchCategory category;

  SearchScreenDelegate(this.category);

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
    return FutureBuilder<List<UserInfoModel>>(
      future: category != null
          ? _algoliaService.searchUsersWithFacets(
              category: category,
              queryString: query,
            )
          : _algoliaService.searchUsers(query),
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
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              return ListTile(
                leading: CachedNetworkImage(
                  imageUrl: snapshot.data[index].mediaRef,
                  placeholder: (_, url) => CircleAvatar(
                    radius: 25,
                    backgroundColor: CupertinoColors.lightBackgroundGray,
                  ),
                  errorWidget: (_, url, error) => CircleAvatar(
                    radius: 25,
                    backgroundColor: CupertinoColors.lightBackgroundGray,
                    child: Icon(Icons.error),
                  ),
                  imageBuilder: (context, image) {
                    return CircleAvatar(
                      radius: 25,
                      backgroundImage: image,
                    );
                  },
                ),
                title: Text(snapshot.data[index].givenName),
                subtitle: Text(snapshot.data[index].university),
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (_) => OtherProfile(
                        infoModel: Preview(
                          givenName: snapshot.data[index].givenName,
                          imageUrl: snapshot.data[index].mediaRef,
                          uid: snapshot.data[index].docId,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
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
          for (String typeahead in ['Lisbon', 'Maastricht', 'California'])
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
