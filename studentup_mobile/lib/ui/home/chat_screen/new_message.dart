import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/models/startup_info_model.dart';
import 'package:studentup_mobile/models/user_info_model.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/new_message_notifier.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/profile_notifier.dart';
import 'package:studentup_mobile/router.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/services/search/base_search_api.dart';
import 'package:studentup_mobile/ui/widgets/buttons/stadium_button.dart';

class NewMessage extends StatelessWidget {
  final UserInfoModel model;
  final bool fromSearch;

  const NewMessage({Key key, this.model, this.fromSearch = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NewMessageNotifier>(
      builder: (_) => NewMessageNotifier(
        selectedUser: model,
        user: Provider.of<ProfileNotifier>(context).preview,
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.close,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'New Message',
            style: TextStyle(
              color: Theme.of(context).textTheme.title.color.withAlpha(255),
            ),
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Consumer<NewMessageNotifier>(
                    builder: (context, notifier, child) {
                      return Column(
                        children: <Widget>[
                          if (notifier.selectedUser != null)
                            ListTile(
                              leading: CachedNetworkImage(
                                imageUrl: notifier.selectedUser.mediaRef,
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
                              title: Text(notifier.selectedUser.givenName),
                              subtitle: Text(notifier.selectedUser.university),
                              trailing: fromSearch
                                  ? null
                                  : IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () async {
                                        final result = await showSearch(
                                          context: context,
                                          delegate: CustomSearchDelegate(),
                                        );
                                        if (result != null)
                                          notifier.selectedUser = result;
                                      },
                                    ),
                            )
                          else
                            ListTile(
                              leading: const Icon(Icons.person),
                              title: const Text('Search user...'),
                              trailing: const Icon(CupertinoIcons.search),
                              onTap: () async {
                                final result = await showSearch(
                                  context: context,
                                  delegate: CustomSearchDelegate(),
                                );
                                if (result != null)
                                  notifier.selectedUser = result;
                              },
                            ),
                          const SizedBox(height: 24.0),
                          TextField(
                            controller: notifier.newMessage,
                            maxLength: 1000,
                            maxLengthEnforced: true,
                            minLines: 10,
                            maxLines: null,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter your message here...',
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Consumer<NewMessageNotifier>(
                  builder: (context, notifier, child) {
                    if (notifier.isLoading)
                      return const CircularProgressIndicator();
                    if (notifier.hasError)
                      //show Error
                      print('error');
                    return StadiumButton(
                      text: 'Send',
                      onPressed: () async {
                        final bool result = await notifier.sendData();
                        if (result) {
                          Navigator.of(context).pop();
                          Navigator.of(context).pushNamed(
                            Router.conversation,
                            arguments: {
                              'chat': notifier.newChat,
                            },
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
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
      child: FutureBuilder<Map<int, List>>(
        future: _algoliaService.searchUsersAndStartups(query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: const CircularProgressIndicator());
            return Center(child: const Text('An error occurred...'));
          }
          List<UserInfoModel> users = snapshot.data[0];
          List<StartupInfoModel> startups = snapshot.data[1];

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 8.0),
                  Text(
                    'People',
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .apply(fontWeightDelta: 1),
                  ),
                  const SizedBox(height: 12.0),
                  for (UserInfoModel user in users)
                    ListTile(
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
                      onTap: () => close(context, user),
                    ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Startups',
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .apply(fontWeightDelta: 1),
                  ),
                  const SizedBox(height: 12.0),
                  for (StartupInfoModel startup in startups)
                    ListTile(
                      leading: CachedNetworkImage(
                        imageUrl: startup.imageUrl,
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
                      title: Text(startup.name),
                      subtitle: Text(startup.location),
                      onTap: () => close(context, startup),
                    ),
                ],
              ),
            ),
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
              const SizedBox(height: 20.0),
              Text(
                'Startups',
                style:
                    Theme.of(context).textTheme.title.apply(fontWeightDelta: 1),
              ),
              const SizedBox(height: 12.0),
              for (int i in [0, 1, 2])
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
