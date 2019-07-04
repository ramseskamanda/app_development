import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:studentup/notifiers/userprofile_notifier.dart';

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
        Consumer<UserProfileNotifier>(
          builder: (context, profile, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                if (profile.isLoading) ...[
                  Shimmer.fromColors(
                    baseColor: Theme.of(context).iconTheme.color,
                    highlightColor: Theme.of(context).accentColor,
                    child: Icon(
                      CupertinoIcons.profile_circled,
                      size: _kDefaultSize,
                    ),
                  ),
                ] else if (profile.hasError) ...[
                  Icon(
                    CupertinoIcons.profile_circled,
                    size: _kDefaultSize,
                  ),
                ] else ...[
                  CircleAvatar(
                    radius: _kDefaultSize / 2,
                    backgroundImage: CachedNetworkImageProvider(
                      profile.photoUrl,
                      errorListener: () =>
                          print('⚠️  [📸 CachedNetworkImageProvider Error]'),
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ],
    );
  }
}
