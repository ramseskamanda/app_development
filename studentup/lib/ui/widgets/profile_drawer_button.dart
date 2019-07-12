import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:studentup/notifiers/userprofile_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileDrawerButton extends StatelessWidget {
  const ProfileDrawerButton({Key key}) : super(key: key);

  Widget _buildIcon(BuildContext context) {
    return Consumer<UserProfileNotifier>(
      builder: (context, profile, child) {
        if (profile.isLoading)
          return Shimmer.fromColors(
            baseColor: Theme.of(context).disabledColor,
            highlightColor: Theme.of(context).backgroundColor,
            child: Icon(CupertinoIcons.profile_circled),
          );
        else if (profile.hasError)
          return Icon(CupertinoIcons.profile_circled);
        else {
          //print(profile.photoUrl);
          return ClipOval(
            child: CachedNetworkImage(
              imageUrl: profile.photoUrl,
              placeholder: (_, __) => Icon(CupertinoIcons.profile_circled),
              errorWidget: (_, __, ___) => Icon(CupertinoIcons.profile_circled),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: _buildIcon(context),
      ),
      onPressed: () => print('open drawer'),
    );
  }
}
