import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/models/labor_experience_model.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/profile_notifier.dart';
import 'package:studentup_mobile/router.dart';
import 'package:studentup_mobile/services/authentication/base_auth.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/services/storage/base_api.dart';
import 'package:studentup_mobile/theme.dart';
import 'package:studentup_mobile/ui/widgets/buttons/popup_menu.dart';
import 'package:studentup_mobile/ui/widgets/buttons/stadium_button.dart';

class ProfileExperienceSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProfileNotifier notifier = Provider.of<ProfileNotifier>(context);
    return StreamBuilder<List<LaborExeprienceModel>>(
      stream: notifier.experience,
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
                      'Experience',
                      style: Theme.of(context).textTheme.title,
                    ),
                    if (snapshot.data.length > 0)
                      FlatButton(
                        child: const Text('See all'),
                        textColor: Theme.of(context).accentColor,
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            Router.seeAll,
                            arguments: {
                              'stream': Provider.of<ProfileNotifier>(context)
                                  .experience,
                              'separator': const SizedBox(height: 16.0),
                              'title': 'Experience',
                              'type': LaborExeprienceModel,
                              'emptyBuilder': Center(
                                child:
                                    const Text('No Work Experience Added Yet!'),
                              ),
                            },
                          );
                        },
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              if (snapshot.data.length == 0)
                Center(
                  child: const Text('No Experience Added Yet!'),
                )
              else
                Column(
                  children: <Widget>[
                    if (snapshot.data.length > 0)
                      ExperienceCard(model: snapshot.data[0]),
                    const SizedBox(height: 8.0),
                    if (snapshot.data.length > 1)
                      ExperienceCard(model: snapshot.data[1]),
                    const SizedBox(height: 12.0),
                  ],
                ),
              const SizedBox(height: 12.0),
              if (notifier.preview.uid == Locator.of<BaseAuth>().currentUserId)
                StadiumButton.icon(
                  text: 'Add Experience',
                  icon: Icons.add,
                  onPressed: () =>
                      Navigator.of(context).pushNamed(Router.newExperience),
                ),
            ],
          ),
        );
      },
    );
  }
}

class ExperienceCard extends StatelessWidget {
  final LaborExeprienceModel model;

  const ExperienceCard({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
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
              title: Text(model.companyName),
              subtitle: Text('${model.periodStart} - ${model.periodEnd}'),
              trailing: (!model.canEdit)
                  ? null
                  : PopupMenuWithActions(
                      onDelete: () async => await Locator.of<BaseAPIWriter>()
                          .removeExperience(model),
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                Icon(
                  Icons.business_center,
                  color: Theme.of(context).accentColor,
                ),
                Spacer(flex: 4),
                Text(
                  model.position,
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
