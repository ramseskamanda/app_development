import 'package:flutter/material.dart';
import 'package:studentup/ui/profile/profile_picture.dart';
import 'package:studentup/ui/profile/profile_text.dart';

class ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ProfilePicture(),
          SizedBox(height: 16.0),
          ProfileText(),
        ],
      ),
    );
  }
}
