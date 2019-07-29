import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        CircleAvatar(
          radius: _kDefaultSize / 2,
          backgroundImage: CachedNetworkImageProvider(
            'https://via.placeholder.com/150',
            errorListener: () =>
                print('⚠️  [📸 CachedNetworkImageProvider Error]'),
          ),
        ),
      ],
    );
  }
}
