import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_dev/notifiers/view_notifiers/profile_notifier.dart';

class ProfilePicture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double _kDefaultSize = MediaQuery.of(context).size.width * 0.36;
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        CircleAvatar(
          radius: (_kDefaultSize * 1.05) / 2,
          backgroundColor: Theme.of(context).accentColor,
        ),
        Hero(
          tag: 'profile_picture',
          child: Consumer<ProfileNotifier>(
            builder: (context, notifier, child) {
              if (notifier.isLoading)
                return Center(child: CircularProgressIndicator());
              if (notifier.hasError) return Center(child: Icon(Icons.error));
              return CachedNetworkImage(
                imageUrl: notifier.info.mediaRef,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    Center(child: Icon(Icons.error)),
                imageBuilder: (context, image) {
                  return CircleAvatar(
                    radius: _kDefaultSize / 2,
                    backgroundImage: image,
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
