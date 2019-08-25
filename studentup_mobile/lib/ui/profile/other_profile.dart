import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentup_mobile/models/user_info_model.dart';
import 'package:studentup_mobile/ui/profile/contact_options.dart';
import 'package:studentup_mobile/ui/profile/sections/profile_education_section.dart';
import 'package:studentup_mobile/ui/profile/sections/profile_experience_section.dart';
import 'package:studentup_mobile/ui/profile/sections/profile_skill_section.dart';
import 'package:studentup_mobile/ui/profile/user_information/profile_head.dart';
import 'package:studentup_mobile/ui/profile/user_information/profile_picture.dart';
import 'package:studentup_mobile/ui/profile/user_information/profile_text.dart';

class OtherProfile extends StatelessWidget {
  final UserInfoModel infoModel;
  final bool fromMessaging;

  OtherProfile({Key key, @required this.infoModel, this.fromMessaging = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        title: Text(infoModel.givenName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 16.0),
            ProfilePicture(),
            const SizedBox(height: 16.0),
            ProfileText(),
            const SizedBox(height: 16.0),
            if (!fromMessaging)
              ContactOptions(),
            const SizedBox(height: 16.0),
            // ProfileBadges(),
            // const SizedBox(height: 48.0),
            ProfileAboutCard(),
            const SizedBox(height: 32.0),
            ProfileSkillSection(isUser: false),
            const SizedBox(height: 32.0),
            ProfileEducationSection(isUser: false),
            const SizedBox(height: 32.0),
            ProfileExperienceSection(isUser: false),
            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}
