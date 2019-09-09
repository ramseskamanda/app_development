import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/profile_notifier.dart';
import 'package:studentup_mobile/ui/profile/sections/profile_education_section.dart';
import 'package:studentup_mobile/ui/profile/sections/profile_experience_section.dart';
import 'package:studentup_mobile/ui/profile/sections/profile_skill_section.dart';
import 'package:studentup_mobile/ui/profile/user_information/profile_head.dart';
import 'package:studentup_mobile/ui/profile/user_information/profile_picture.dart';
import 'package:studentup_mobile/ui/profile/user_information/profile_text.dart';

class Profile extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> _key;

  Profile({Key key, String userId})
      : _key = GlobalKey<RefreshIndicatorState>(),
        super(key: key);

  Future<void> _onRefresh(BuildContext context) async {
    ProfileNotifier profileNotifier = Provider.of(context);
    profileNotifier.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
    );
  }
}
