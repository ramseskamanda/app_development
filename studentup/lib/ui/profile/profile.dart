import 'package:studentup/ui/profile/sections/profile_skill_section.dart';
import 'package:studentup/ui/profile/user_information/profile_picture.dart';
import 'package:studentup/ui/profile/user_information/profile_text.dart';
import 'package:studentup/ui/profile/user_information/profile_head.dart';
import 'package:studentup/ui/profile/sections/profile_badges_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            snap: true,
            floating: true,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: false,
            title: null,
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
          SliverPadding(
            padding: EdgeInsets.only(
              top: 16.0,
              bottom: MediaQuery.of(context).size.height * 0.11,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
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
          ),
        ],
      ),
    );
  }
}
/* 
appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: _drawerKey.currentState.open,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Material(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: 16.0,
                bottom: MediaQuery.of(context).size.height * 0.11,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
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
          ),
        ),
      ), */
