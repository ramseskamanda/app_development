import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/models/startup_info_model.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/profile_notifier.dart';

class StartupProfileText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileNotifier>(
      builder: (context, notifier, child) {
        return StreamBuilder<StartupInfoModel>(
          stream: notifier.startupInfoStream,
          builder: (context, snapshot) {
            return Column(
              children: <Widget>[
                Text(
                  snapshot.hasData
                      ? snapshot.data.name
                      : snapshot.hasError ? 'Name Error' : 'Loading...',
                  style: Theme.of(context).textTheme.headline.copyWith(
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.black,
                      ),
                ),
                const SizedBox(height: 12.0),
                Text(
                  snapshot.hasData
                      ? snapshot.data.locationString
                      : snapshot.hasError ? 'Location Error' : 'Loading...',
                  style: Theme.of(context)
                      .textTheme
                      .subhead
                      .copyWith(color: CupertinoColors.inactiveGray),
                ),
                const SizedBox(height: 12.0),
                Container(
                  width: MediaQuery.of(context).size.width * 0.67,
                  child: Text(
                    snapshot.hasData
                        ? snapshot.data.description
                        : snapshot.hasError ? 'Location Error' : 'Loading...',
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle.copyWith(
                        color: CupertinoColors.black,
                        fontStyle: FontStyle.italic),
                  ),
                ),
                const SizedBox(height: 12.0),
                Text(
                  snapshot.hasData
                      ? snapshot.data.website
                      : snapshot.hasError ? 'Location Error' : 'Loading...',
                  style: Theme.of(context)
                      .textTheme
                      .subhead
                      .copyWith(color: Theme.of(context).accentColor),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
