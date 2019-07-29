import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_dev/stadium_button.dart';
import 'package:ui_dev/theme.dart';

class ProfileSkillSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SkillCard(),
          SizedBox(height: 8.0),
          SkillCard(),
          SizedBox(height: 12.0),
          StadiumButton.icon(
            text: 'Add Skill',
            icon: CupertinoIcons.add,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class SkillCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.0),
        boxShadow: getSimpleBoxShadow(
          color: Theme.of(context).accentColor,
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.15,
        child: Center(
          child: ListTile(
            title: const Text('Title'),
            subtitle: const Text('Lorem ipsum dolor sit amet'),
            onTap: () => print('😄'),
            trailing: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                '7',
                style: Theme.of(context).textTheme.display1.copyWith(
                      fontWeight: FontWeight.w300,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
