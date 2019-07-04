import 'package:flutter/material.dart';
import 'package:studentup/models/badge_model.dart';
import 'package:studentup/ui/widgets/badge.dart';
import 'package:studentup/ui/widgets/section.dart';

class ProfileBadgesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.width * 0.088;
    return Section(
      title: Text(
        'Badges',
        style: Theme.of(context).textTheme.title,
      ),
      onMoreCallback: () {},
      child: SizedBox(
        height: _height * 2.2,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 8,
          separatorBuilder: (context, index) => const SizedBox(width: 12.0),
          itemBuilder: (context, index) {
            if (index == 0) return SizedBox(width: 16.0);
            return Badge(badge: BadgeModel(ranking: 2), radius: _height);
          },
        ),
      ),
    );
  }
}
