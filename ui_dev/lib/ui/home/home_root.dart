import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_dev/models/prize_model.dart';
import 'package:ui_dev/models/project_model.dart';
import 'package:ui_dev/models/startup_info_model.dart';
import 'package:ui_dev/notifiers/view_notifiers/feed_notifier.dart';
import 'package:ui_dev/widgets/stadium_button.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (_) => FeedNotifier(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.chat_bubble_outline),
              onPressed: () {},
            ),
          ],
        ),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              // * Newest start-ups nearby

              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Newest start-ups nearby',
                  style: Theme.of(context)
                      .textTheme
                      .headline
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: Consumer<FeedNotifier>(
                  builder: (context, notifier, child) {
                    if (notifier.isLoading)
                      return Center(child: CircularProgressIndicator());
                    if (notifier.hasError)
                      return Center(child: Icon(Icons.error));
                    return ListView.separated(
                      controller: ScrollController(),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: notifier.startups.length + 1,
                      separatorBuilder: (context, index) =>
                          index == 0 ? Container() : SizedBox(width: 8.0),
                      itemBuilder: (context, index) => index == 0
                          ? SizedBox(width: 16.0)
                          : StartupCard(model: notifier.startups[index - 1]),
                    );
                  },
                ),
              ),
              // * Monthly prizes

              const SizedBox(height: 32.0),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'This month\'s prizes',
                      style: Theme.of(context)
                          .textTheme
                          .headline
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    FlatButton(
                      child: const Text('See all'),
                      textColor: Theme.of(context).accentColor,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: Consumer<FeedNotifier>(
                  builder: (context, notifier, child) {
                    if (notifier.isLoading)
                      return Center(child: CircularProgressIndicator());
                    if (notifier.hasError)
                      return Center(child: Icon(Icons.error));
                    return ListView.separated(
                      controller: ScrollController(),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: notifier.prizes.length + 1,
                      separatorBuilder: (context, index) =>
                          index == 0 ? Container() : SizedBox(width: 8.0),
                      itemBuilder: (context, index) => index == 0
                          ? SizedBox(width: 16.0)
                          : PrizeCard(model: notifier.prizes[index - 1]),
                    );
                  },
                ),
              ),
              // * Competitions

              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Competitions',
                  style: Theme.of(context)
                      .textTheme
                      .headline
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16.0),
              Consumer<FeedNotifier>(
                builder: (context, notifier, child) {
                  if (notifier.isLoading)
                    return Center(child: CircularProgressIndicator());
                  if (notifier.hasError)
                    return Center(child: Icon(Icons.error));
                  print(notifier.projects.length);
                  return Column(
                    children: notifier.projects
                        .map((project) => ProjectPost(model: project))
                        .toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StartupCard extends StatelessWidget {
  final StartupInfoModel model;

  const StartupCard({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print(model.website),
      child: Card(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 16.0),
              CachedNetworkImage(
                imageUrl: model.imageUrl,
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
              const SizedBox(height: 8.0),
              Text(
                model.name,
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  model.description,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PrizeCard extends StatelessWidget {
  final PrizeModel model;

  const PrizeCard({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: 'https://via.placeholder.com/150',
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
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: imageProvider,
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: CupertinoColors.darkBackgroundGray.withOpacity(0.42),
                  ),
                ),
                Center(
                  child: Text(
                    model.name,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          if (model.sponsored) ...[
            const SizedBox(height: 6.0),
            Text(
              'Sponsored',
              style: Theme.of(context)
                  .textTheme
                  .subtitle
                  .copyWith(color: Theme.of(context).accentColor),
            ),
          ],
        ],
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
                    imageUrl: 'https://via.placeholder.com/150',
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
                      imageUrl: 'https://via.placeholder.com/150',
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
                  Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.check_circle,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
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
                    onPressed: () => print(model.description),
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
