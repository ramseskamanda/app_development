import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/models/education_model.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/profile_notifier.dart';
import 'package:studentup_mobile/router.dart';
import 'package:studentup_mobile/theme.dart';
import 'package:studentup_mobile/ui/widgets/buttons/stadium_button.dart';
import 'package:studentup_mobile/ui/widgets/screens/see_all.dart';

class ProfileEducationSection extends StatelessWidget {
  final bool isUser;

  const ProfileEducationSection({Key key, @required this.isUser})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<EducationModel>>(
        stream: Provider.of<ProfileNotifier>(context).education,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: const CircularProgressIndicator(),
              );
            return Center(
              child: Text('An Error Occured'),
            );
          }
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
                        'Education',
                        style: Theme.of(context).textTheme.title,
                      ),
                      if (snapshot.data.length > 0)
                        FlatButton(
                          child: const Text('See all'),
                          textColor: Theme.of(context).accentColor,
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) {
                                  return SeeAll<EducationModel>(
                                    title: 'Education',
                                    objects: snapshot.data,
                                    separator: const SizedBox(height: 16.0),
                                    builder: (context, index) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: EducationCard(
                                        model: snapshot.data[index],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                if (snapshot.data.length == 0)
                  Center(
                    child: const Text('No Education Added Yet!'),
                  )
                else
                  Column(
                    children: <Widget>[
                      if (snapshot.data.length > 0)
                        EducationCard(model: snapshot.data[0]),
                      const SizedBox(height: 8.0),
                      if (snapshot.data.length > 1)
                        EducationCard(model: snapshot.data[1]),
                      const SizedBox(height: 12.0),
                    ],
                  ),
                if (isUser)
                  StadiumButton.icon(
                    text: 'Add Education',
                    icon: Icons.add,
                    onPressed: () {
                      Navigator.of(context).pushNamed(Router.newEducation);
                    },
                  ),
              ],
            ),
          );
        });
  }
}

class EducationCard extends StatelessWidget {
  final EducationModel model;

  const EducationCard({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(model.university),
              subtitle: Text('${model.periodStart} - ${model.periodEnd}'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                Icon(
                  Icons.school,
                  color: Theme.of(context).accentColor,
                ),
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
        ),
      ),
    );
  }
}
