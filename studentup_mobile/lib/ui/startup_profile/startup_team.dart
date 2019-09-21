import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/models/chat_model.dart';
import 'package:studentup_mobile/models/startup_info_model.dart';
import 'package:studentup_mobile/models/user_info_model.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/profile_notifier.dart';
import 'package:studentup_mobile/router.dart';
import 'package:studentup_mobile/services/authentication/base_auth.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/ui/startup_profile/team_member.dart';
import 'package:studentup_mobile/ui/startup_profile/team_member_search.dart';
import 'package:studentup_mobile/ui/widgets/buttons/stadium_button.dart';

class StartupTeam extends StatelessWidget {
  _addMember(BuildContext context, ProfileNotifier notifier) async {
    final result = await showSearch<UserInfoModel>(
      context: context,
      delegate: TeamMemberSearchDelegate(),
    );
    if (result == null) return;
    notifier.sendData(result);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileNotifier>(
      builder: (context, notifier, child) {
        return StreamBuilder<StartupInfoModel>(
          stream: notifier.startupInfoStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(child: CircularProgressIndicator());
              return Center(child: const Text('An Error Occured.'));
            }
            if (notifier.preview.uid == Locator.of<BaseAuth>().currentUserId &&
                snapshot.data.team.isEmpty)
              return StadiumButton.icon(
                icon: Icons.add,
                text: 'Add Team',
                onPressed: () => _addMember(
                  context,
                  Provider.of<ProfileNotifier>(context),
                ),
              );
            return Column(
              children: <Widget>[
                Container(
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
                          FlatButton(
                            child: Text(
                              'See all',
                              style: TextStyle(
                                  color: Theme.of(context).accentColor),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                Router.seeAll,
                                arguments: {
                                  'stream': notifier.startupInfoStream,
                                  'separator': const SizedBox(height: 16.0),
                                  'title':
                                      '${snapshot.data.name}${snapshot.data.name.endsWith('s') ? '\'' : '\'s'} Team',
                                  'type': StartupInfoModel,
                                  'emptyBuilder': Center(
                                    child: const Text(
                                        'No Team Members Added Yet!'),
                                  ),
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      Divider(),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (snapshot.data.team.length <= 3) ...[
                      for (Preview member in snapshot.data.team) ...[
                        TeamMember(model: member),
                        const SizedBox(width: 6.0),
                      ],
                    ] else ...[
                      for (int i in [0, 1, 2]) ...[
                        TeamMember(model: snapshot.data.team[i]),
                        const SizedBox(width: 6.0),
                      ],
                      TeamMember(
                        isAdditional: true,
                        numAdditional: snapshot.data.team.length - 3,
                      ),
                    ]
                  ],
                ),
                const SizedBox(height: 8.0),
                if (snapshot.data.isUser) ...[
                  if (snapshot.data.team.length > 0)
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.67),
                      child: StadiumButton.icon(
                        icon: Icons.add,
                        text: 'Add Team Member',
                        onPressed: () => _addMember(
                          context,
                          Provider.of<ProfileNotifier>(context),
                        ),
                      ),
                    ),
                ],
              ],
            );
          },
        );
      },
    );
  }
}
