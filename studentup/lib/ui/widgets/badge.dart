import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:studentup/models/badge_model.dart';
import 'package:studentup/util/theme.dart';

class Badge extends StatelessWidget {
  final BadgeModel badge;
  final double radius;

  Badge({Key key, @required this.badge, this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _radius = this.radius ?? MediaQuery.of(context).size.width * 0.105;
    return Stack(
      children: <Widget>[
        Container(
          width: _radius * 2,
          height: _radius * 2,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(
                badge.photoUrl,
                errorListener: () =>
                    print('⚠️  [📸 CachedNetworkImageProvider Error]'),
              ),
              fit: BoxFit.cover,
            ),
            // 🔍 to see the other possibilities go to
            //  kElevationToShadow
            boxShadow: AppTheme.getSimpleBoxShadow(
              color: Theme.of(context).accentColor,
            ),
            shape: BoxShape.circle,
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: CircleAvatar(
            radius: MediaQuery.of(context).size.width * 0.035,
            backgroundColor: AppTheme.medalColors[badge.placement],
          ),
        ),
      ],
    );
  }
}
