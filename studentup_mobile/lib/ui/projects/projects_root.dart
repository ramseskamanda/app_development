import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/models/project_model.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/project_feed_notifier.dart';
import 'package:studentup_mobile/ui/projects/new_project_root.dart';
import 'package:studentup_mobile/ui/projects/project_page.dart';
import 'package:studentup_mobile/ui/widgets/buttons/fab.dart';
import 'package:studentup_mobile/ui/widgets/buttons/stadium_button.dart';

class ProjectFeedRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text('Projects'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(CupertinoIcons.search),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: PaddedFAB(
        icon: Icons.add,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => NewProjectRoot(),
            ),
          );
        },
      ),
      body: ChangeNotifierProvider<ProjectFeedNotifier>(
        builder: (_) => ProjectFeedNotifier(),
        child: SafeArea(
          child: Consumer<ProjectFeedNotifier>(
            builder: (context, notifier, child) {
              return LiquidPullToRefresh(
                onRefresh: () => notifier.onRefresh(),
                child: ListView.separated(
                  itemCount: notifier.projects.length,
                  separatorBuilder: (_, index) => const SizedBox(height: 24.0),
                  itemBuilder: (_, index) =>
                      ProjectPost(model: notifier.projects[index]),
                ),
              );
            },
          ),
        ),
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
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => ProjectPage(model: model)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
