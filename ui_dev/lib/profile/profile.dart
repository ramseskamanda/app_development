import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:studentup/ui/profile/sections/profile_skill_section.dart';
import 'package:studentup/ui/profile/user_information/profile_picture.dart';
import 'package:studentup/ui/profile/user_information/profile_text.dart';
import 'package:studentup/ui/profile/user_information/profile_head.dart';
import 'package:studentup/ui/profile/sections/profile_badges_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> _key =
      GlobalKey<RefreshIndicatorState>();

  Future<void> _onRefresh() async {
    Future.delayed(Duration(seconds: 1), () => print('Refreshed'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        leading: Center(
          child: InkWell(
            radius: 80.0,
            customBorder: CircleBorder(),
            onTap: () => print('Edit Profile'),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'Edit',
                softWrap: false,
                style: Theme.of(context).textTheme.button.copyWith(
                    color: CupertinoColors.activeBlue, fontSize: 18.0),
              ),
            ),
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
      body: LiquidPullToRefresh(
        key: _key,
        height: 50.0,
        showChildOpacityTransition: true,
        onRefresh: _onRefresh,
        child: ListView(
          children: <Widget>[
            ProfilePicture(),
            const SizedBox(height: 16.0),
            ProfileText(),
            const SizedBox(height: 16.0),
            ProfileBadges(),
            const SizedBox(height: 48.0),
            ProfileAboutCard(),
            const SizedBox(height: 32.0),
            ProfileBadgesSection(),
            const SizedBox(height: 32.0),
            ProfileSkillSection(),
            const SizedBox(height: 32.0),
            ProfileBadgesSection(),
          ],
        ),
      ),
    );
  }
}
