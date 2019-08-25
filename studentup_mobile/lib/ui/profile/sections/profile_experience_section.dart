import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/models/labor_experience_model.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/profile_notifier.dart';
import 'package:studentup_mobile/theme.dart';
import 'package:studentup_mobile/ui/widgets/buttons/stadium_button.dart';

class ProfileExperienceSection extends StatelessWidget {
  final bool isUser;

  const ProfileExperienceSection({Key key, @required this.isUser})
      : super(key: key);
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
          EducationCard(index: 0),
          const SizedBox(height: 8.0),
          EducationCard(index: 1),
          const SizedBox(height: 12.0),
          if (isUser)
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
  final int index;

  const EducationCard({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileNotifier notifier = Provider.of(context);
    if (notifier.experience.length < index + 1) return Container();
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
        padding: const EdgeInsets.only(
          left: 8.0,
          right: 8.0,
          top: 8.0,
          bottom: 24.0,
        ),
        child: Consumer<ProfileNotifier>(
          builder: (context, notifier, child) {
            if (notifier.isLoading || notifier.hasError) return Container();
            LaborExeprienceModel model = notifier.experience[index];
            return Column(
              children: <Widget>[
                ListTile(
                  title: Text(model.companyName),
                  subtitle: Text('${model.periodStart} - ${model.periodEnd}'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Spacer(),
                    FlutterLogo(),
                    Spacer(flex: 4),
                    Text(
                      model.position,
                      style: Theme.of(context).textTheme.body2,
                    ),
                    Spacer(),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
