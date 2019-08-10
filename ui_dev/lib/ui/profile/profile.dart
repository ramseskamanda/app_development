import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_dev/notifiers/view_notifiers/profile_notifier.dart';
import 'package:ui_dev/ui/profile/account_switch.dart';
import 'package:ui_dev/ui/profile/edit_profile.dart';
import 'package:ui_dev/ui/profile/sections/profile_education_section.dart';
import 'package:ui_dev/ui/profile/sections/profile_experience_section.dart';
import 'package:ui_dev/ui/profile/sections/profile_skill_section.dart';
import 'package:ui_dev/ui/profile/user_information/profile_head.dart';
import 'package:ui_dev/ui/profile/user_information/profile_picture.dart';
import 'package:ui_dev/ui/profile/user_information/profile_text.dart';

class Profile extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> _key;

  Profile({Key key, String userId})
      : _key = GlobalKey<RefreshIndicatorState>(),
        super(key: key);

  Future<void> _onRefresh(BuildContext context) async {
    ProfileNotifier profileNotifier = Provider.of(context);
    profileNotifier.onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        title: AccountSwitch(),
        leading: FittedBox(
          child: IconButton(
            icon: Text(
              'Edit',
              softWrap: false,
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(color: CupertinoColors.activeBlue),
            ),
            onPressed: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => ProfileEditor(),
                ),
              );
            },
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              CupertinoIcons.settings,
              size: 32.0,
            ),
            onPressed: () => print('notifications settings'),
          ),
        ],
      ),
      body: SafeArea(
        child: LiquidPullToRefresh(
          key: _key,
          height: 50.0,
          showChildOpacityTransition: true,
          onRefresh: () => _onRefresh(context),
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 16.0),
              ProfilePicture(),
              const SizedBox(height: 16.0),
              ProfileText(),
              const SizedBox(height: 16.0),
              // ProfileBadges(),
              // const SizedBox(height: 48.0),
              ProfileAboutCard(),
              const SizedBox(height: 32.0),
              ProfileSkillSection(isUser: true),
              const SizedBox(height: 32.0),
              ProfileEducationSection(isUser: true),
              const SizedBox(height: 32.0),
              ProfileExperienceSection(isUser: true),
              const SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    );
  }
}
