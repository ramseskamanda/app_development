import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_dev/models/education_model.dart';
import 'package:ui_dev/notifiers/view_notifiers/profile_notifier.dart';
import 'package:ui_dev/theme.dart';
import 'package:ui_dev/widgets/stadium_button.dart';

class ProfileEducationSection extends StatelessWidget {
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
                //TODO: add navigation here with a hero to show all
                Text(
                  'Education',
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
          StadiumButton.icon(
            text: 'Add Education',
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
    if (notifier.education.length < index + 1) return Container();
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
        child: Consumer<ProfileNotifier>(
          builder: (context, notifier, child) {
            if (notifier.isLoading || notifier.hasError) return Container();
            EducationModel model = notifier.education[index];
            return Column(
              children: <Widget>[
                ListTile(
                  title: Text(model.university),
                  subtitle: Text('${model.periodStart} - ${model.periodEnd}'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Spacer(),
                    FlutterLogo(),
                    Spacer(flex: 4),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '${model.degree} ${model.faculty}',
                          style: Theme.of(context).textTheme.body2,
                        ),
                        Text(
                          model.studyDescription,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
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
