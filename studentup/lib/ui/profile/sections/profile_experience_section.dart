import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_dev/stadium_button.dart';
import 'package:ui_dev/theme.dart';

class ProfileExperienceSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Experience',
                  style: Theme.of(context).textTheme.title,
                ),
                FlatButton(
                  child: const Text('See all'),
                  textColor: Theme.of(context).accentColor,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          EducationCard(),
          const SizedBox(height: 8.0),
          EducationCard(),
          const SizedBox(height: 12.0),
          StadiumButton.icon(
            text: 'Add Experience',
            icon: Icons.add,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class EducationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.0),
        boxShadow: getSimpleBoxShadow(
          color: Theme.of(context).accentColor,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
          right: 8.0,
          top: 8.0,
          bottom: 24.0,
        ),
        child: Column(
          children: <Widget>[
            ListTile(
              title: const Text('Maastricht University'),
              subtitle: const Text('Jun 2019 - now'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                FlutterLogo(),
                Spacer(flex: 4),
                Text(
                  'Chief Marketing Officer',
                  style: Theme.of(context).textTheme.body2,
                ),
                Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
