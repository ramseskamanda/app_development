import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/models/skills_model.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/profile_notifier.dart';
import 'package:studentup_mobile/router.dart';
import 'package:studentup_mobile/theme.dart';
import 'package:studentup_mobile/ui/widgets/buttons/stadium_button.dart';
import 'package:studentup_mobile/ui/widgets/screens/see_all.dart';

class ProfileSkillSection extends StatelessWidget {
  final bool isUser;

  const ProfileSkillSection({Key key, @required this.isUser}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<SkillsModel>>(
      stream: Provider.of<ProfileNotifier>(context).skills,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: const CircularProgressIndicator(),
            );
          return Center(
            child: Text('An Error Occured.'),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Skills',
                      style: Theme.of(context).textTheme.title,
                    ),
                    if (snapshot.data.length > 2) ...[
                      Spacer(),
                      FlatButton(
                        child: const Text('See all'),
                        textColor: Theme.of(context).accentColor,
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) {
                                return SeeAll<SkillsModel>(
                                  title: 'Skills',
                                  objects: snapshot.data,
                                  separator: const SizedBox(height: 16.0),
                                  builder: (context, index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: SkillCard(
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
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              if (snapshot.data.length == 0)
                Center(
                  child: const Text('No Skills Added Yet!'),
                )
              else
                Column(
                  children: <Widget>[
                    if (snapshot.data.length > 0)
                      SkillCard(model: snapshot.data[0]),
                    const SizedBox(height: 8.0),
                    if (snapshot.data.length > 1)
                      SkillCard(model: snapshot.data[1]),
                    const SizedBox(height: 12.0),
                  ],
                ),
              const SizedBox(height: 12.0),
              if (isUser)
                StadiumButton.icon(
                  text: 'Add Skill',
                  icon: Icons.add,
                  onPressed: () =>
                      Navigator.of(context).pushNamed(Router.newSkill),
                ),
            ],
          ),
        );
      },
    );
  }
}

class SkillCard extends StatelessWidget {
  final SkillsModel model;

  const SkillCard({Key key, this.model}) : super(key: key);

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
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: ListTile(
          title: Text(model.name),
          subtitle: Text(model.description),
          //TODO: fix this to only be available if user is NOT the owner and hasn't voted yet
          onTap: null,
          // () => Dialogs.showRatingFor(context, model.name, Icons.work),
          // trailing: Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       Text(
          //         'Rating:',
          //         style: Theme.of(context).textTheme.caption,
          //       ),
          //       Text(
          //         model.avgRating.toString(),
          //         style: Theme.of(context).textTheme.display1.copyWith(
          //               fontWeight: FontWeight.w600,
          //             ),
          //       ),
          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }
}
