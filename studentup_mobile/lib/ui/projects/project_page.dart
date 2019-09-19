import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/enum/project_action.dart';
import 'package:studentup_mobile/models/project_model.dart';
import 'package:studentup_mobile/models/project_signup_model.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/project_page_notifier.dart';
import 'package:studentup_mobile/router.dart';
import 'package:studentup_mobile/services/authentication/auth_service.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/ui/projects/file_attachment.dart';
import 'package:studentup_mobile/ui/widgets/buttons/popup_menu.dart';
import 'package:studentup_mobile/ui/widgets/buttons/stadium_button.dart';
import 'package:studentup_mobile/ui/widgets/dialogs/dialogs.dart';
import 'package:studentup_mobile/ui/widgets/slivers/custom_sliver_delegate.dart';
import 'package:studentup_mobile/ui/widgets/utility/network_sensitive_widget.dart';
import 'package:studentup_mobile/util/util.dart';

class ProjectPage extends StatelessWidget {
  final ProjectModel model;

  const ProjectPage({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => Navigator.of(context).canPop(),
      child: ChangeNotifierProvider(
        builder: (_) => ProjectPageNotifier(model),
        child: Scaffold(
          body: NetworkSensitive(
            child: SafeArea(
              top: false,
              child: Stack(
                children: <Widget>[
                  CustomScrollView(
                    slivers: <Widget>[
                      ImageScrollbaleAppBar(model: model),
                      ProjectInformation(),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Consumer<ProjectPageNotifier>(
                      builder: (context, notifier, child) {
                        if (notifier.model.userIsOwner)
                          return StadiumButton(
                            text: 'End Project',
                            onPressed: () =>
                                notifier.sendData(ProjectAction.DELETE),
                          );
                        return StreamBuilder<ProjectSignupModel>(
                          stream: notifier.userSignUpStream,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.waiting ||
                                notifier.isLoading)
                              return const CircularProgressIndicator();
                            return StadiumButton(
                              text: snapshot.hasData
                                  ? 'Withdraw Application'
                                  : 'Apply',
                              onPressed: notifier.isWriting
                                  ? null
                                  : () => notifier.sendData(
                                        snapshot.hasData
                                            ? ProjectAction.WITHDRAW
                                            : ProjectAction.SIGNUP,
                                      ),
                            );
                          },
                        );
                      },
                    ),
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
          onPressed: () => Navigator.of(context).pop(false),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Consumer<ProjectPageNotifier>(
              builder: (context, service, child) {
                if (service.model.creatorId !=
                    Locator.of<AuthService>().currentUser.uid)
                  return Container();
                return PopupMenuWithActions(
                  color: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.4),
                  onDelete: () async {
                    await service.sendData(ProjectAction.DELETE);
                    Navigator.of(context).pop(true);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProjectPageNotifier notifier = Provider.of<ProjectPageNotifier>(context);
    return SliverList(
      delegate: SliverChildListDelegate(
        <Widget>[
          StreamBuilder<ProjectSignupModel>(
            stream: notifier.userSignUpStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(child: const CircularProgressIndicator());
              if (snapshot.hasError)
                return Center(child: const Text('Something went wrong...'));

              return Column(
                children: <Widget>[
                  if (snapshot.hasData)
                    Text(
                      'Signed Up!',
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .copyWith(color: Theme.of(context).accentColor),
                    ),
                  const SizedBox(height: 16.0),
                  Text(
                    notifier.model.creator,
                    style: Theme.of(context)
                        .textTheme
                        .headline
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    notifier.model.title,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.display1.copyWith(
                        color: Theme.of(context)
                            .textTheme
                            .display1
                            .color
                            .withAlpha(255),
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        (snapshot.hasData
                                ? (notifier.model.signupsNum + 1).toString()
                                : notifier.model.signupsNum.toString()) +
                            ' signed up!',
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                      Text(
                        'Applications close: ' +
                            Util.formatDateTime(notifier.model.deadline,
                                deadline: true),
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  if (notifier.model.files.isNotEmpty)
                    FlatButton.icon(
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
                          : () => notifier.downloadAttachments(),
                    ),
                  const SizedBox(height: 16.0),
                  Text(
                    notifier.model.description,
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                  if (notifier.model.userIsOwner) ...[
                    const SizedBox(height: 32.0),
                    StreamBuilder<List<ProjectSignupModel>>(
                      stream: notifier.signups,
                      initialData: [],
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<List<ProjectSignupModel>> snapshot,
                      ) {
                        if (!snapshot.hasData) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting)
                            return const CircularProgressIndicator();
                          return Text('An Error Occured...');
                        }
                        if (snapshot.data.isEmpty)
                          return Text('No signups yet, stay positive!');
                        return Column(
                          children: snapshot.data
                              .map((signup) => UserSignupTile(signup: signup))
                              .toList(),
                        );
                      },
                    ),
                  ] else ...[
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Column(
                        children: <Widget>[
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: TextField(
                                controller: notifier.message,
                                maxLines: null,
                                minLines: 5,
                                readOnly: snapshot.hasData,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: !snapshot.hasData
                                      ? 'Write about your motivation...'
                                      : snapshot.data.message,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24.0),
                          Center(
                            child: SingleFileAttachment(
                              canEdit: !snapshot.hasData,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 48.0),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class UserSignupTile extends StatelessWidget {
  final ProjectSignupModel signup;

  const UserSignupTile({Key key, this.signup}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: signup.user.imageUrl,
        placeholder: (_, __) => CircleAvatar(
          backgroundColor: CupertinoColors.extraLightBackgroundGray,
        ),
        errorWidget: (_, __, e) => CircleAvatar(
          backgroundColor: CupertinoColors.extraLightBackgroundGray,
          child: const Icon(Icons.error),
        ),
        imageBuilder: (_, image) => CircleAvatar(backgroundImage: image),
      ),
      title: Text(signup.user.givenName),
      isThreeLine: true,
      subtitle: Text(signup.message),
      trailing: IconButton(
        icon: const Icon(Icons.file_download),
        color: Theme.of(context).accentColor,
        onPressed: () => Dialogs.showComingSoon(context),
      ),
      onTap: () => Navigator.of(context).pushNamed(
        Router.otherProfile,
        arguments: {'infoModel': signup.user},
      ),
    );
  }
}
