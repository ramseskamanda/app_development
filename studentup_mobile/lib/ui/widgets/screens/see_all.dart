import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/models/education_model.dart';
import 'package:studentup_mobile/models/labor_experience_model.dart';
import 'package:studentup_mobile/models/project_model.dart';
import 'package:studentup_mobile/models/skills_model.dart';
import 'package:studentup_mobile/models/startup_info_model.dart';
import 'package:studentup_mobile/models/think_tank_model.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/profile_notifier.dart';
import 'package:studentup_mobile/ui/home/feed/think_tanks.dart';
import 'package:studentup_mobile/ui/profile/sections/profile_education_section.dart';
import 'package:studentup_mobile/ui/profile/sections/profile_experience_section.dart';
import 'package:studentup_mobile/ui/profile/sections/profile_skill_section.dart';
import 'package:studentup_mobile/ui/projects/projects_root.dart';
import 'package:studentup_mobile/ui/startup_profile/team_member.dart';

class SeeAll extends StatelessWidget {
  final Stream stream;
  final Type type;
  final Widget separator;
  final String title;
  final Widget emptyBuilder;
  final FloatingActionButton floatingActionButton;

  const SeeAll({
    Key key,
    @required this.separator,
    @required this.title,
    @required this.stream,
    @required this.type,
    @required this.emptyBuilder,
    this.floatingActionButton,
  }) : super(key: key);

  int _lengthCalculator(AsyncSnapshot snapshot) {
    switch (type) {
      case ThinkTankModel:
        final List<ThinkTankModel> data = snapshot.data;
        return data.length;
      case ProjectModel:
        final List<ProjectModel> data = snapshot.data;
        return data.length;
      case EducationModel:
        final List<EducationModel> data = snapshot.data;
        return data.length;
      case LaborExeprienceModel:
        final List<LaborExeprienceModel> data = snapshot.data;
        return data.length;
      case SkillsModel:
        final List<SkillsModel> data = snapshot.data;
        return data.length;
      case StartupInfoModel:
        final StartupInfoModel data = snapshot.data;
        return data.team.length;
      default:
        return 0;
    }
  }

  IndexedWidgetBuilder _widgetBuilder(AsyncSnapshot snapshot) {
    switch (type) {
      case ThinkTankModel:
        final List<ThinkTankModel> data = snapshot.data;
        return (context, index) =>
            ThinkTankPreview(key: ObjectKey(data[index]), model: data[index]);
        break;
      case ProjectModel:
        final List<ProjectModel> data = snapshot.data;
        return (context, index) =>
            ProjectPost(key: ObjectKey(data[index]), model: data[index]);
      case EducationModel:
        final List<EducationModel> data = snapshot.data;
        return (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: EducationCard(model: data[index]),
            );
      case LaborExeprienceModel:
        final List<LaborExeprienceModel> data = snapshot.data;
        return (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ExperienceCard(model: data[index]),
            );
      case SkillsModel:
        final List<SkillsModel> data = snapshot.data;
        return (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SkillCard(model: data[index]),
            );
      case StartupInfoModel:
        final StartupInfoModel data = snapshot.data;
        return (context, index) => TeamListTile(
              startupName: data.name,
              user: data.team[index],
              onDelete: data.isUser
                  ? () async => await Provider.of<ProfileNotifier>(context)
                      .sendData(data.team[index])
                  : null,
            );
      default:
        return (_, __) => Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        title: title == null ? null : Text(title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(CupertinoIcons.search),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: floatingActionButton,
      body: StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: const CircularProgressIndicator());
            return Center(child: const Text('A Network Error Occured'));
          }
          final int count = _lengthCalculator(snapshot);
          if (count == 0) return emptyBuilder;
          return LiquidPullToRefresh(
            onRefresh: () async {},
            child: ListView.separated(
              itemCount: count,
              itemBuilder: _widgetBuilder(snapshot),
              separatorBuilder: (context, index) => separator,
            ),
          );
        },
      ),
    );
  }
}
