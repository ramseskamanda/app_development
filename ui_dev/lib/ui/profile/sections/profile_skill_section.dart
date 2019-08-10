import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_dev/theme.dart';
import 'package:ui_dev/widgets/stadium_button.dart';

class ProfileSkillSection extends StatelessWidget {
  final bool isUser;

  const ProfileSkillSection({Key key, @required this.isUser}) : super(key: key);
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
                  'Skills',
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
          SkillCard(),
          const SizedBox(height: 8.0),
          SkillCard(),
          const SizedBox(height: 12.0),
          if (isUser)
            StadiumButton.icon(
              text: 'Add Skill',
              icon: Icons.add,
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
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.0),
        boxShadow: getSimpleBoxShadow(
          color: Theme.of(context).accentColor,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: ListTile(
          title: const Text('Marketing'),
          subtitle: const Text(
            'Lorem ipsum dolor sit amet, consectetuer apidiscing elit.',
          ),
          onTap: () => print('😄'),
          trailing: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '7',
              style: Theme.of(context).textTheme.display1.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
