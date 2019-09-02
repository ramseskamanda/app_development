import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/models/chat_model.dart';
import 'package:studentup_mobile/models/startup_info_model.dart';
import 'package:studentup_mobile/models/user_info_model.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/profile_notifier.dart';
import 'package:studentup_mobile/ui/startup_profile/team_member.dart';

class StartupTeam extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileNotifier>(
      builder: (context, notifier, child) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.67,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Team',
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  StreamBuilder<StartupInfoModel>(
                    stream: notifier.startupInfoStream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        if (snapshot.connectionState == ConnectionState.waiting)
                          return Center(child: CircularProgressIndicator());
                        return Center(child: const Text('An Error Occured.'));
                      }

                      if (snapshot.data.team.length < 4) return Container();
                      return FlatButton(
                        child: Text(
                          'See all',
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                        ),
                        onPressed: () => print('object'),
                      );
                    },
                  ),
                ],
              ),
              Divider(),
              StreamBuilder<StartupInfoModel>(
                stream: notifier.startupInfoStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Center(child: CircularProgressIndicator());
                    return Center(child: const Text('An Error Occured.'));
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      if (snapshot.data.team.length <= 3) ...[
                        for (Preview member in snapshot.data.team)
                          TeamMember(model: member)
                      ] else ...[
                        for (int i in [0, 1, 2])
                          TeamMember(model: snapshot.data.team[i]),
                        TeamMember(
                          isAdditional: true,
                          numAdditional: snapshot.data.team.length - 3,
                        ),
                      ]
                    ],
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
