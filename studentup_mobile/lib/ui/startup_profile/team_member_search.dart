import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentup_mobile/models/user_info_model.dart';
import 'package:studentup_mobile/services/algolia_service.dart';
import 'package:studentup_mobile/services/locator.dart';

class TeamMemberSearchDelegate extends SearchDelegate<UserInfoModel> {
  final AlgoliaService _algoliaService = Locator.of<AlgoliaService>();

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
    return SafeArea(
      child: FutureBuilder<List<UserInfoModel>>(
        future: _algoliaService.searchUsers(query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: const CircularProgressIndicator());
            return Center(child: const Text('An error occurred...'));
          }

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              var user = snapshot.data[index];
              return ListTile(
                leading: CachedNetworkImage(
                  imageUrl: user.mediaRef,
                  placeholder: (_, url) => CircleAvatar(
                    backgroundColor: CupertinoColors.lightBackgroundGray,
                  ),
                  errorWidget: (_, __, e) => CircleAvatar(
                    backgroundColor: CupertinoColors.lightBackgroundGray,
                    child: const Icon(Icons.error),
                  ),
                  imageBuilder: (_, image) => CircleAvatar(
                    backgroundImage: image,
                  ),
                ),
                title: Text(user.givenName),
                subtitle: Text(user.university),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: const Text('Are you sure?'),
                        content: ListTile(
                          leading: CachedNetworkImage(
                            imageUrl: user.mediaRef,
                            placeholder: (_, url) => CircleAvatar(
                              backgroundColor:
                                  CupertinoColors.lightBackgroundGray,
                            ),
                            errorWidget: (_, __, e) => CircleAvatar(
                              backgroundColor:
                                  CupertinoColors.lightBackgroundGray,
                              child: const Icon(Icons.error),
                            ),
                            imageBuilder: (_, image) => CircleAvatar(
                              backgroundImage: image,
                            ),
                          ),
                          title: Text(user.givenName),
                          subtitle: Text(user.university),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: const Text('Cancel'),
                            onPressed: () => Navigator.of(_).pop(),
                          ),
                          RaisedButton(
                            shape: const StadiumBorder(),
                            child: const Text('Accept'),
                            textColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            onPressed: () {
                              Navigator.of(_).pop();
                              close(context, user);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 8.0),
              Text(
                'People',
                style:
                    Theme.of(context).textTheme.title.apply(fontWeightDelta: 1),
              ),
              const SizedBox(height: 12.0),
              for (int i in [0, 1])
                ListTile(
                  title: Text('$query ${i.isEven ? 'Maastricht' : 'Lisbon'}'),
                  onTap: () {
                    query = '$query ${i.isEven ? 'Maastricht' : 'Lisbon'}';
                    showResults(context);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
