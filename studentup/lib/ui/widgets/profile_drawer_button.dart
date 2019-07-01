import 'package:cached_network_image/cached_network_image.dart';
import 'package:studentup/util/env.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:provider/provider.dart';

class ProfileDrawerButton extends StatelessWidget {
  const ProfileDrawerButton({Key key}) : super(key: key);

  Widget _buildIcon(BuildContext context) {
    //UserProfile _user = Provider.of<UserProfile>(context);
    if ('_user.photoUrl' != Environment.defaultPhotoUrl)
      return const Icon(CupertinoIcons.profile_circled);
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: '_user.photoUrl',
        placeholder: (_, __) => const Icon(CupertinoIcons.profile_circled),
        errorWidget: (_, __, ___) => const Icon(CupertinoIcons.profile_circled),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<InnerDrawerState> _drawerKey =
        Provider.of<GlobalKey<InnerDrawerState>>(context);
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: _buildIcon(context),
      ),
      onTap: _drawerKey.currentState.open,
    );
  }
}
