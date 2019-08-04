import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_dev/notifiers/view_notifiers/profile_notifier.dart';
import 'package:ui_dev/test_data.dart';
import 'package:ui_dev/ui/profile/account_switch.dart';
import 'package:ui_dev/ui/profile/contact_options.dart';
import 'package:ui_dev/ui/profile/edit_profile.dart';
import 'package:ui_dev/ui/profile/sections/profile_education_section.dart';
import 'package:ui_dev/ui/profile/sections/profile_experience_section.dart';
import 'package:ui_dev/ui/profile/sections/profile_skill_section.dart';
import 'package:ui_dev/ui/profile/user_information/profile_head.dart';
import 'package:ui_dev/ui/profile/user_information/profile_picture.dart';
import 'package:ui_dev/ui/profile/user_information/profile_text.dart';

class Profile extends StatelessWidget {
  final String uid;
  final GlobalKey<RefreshIndicatorState> _key;

  Profile({Key key, String userId})
      : _key = GlobalKey<RefreshIndicatorState>(),
        uid = userId ?? TestData.userId,
        super(key: key);

  Future<void> _onRefresh(BuildContext context) async {
    ProfileNotifier profileNotifier = Provider.of(context);
    profileNotifier.onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileNotifier>.value(
      value: uid == TestData.userId
          ? Provider.of<ProfileNotifier>(context)
          : ProfileNotifier(uid: uid),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0.0,
          title: uid == TestData.userId ? AccountSwitch() : null,
          leading: uid == TestData.userId
              ? FittedBox(
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
                )
              : null,
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
                if (uid != TestData.userId) ContactOptions(),
                const SizedBox(height: 16.0),
                ProfileBadges(),
                const SizedBox(height: 48.0),
                ProfileAboutCard(),
                const SizedBox(height: 32.0),
                ProfileSkillSection(),
                const SizedBox(height: 32.0),
                ProfileEducationSection(),
                const SizedBox(height: 32.0),
                ProfileExperienceSection(),
                const SizedBox(height: 32.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
