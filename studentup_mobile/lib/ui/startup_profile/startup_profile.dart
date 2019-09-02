import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/models/project_model.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/profile_notifier.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/startup_page_notifier.dart';
import 'package:studentup_mobile/ui/profile/user_information/profile_picture.dart';
import 'package:studentup_mobile/ui/projects/project_page.dart';
import 'package:studentup_mobile/ui/startup_profile/startup_profile_text.dart';
import 'package:studentup_mobile/ui/startup_profile/startup_team.dart';
import 'package:studentup_mobile/ui/widgets/buttons/stadium_button.dart';

class StartUpProfile extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> _key;

  StartUpProfile({Key key, String userId})
      : _key = GlobalKey<RefreshIndicatorState>(),
        super(key: key);

  Future<void> _onRefresh(BuildContext context) async {
    ProfileNotifier profileNotifier = Provider.of(context);
    profileNotifier.onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: LiquidPullToRefresh(
          key: _key,
          onRefresh: () => _onRefresh(context),
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  const SizedBox(height: 32.0),
                  ProfilePicture(),
                  const SizedBox(height: 12.0),
                  StartupProfileText(),
                  const SizedBox(height: 24.0),
                  StartupTeam(),
                  const SizedBox(height: 32.0),
                  Text(
                    'Ongoing Projects',
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 24.0),
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
                    padding: const EdgeInsets.only(top: 12.0, bottom: 24.0),
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
