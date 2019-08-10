import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_dev/models/project_model.dart';
import 'package:ui_dev/notifiers/view_notifiers/project_page_notifier.dart';
import 'package:ui_dev/ui/projects/file_attachment.dart';
import 'package:ui_dev/widgets/custom_sliver_delegate.dart';
import 'package:ui_dev/widgets/stadium_button.dart';

class ProjectPage extends StatelessWidget {
  final ProjectModel model;

  const ProjectPage({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (_) => ProjectPageNotifier(model),
      child: Scaffold(
        body: SafeArea(
          top: false,
          child: Stack(
            children: <Widget>[
              CustomScrollView(
                slivers: <Widget>[
                  ImageScrollbaleAppBar(model: model),
                  ProjectInformation(model: model),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Consumer<ProjectPageNotifier>(
                  builder: (context, notifier, child) {
                    if (notifier.isLoading) return CircularProgressIndicator();
                    if (notifier.model.userIsOwner)
                      return StadiumButton(
                        text: 'Select Candidate',
                        onPressed: () => print('object'),
                      );
                    return StadiumButton(
                      text: notifier.model.userSignedUp
                          ? 'Withdraw Application'
                          : 'Apply',
                      onPressed: notifier.model.userSignedUp
                          ? () => notifier.removeApplicant()
                          : () => notifier.signUp(),
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

class ImageScrollbaleAppBar extends StatelessWidget {
  final ProjectModel model;

  const ImageScrollbaleAppBar({Key key, @required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: true,
      delegate: CustomSliverDelegate(
        expandedHeight: MediaQuery.of(context).size.height * 0.3,
        flexibleSpace: CachedNetworkImage(
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
        stackChildHeight: 96.0,
        child: CachedNetworkImage(
          imageUrl: model.creatorMedia,
          placeholder: (_, __) => CircleAvatar(
            backgroundColor: CupertinoColors.lightBackgroundGray,
            radius: 96.0,
          ),
          errorWidget: (_, __, error) => CircleAvatar(
            backgroundColor: CupertinoColors.lightBackgroundGray,
            child: Icon(Icons.error),
            radius: 96.0,
          ),
          imageBuilder: (_, image) => CircleAvatar(
            backgroundImage: image,
            radius: 96.0,
          ),
        ),
        leading: FlatButton(
          shape: CircleBorder(),
          color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.4),
          child: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          FlatButton(
            shape: CircleBorder(),
            color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.4),
            child: Icon(Icons.more_horiz),
            onPressed: () => print('object'),
          ),
        ],
      ),
    );
  }
}

class ProjectInformation extends StatelessWidget {
  final ProjectModel model;

  const ProjectInformation({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        <Widget>[
          Column(
            children: <Widget>[
              Consumer<ProjectPageNotifier>(
                builder: (context, notifier, child) {
                  if (!notifier.model.userSignedUp) return Container();
                  return Text(
                    'Signed Up!',
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(color: Theme.of(context).accentColor),
                  );
                },
              ),
              const SizedBox(height: 16.0),
              Text(
                model.creator,
                style: Theme.of(context)
                    .textTheme
                    .headline
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16.0),
              Text(
                model.title,
                softWrap: true,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.display1.copyWith(
                    color: CupertinoColors.black, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    model.signupsNum.toString() + ' signed up!',
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                  Text(
                    '200 XP to earn',
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Consumer<ProjectPageNotifier>(
                builder: (context, notifier, child) {
                  return FlatButton.icon(
                    textColor: Theme.of(context).accentColor,
                    icon: notifier.isLoading
                        ? CircularProgressIndicator()
                        : Icon(Icons.file_download),
                    label: Text(
                      'Download attachement',
                      style: Theme.of(context).textTheme.title,
                    ),
                    onPressed: notifier.isLoading
                        ? null
                        : () => notifier.downloadAttachmentsAndPreview(),
                  );
                },
              ),
              const SizedBox(height: 16.0),
              Text(
                model.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  children: <Widget>[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Consumer<ProjectPageNotifier>(
                          builder: (context, notifier, child) {
                            return TextField(
                              controller: notifier.message,
                              maxLines: null,
                              minLines: 5,
                              readOnly: notifier.isLoading ||
                                  notifier.hasError ||
                                  notifier.model.userSignedUp,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: !notifier.model.userSignedUp
                                    ? 'Write about your motivation...'
                                    : notifier.model.userSignUpFile.message,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    Center(child: SingleFileAttachment()),
                  ],
                ),
              ),
              const SizedBox(height: 48.0),
            ],
          ),
        ],
      ),
    );
  }
}
