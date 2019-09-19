import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/profile_notifier.dart';
import 'package:studentup_mobile/ui/profile/user_information/profile_picture.dart';
import 'package:studentup_mobile/ui/startup_profile/startup_profile_text.dart';
import 'package:studentup_mobile/ui/startup_profile/startup_project_section.dart';
import 'package:studentup_mobile/ui/startup_profile/startup_team.dart';

class StartUpProfile extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> _key;

  StartUpProfile({Key key})
      : _key = GlobalKey<RefreshIndicatorState>(),
        super(key: key);

  Future<void> _onRefresh(BuildContext context) async {
    ProfileNotifier profileNotifier = Provider.of(context);
    profileNotifier.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: LiquidPullToRefresh(
          key: _key,
          onRefresh: () => _onRefresh(context),
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  const SizedBox(height: 32.0),
                  ProfilePicture(),
                  const SizedBox(height: 12.0),
                  StartupProfileText(),
                  const SizedBox(height: 24.0),
                  StartupTeam(),
                  const SizedBox(height: 32.0),
                  StartupProjectSection(ongoing: true),
                  const SizedBox(height: 32.0),
                  StartupProjectSection(ongoing: false),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
