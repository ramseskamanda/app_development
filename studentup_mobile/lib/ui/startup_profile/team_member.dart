import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentup_mobile/models/chat_model.dart';
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
          Router.otherProfile,
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

class TeamListTile extends StatelessWidget {
  final Preview user;
  final String startupName;
  final void Function() onDelete;

  const TeamListTile({Key key, this.user, this.startupName, this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListTile(
        onTap: () {
          Navigator.of(context).pushNamed(
            Router.otherProfile,
            arguments: {'infoModel': user},
          );
        },
        title: Text(user.givenName),
        subtitle: Text('Team Member of $startupName'),
        leading: CachedNetworkImage(
          imageUrl: user.imageUrl,
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
        trailing: onDelete == null
            ? null
            : PopupMenuWithActions(
                onDelete: onDelete,
              ),
      ),
    );
  }
}
