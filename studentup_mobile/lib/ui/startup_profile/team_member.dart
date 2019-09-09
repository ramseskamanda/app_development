import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentup_mobile/models/chat_model.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/profile_notifier.dart';
import 'package:studentup_mobile/router.dart';
import 'package:studentup_mobile/ui/widgets/buttons/popup_menu.dart';

class TeamMember extends StatelessWidget {
  final bool isAdditional;
  final int numAdditional;
  final Preview model;

  const TeamMember(
      {Key key, this.isAdditional = false, this.numAdditional = 0, this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isAdditional) return;
        Navigator.of(context).pushNamed(
          Router.projectPage,
          arguments: {'infoModel': model},
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
            child: isAdditional
                ? CircleAvatar(
                    radius: 32.0,
                    child: Text('+$numAdditional'),
                    backgroundColor: CupertinoColors.lightBackgroundGray,
                  )
                : CachedNetworkImage(
                    imageUrl: model.imageUrl,
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
          ),
          if (!isAdditional) ...[
            const SizedBox(height: 4.0),
            Text(
              model.givenName.split(' ')[0],
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle,
            ),
          ],
        ],
      ),
    );
  }
}

class TeamMemberListTile extends StatelessWidget {
  final Preview model;
  final String startupName;
  final ProfileNotifier notifier;

  const TeamMemberListTile(
      {Key key, this.model, this.startupName, this.notifier})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(model.givenName),
      subtitle: Text('Team Member of $startupName'),
      leading: CachedNetworkImage(
        imageUrl: model.imageUrl,
        placeholder: (_, url) => CircleAvatar(
          radius: 25,
          backgroundColor: CupertinoColors.lightBackgroundGray,
        ),
        errorWidget: (_, url, error) => CircleAvatar(
          radius: 25,
          backgroundColor: CupertinoColors.lightBackgroundGray,
          child: Icon(Icons.error),
        ),
        imageBuilder: (context, image) {
          return CircleAvatar(
            radius: 25,
            backgroundImage: image,
          );
        },
      ),
      trailing: PopupMenuWithActions(
        onDelete: () async {
          await notifier.sendData(model);
        },
      ),
    );
  }
}
