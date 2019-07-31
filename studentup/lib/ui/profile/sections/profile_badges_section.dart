import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ui_dev/models/badge_model.dart';
import 'package:ui_dev/theme.dart';

class ProfileBadgesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.width * 0.1;
    final int _length = 10;
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Badges',
                style: Theme.of(context).textTheme.title,
              ),
              FlatButton(
                child: const Text('See all'),
                textColor: Theme.of(context).accentColor,
                onPressed: () {},
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),
        SizedBox(
          height: _height * 2,
          child: ListView.separated(
            controller: ScrollController(),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: _length,
            separatorBuilder: (context, index) =>
                index == 0 ? Container() : const SizedBox(width: 8.0),
            itemBuilder: (context, index) => index == 0
                ? const SizedBox(width: 16.0)
                : SmallBadge(badge: BadgeModel(ranking: 1)),
          ),
        ),
      ],
    );
  }
}

class SmallBadge extends StatelessWidget {
  final BadgeModel badge;

  const SmallBadge({Key key, @required this.badge}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          CircleAvatar(
            radius: 24.0,
            backgroundImage: CachedNetworkImageProvider(
              badge.photoUrl,
              errorListener: () =>
                  print('⚠️  [📸 CachedNetworkImageProvider Error]'),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: CircleAvatar(
              radius: 8.0,
              backgroundColor: medalColors[badge.placement],
            ),
          ),
        ],
      ),
    );
  }
}
