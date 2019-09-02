import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/models/project_model.dart';
import 'package:studentup_mobile/models/startup_info_model.dart';
import 'package:studentup_mobile/models/user_info_model.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/startup_page_notifier.dart';

class StartUpPageRoot extends StatelessWidget {
  final StartupInfoModel model;

  const StartUpPageRoot({Key key, @required this.model}) : super(key: key);

  //TODO: FIX THIS TO BE LIKE THE PROFILE WITH STREAMS AND ALL THAT

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StartupPageNotifier>(
      builder: (_) => StartupPageNotifier(model),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 32.0),
                  CachedNetworkImage(
                    imageUrl: model.imageUrl,
                    placeholder: (_, __) => CircleAvatar(
                      radius: 56.0,
                      backgroundColor: CupertinoColors.lightBackgroundGray,
                    ),
                    errorWidget: (_, __, error) => CircleAvatar(
                      radius: 56.0,
                      backgroundColor: CupertinoColors.lightBackgroundGray,
                      child: Icon(Icons.error),
                    ),
                    imageBuilder: (_, image) => CircleAvatar(
                      radius: 56.0,
                      backgroundImage: image,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    model.name,
                    style: Theme.of(context).textTheme.headline.copyWith(
                          fontWeight: FontWeight.bold,
                          color: CupertinoColors.black,
                        ),
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    model.locationString,
                    style: Theme.of(context)
                        .textTheme
                        .subhead
                        .copyWith(color: CupertinoColors.inactiveGray),
                  ),
                  const SizedBox(height: 12.0),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.67,
                    child: Text(
                      model.description,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle.copyWith(
                          color: CupertinoColors.black,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    model.website,
                    style: Theme.of(context)
                        .textTheme
                        .subhead
                        .copyWith(color: Theme.of(context).accentColor),
                  ),
                  const SizedBox(height: 24.0),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.67,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Team',
                              style: Theme.of(context)
                                  .textTheme
                                  .title
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            Consumer<StartupPageNotifier>(
                              builder: (context, notifier, child) {
                                if (notifier.team.length < 4)
                                  return Container();
                                return FlatButton(
                                  child: Text(
                                    'See all',
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor),
                                  ),
                                  onPressed: () => print('object'),
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
                                child: const CircularProgressIndicator());
                          if (notifier.hasError)
                            return Center(child: Icon(Icons.error));
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              if (notifier.team.length <= 3) ...[
                                for (UserInfoModel member in notifier.team)
                                  TeamMember(model: member)
                              ] else ...[
                                for (int i in [0, 1, 2])
                                  TeamMember(model: notifier.team[i]),
                                TeamMember(
                                  isAdditional: true,
                                  numAdditional: notifier.team.length - 3,
                                ),
                              ]
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 56.0),
                  Text(
                    'Ongoing Projects',
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Consumer<StartupPageNotifier>(
                    builder: (context, notifier, child) {
                      if (notifier.isLoading)
                        return Center(child: const CircularProgressIndicator());
                      if (notifier.hasError)
                        return Center(child: const Icon(Icons.error));

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: notifier.projects.length,
                        itemExtent: MediaQuery.of(context).size.height * 0.56,
                        itemBuilder: (_, index) =>
                            ProjectPost(model: notifier.projects[index]),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TeamMember extends StatelessWidget {
  final bool isAdditional;
  final int numAdditional;
  final UserInfoModel model;

  const TeamMember(
      {Key key, this.isAdditional = false, this.numAdditional = 0, this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 1.0),
      child: isAdditional
          ? CircleAvatar(
              radius: 32.0,
              child: Text('+$numAdditional'),
              backgroundColor: CupertinoColors.lightBackgroundGray,
            )
          : CachedNetworkImage(
              imageUrl: model.mediaRef,
              placeholder: (_, url) => CircleAvatar(
                radius: 32.0,
                backgroundColor: CupertinoColors.lightBackgroundGray,
              ),
              errorWidget: (_, url, error) => CircleAvatar(
                radius: 32.0,
                backgroundColor: CupertinoColors.lightBackgroundGray,
                child: Icon(Icons.error),
              ),
              imageBuilder: (context, image) {
                return CircleAvatar(
                  radius: 32.0,
                  backgroundImage: image,
                );
              },
            ),
    );
  }
}

class ProjectPost extends StatelessWidget {
  final ProjectModel model;

  const ProjectPost({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: model.media,
                  fit: BoxFit.cover,
                  placeholder: (_, url) => Container(
                    color: CupertinoColors.lightBackgroundGray,
                  ),
                  errorWidget: (_, __, error) => Container(
                    color: CupertinoColors.lightBackgroundGray,
                    child: Center(child: const Icon(Icons.error)),
                  ),
                  imageBuilder: (_, image) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: image,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        color: CupertinoColors.inactiveGray.withOpacity(0.57),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 12.0),
                            Text(
                              model.creator,
                              style: Theme.of(context).textTheme.title.copyWith(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                            ),
                            Text(
                              model.title,
                              style:
                                  Theme.of(context).textTheme.headline.copyWith(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: CachedNetworkImage(
                    imageUrl: model.creatorMedia,
                    fit: BoxFit.cover,
                    placeholder: (_, url) => CircleAvatar(
                      backgroundColor: CupertinoColors.lightBackgroundGray,
                    ),
                    errorWidget: (_, __, error) => CircleAvatar(
                      backgroundColor: CupertinoColors.lightBackgroundGray,
                      child: Center(child: const Icon(Icons.error)),
                    ),
                    imageBuilder: (_, image) => CircleAvatar(
                      radius: 40.0,
                      backgroundImage: image,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.87,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 16.0),
                  LinearPercentIndicator(
                    percent: model.percentSignedUp,
                    progressColor: Theme.of(context).accentColor,
                    backgroundColor: CupertinoColors.lightBackgroundGray,
                    lineHeight: 8.0,
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '${model.signupsNum} people signed up!',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        model.formattedDeadline,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                  Spacer(),
                  const SizedBox(height: 16.0),
                  Text(
                    model.description,
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                  Spacer(),
                  // StadiumButton(
                  //   text: 'Learn more!',
                  //   onPressed: () => Navigator.of(context).push(
                  //     MaterialPageRoute(
                  //         builder: (_) => ProjectPage(model: model)),
                  //   ),
                  // ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
