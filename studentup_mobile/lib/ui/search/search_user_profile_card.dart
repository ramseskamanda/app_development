import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentup_mobile/models/chat_model.dart';
import 'package:studentup_mobile/models/user_info_model.dart';
import 'package:studentup_mobile/router.dart';
import 'package:studentup_mobile/ui/widgets/dialogs/dialogs.dart';

class UserProfileCard extends StatelessWidget {
  final UserInfoModel model;

  const UserProfileCard({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          Router.otherProfile,
          arguments: {
            'infoModel': Preview(
              givenName: model.givenName,
              imageUrl: model.mediaRef,
              uid: model.docId,
              isStartup: false,
            ),
          },
        );
      },
      child: Card(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: model.mediaRef,
                  fit: BoxFit.cover,
                  placeholder: (context, url) {
                    return CircularProgressIndicator();
                  },
                  errorWidget: (context, url, error) {
                    return Icon(Icons.error);
                  },
                  imageBuilder: (context, imageProvider) {
                    return CircleAvatar(
                      radius: 32.0,
                      backgroundImage: imageProvider,
                    );
                  },
                ),
                Text(
                  model.givenName,
                  softWrap: true,
                  style: Theme.of(context).textTheme.subtitle,
                  textAlign: TextAlign.center,
                ),
                Text(
                  model.university,
                  softWrap: true,
                  style: Theme.of(context).textTheme.caption,
                  textAlign: TextAlign.center,
                ),
                RaisedButton(
                  child: const Text('Contact'),
                  color: Theme.of(context).accentColor,
                  textColor: CupertinoColors.white,
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      Router.newMessage,
                      arguments: {
                        'model': model,
                        'fromMessaging': true,
                      },
                    );
                  },
                ),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(CupertinoIcons.heart),
                onPressed: () => Dialogs.showComingSoon(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
