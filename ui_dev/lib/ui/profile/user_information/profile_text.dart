import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:ui_dev/notifiers/view_notifiers/profile_notifier.dart';

class ProfileText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48.0),
          child: Consumer<ProfileNotifier>(
            builder: (context, notifier, child) {
              if (notifier.isLoading || notifier.hasError)
                return const SizedBox(height: 24.0);
              return Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Spacer(),
                      Text('Lvl. ${notifier.info.experienceOverall ~/ 25}'),
                      Spacer(flex: 20),
                      Text('${notifier.info.experienceMonthly} XP this month'),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  LinearPercentIndicator(
                    lineHeight: 8.0,
                    percent: notifier.info.experienceOverall /
                        (notifier.info.experienceOverall / 25) /
                        100,
                    progressColor: Theme.of(context).accentColor,
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 16.0),
        Consumer<ProfileNotifier>(
          builder: (context, notifier, child) {
            if (notifier.isLoading || notifier.hasError)
              return Container(
                height: 24.0,
                color: CupertinoColors.extraLightBackgroundGray,
              );
            return Text(
              notifier.info.givenName,
              style: Theme.of(context).textTheme.headline.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).accentColor,
                    fontSize: 28.0,
                  ),
              textAlign: TextAlign.center,
            );
          },
        ),
        const SizedBox(height: 16.0),
        Consumer<ProfileNotifier>(
          builder: (context, notifier, child) {
            if (notifier.isLoading || notifier.hasError)
              return Container(
                height: 24.0,
                color: CupertinoColors.extraLightBackgroundGray,
              );
            return Text(
              notifier.info.university,
              style: Theme.of(context).textTheme.title.copyWith(fontSize: 20.0),
              textAlign: TextAlign.center,
            );
          },
        ),
        const SizedBox(height: 6.0),
        Consumer<ProfileNotifier>(
          builder: (context, notifier, child) {
            if (notifier.isLoading || notifier.hasError)
              return Container(
                height: 24.0,
                color: CupertinoColors.extraLightBackgroundGray,
              );
            return Text(
              notifier.info.locationString,
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(fontWeight: FontWeight.w300, fontSize: 18.0),
              textAlign: TextAlign.center,
            );
          },
        ),
      ],
    );
  }
}
