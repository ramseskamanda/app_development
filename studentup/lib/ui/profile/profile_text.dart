import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:studentup/notifiers/userprofile_notifier.dart';

class ProfileText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileNotifier>(
      builder: (context, profile, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (profile.isLoading) ...[
              for (int _ in [0, 1, 2])
                Shimmer.fromColors(
                  baseColor: Theme.of(context).disabledColor,
                  highlightColor: Theme.of(context).backgroundColor,
                  child: Container(width: double.infinity, height: 16.0),
                ),
            ] else ...[
              Text(
                profile.name,
                style: Theme.of(context).textTheme.headline.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor,
                      fontSize: 28.0,
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.0),
              Text(
                'Maastricht University',
                style:
                    Theme.of(context).textTheme.title.copyWith(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 6.0),
              Text(
                'Maastricht, Netherlands',
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(fontWeight: FontWeight.w300, fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
            ]
          ],
        );
      },
    );
  }
}
