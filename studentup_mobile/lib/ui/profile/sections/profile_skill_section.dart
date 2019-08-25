import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/models/skills_model.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/profile_notifier.dart';
import 'package:studentup_mobile/theme.dart';
import 'package:studentup_mobile/ui/widgets/buttons/stadium_button.dart';

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
          SkillCard(index: 0),
          const SizedBox(height: 8.0),
          SkillCard(index: 1),
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
  final int index;

  const SkillCard({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileNotifier>(
      builder: (context, notifier, child) {
        if (notifier.skills.length < index + 1) return Container();
        SkillsModel model = notifier.skills[index];

        return Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
            boxShadow: StudentupTheme.getSimpleBoxShadow(
              color: Theme.of(context).accentColor,
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: ListTile(
              title: Text(model.name),
              subtitle: Text(model.description),
              onTap: () => print('😄'),
              trailing: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  model.avgRating.toString(),
                  style: Theme.of(context).textTheme.display1.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
