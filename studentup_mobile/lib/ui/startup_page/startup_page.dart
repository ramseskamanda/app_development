import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/models/chat_model.dart';
import 'package:studentup_mobile/models/project_model.dart';
import 'package:studentup_mobile/models/startup_info_model.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/startup_page_notifier.dart';
import 'package:studentup_mobile/ui/projects/project_page.dart';
import 'package:studentup_mobile/ui/startup_profile/team_member.dart';
import 'package:studentup_mobile/ui/widgets/buttons/stadium_button.dart';
import 'package:studentup_mobile/ui/widgets/screens/see_all.dart';
import 'package:studentup_mobile/ui/widgets/utility/network_sensitive_widget.dart';

class StartUpPageRoot extends StatefulWidget {
  final StartupInfoModel model;

  const StartUpPageRoot({Key key, @required this.model}) : super(key: key);

  @override
  _StartUpPageRootState createState() => _StartUpPageRootState();
}

class _StartUpPageRootState extends State<StartUpPageRoot> {
  StartupPageNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = StartupPageNotifier(widget.model);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StartupPageNotifier>.value(
      value: notifier,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: NetworkSensitive(
          child: SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: LiquidPullToRefresh(
                onRefresh: notifier.onRefresh,
                child: ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        const SizedBox(height: 32.0),
                        CachedNetworkImage(
                          imageUrl: widget.model.imageUrl,
                          placeholder: (_, __) => CircleAvatar(
                            radius: 56.0,
                            backgroundColor:
                                CupertinoColors.lightBackgroundGray,
                          ),
                          errorWidget: (_, __, error) => CircleAvatar(
                            radius: 56.0,
                            backgroundColor:
                                CupertinoColors.lightBackgroundGray,
                            child: Icon(Icons.error),
                          ),
                          imageBuilder: (_, image) => CircleAvatar(
                            radius: 56.0,
                            backgroundImage: image,
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        Text(
                          widget.model.name,
                          style: Theme.of(context).textTheme.headline.copyWith(
                                fontWeight: FontWeight.bold,
                                color: CupertinoColors.black,
                              ),
                        ),
                        const SizedBox(height: 12.0),
                        Text(
                          widget.model.locationString,
                          style: Theme.of(context)
                              .textTheme
                              .subhead
                              .copyWith(color: CupertinoColors.inactiveGray),
                        ),
                        const SizedBox(height: 12.0),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.67,
                          child: Text(
                            widget.model.description,
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle
                                .copyWith(
                                    color: CupertinoColors.black,
                                    fontStyle: FontStyle.italic),
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        Text(
                          widget.model.website,
                          style: Theme.of(context)
                              .textTheme
                              .subhead
                              .copyWith(color: Theme.of(context).accentColor),
                        ),
                        const SizedBox(height: 24.0),
                        if (widget.model.team.isNotEmpty)
                          Container(
                            width: MediaQuery.of(context).size.width * 0.67,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Team',
                                      style: Theme.of(context)
                                          .textTheme
                                          .title
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Consumer<StartupPageNotifier>(
                                      builder: (context, notifier, child) {
                                        if (notifier.team.length < 4)
                                          return Container();
                                        return FlatButton(
                                          child: Text(
                                            'See all',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .accentColor),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (_) {
                                                  final String name =
                                                      widget.model.name;
                                                  return SeeAll<Preview>(
                                                    title:
                                                        '$name${name.endsWith('s') ? '\'' : '\'s'} Team',
                                                    objects: widget.model.team,
                                                    separator: const SizedBox(
                                                        height: 16.0),
                                                    builder: (context, index) {
                                                      Preview user = widget
                                                          .model.team[index];
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    16.0),
                                                        child: ListTile(
                                                          title: Text(
                                                              user.givenName),
                                                          subtitle: Text(
                                                              'Team Member of ${widget.model.name}'),
                                                          leading:
                                                              CachedNetworkImage(
                                                            imageUrl:
                                                                user.imageUrl,
                                                            placeholder: (_,
                                                                    url) =>
                                                                CircleAvatar(
                                                              radius: 25,
                                                              backgroundColor:
                                                                  CupertinoColors
                                                                      .lightBackgroundGray,
                                                            ),
                                                            errorWidget: (_,
                                                                    url,
                                                                    error) =>
                                                                CircleAvatar(
                                                              radius: 25,
                                                              backgroundColor:
                                                                  CupertinoColors
                                                                      .lightBackgroundGray,
                                                              child: Icon(
                                                                  Icons.error),
                                                            ),
                                                            imageBuilder:
                                                                (context,
                                                                    image) {
                                                              return CircleAvatar(
                                                                radius: 25,
                                                                backgroundImage:
                                                                    image,
                                                              );
                                                            },
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
                                      },
                                    ),
                                  ],
                                ),
                                Divider(),
                                Consumer<StartupPageNotifier>(
                                    builder: (context, notifier, child) {
                                  if (notifier.isLoading)
                                    return Center(
                                        child:
                                            const CircularProgressIndicator());
                                  if (notifier.hasError)
                                    return Center(child: Icon(Icons.error));
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      if (notifier.team.length <= 3) ...[
                                        for (Preview member in notifier.team)
                                          TeamMember(model: member)
                                      ] else ...[
                                        for (int i in [0, 1, 2])
                                          TeamMember(model: notifier.team[i]),
                                        TeamMember(
                                          isAdditional: true,
                                          numAdditional:
                                              notifier.team.length - 3,
                                        ),
                                      ]
                                    ],
                                  );
                                }),
                              ],
                            ),
                          ),
                        const SizedBox(height: 32.0),
                        Text(
                          'Ongoing Projects',
                          style: Theme.of(context)
                              .textTheme
                              .title
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 12.0, bottom: 24.0),
                          child: Consumer<StartupPageNotifier>(
                            builder: (context, notifier, child) {
                              if (notifier.isLoading)
                                return Center(
                                    child: const CircularProgressIndicator());
                              if (notifier.hasError)
                                return Center(child: const Icon(Icons.error));

                              if (notifier.ongoingProjects.isEmpty)
                                return Center(
                                  child: const Text('No Ongoing Projects...'),
                                );

                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: notifier.ongoingProjects
                                    .map((ProjectModel m) =>
                                        m.deadline.isAfter(DateTime.now())
                                            ? ProjectPost(model: m)
                                            : Container())
                                    .toList(),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 32.0),
                        Text(
                          'Past Projects',
                          style: Theme.of(context)
                              .textTheme
                              .title
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 12.0, bottom: 24.0),
                          child: Consumer<StartupPageNotifier>(
                            builder: (context, notifier, child) {
                              if (notifier.isLoading)
                                return Center(
                                    child: const CircularProgressIndicator());
                              if (notifier.hasError)
                                return Center(child: const Icon(Icons.error));

                              if (notifier.pastProjects.isEmpty)
                                return Center(
                                  child: const Text('No Previous Projects...'),
                                );

                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: notifier.pastProjects
                                    .map((ProjectModel m) =>
                                        m.deadline.isBefore(DateTime.now())
                                            ? ProjectPost(model: m)
                                            : Container())
                                    .toList(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProjectPost extends StatelessWidget {
  final ProjectModel model;

  const ProjectPost({Key key, @required this.model}) : super(key: key);

  _navigateToProject(BuildContext context) async {
    final bool result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ProjectPage(model: model),
      ),
    );
    if (result) Provider.of<StartupPageNotifier>(context).onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToProject(context),
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Stack(
                  children: <Widget>[
                    CachedNetworkImage(
                      imageUrl: model.media,
                      fit: BoxFit.cover,
                      placeholder: (context, url) {
                        return CircularProgressIndicator();
                      },
                      errorWidget: (context, url, error) {
                        return Icon(Icons.error);
                      },
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: imageProvider,
                            ),
                          ),
                        );
                      },
                    ),
                    Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(),
                        ),
                        Expanded(
                          child: Container(
                            color: CupertinoColors.darkBackgroundGray
                                .withOpacity(0.42),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CachedNetworkImage(
                        imageUrl: model.creatorMedia,
                        fit: BoxFit.cover,
                        placeholder: (context, url) {
                          return CircularProgressIndicator();
                        },
                        errorWidget: (context, url, error) {
                          return Icon(Icons.error);
                        },
                        imageBuilder: (context, imageProvider) {
                          return CircleAvatar(
                            radius: 36.0,
                            backgroundImage: imageProvider,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      model.creator,
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                    Text(
                      model.title,
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                    StadiumButton(
                      text: 'Read More',
                      onPressed: () => _navigateToProject(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
