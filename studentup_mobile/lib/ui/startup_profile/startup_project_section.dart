import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/models/project_model.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/profile_notifier.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:studentup_mobile/router.dart';
import 'package:studentup_mobile/ui/widgets/buttons/stadium_button.dart';

class StartupProjectSection extends StatelessWidget {
  final bool ongoing;

  const StartupProjectSection({Key key, @required this.ongoing})
      : assert(ongoing != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          '${ongoing ? 'Ongoing' : 'Past'} Projects',
          style: Theme.of(context)
              .textTheme
              .title
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0, bottom: 24.0),
          child: Consumer<ProfileNotifier>(
            builder: (context, notifier, child) {
              return StreamBuilder<List<ProjectModel>>(
                stream:
                    ongoing ? notifier.ongoingProjects : notifier.pastProjects,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<List<ProjectModel>> snapshot,
                ) {
                  if (!snapshot.hasData) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Center(
                        child: Text(
                            'No ${ongoing ? 'Ongoing' : 'Past'} Projects...'),
                      );
                    return Center(child: const Text('An Error Occured.'));
                  }
                  if (snapshot.data.isEmpty)
                    return Center(
                      child: Text(
                          'No ${ongoing ? 'Ongoing' : 'Past'} Projects...'),
                    );

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: snapshot.data
                        .map((m) => ProjectPost(model: m))
                        .toList(),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class ProjectPost extends StatelessWidget {
  final ProjectModel model;

  const ProjectPost({Key key, @required this.model}) : super(key: key);

  _navigateToProject(BuildContext context) async {
    Navigator.of(context).pushNamed(
      Router.projectPage,
      arguments: {'model': model},
    );
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
