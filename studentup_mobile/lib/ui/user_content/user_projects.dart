import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentup_mobile/enum/query_order.dart';
import 'package:studentup_mobile/models/project_model.dart';
import 'package:studentup_mobile/router.dart';
import 'package:studentup_mobile/services/authentication/base_auth.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/services/storage/base_api.dart';
import 'package:studentup_mobile/ui/widgets/screens/see_all.dart';

class UserProjects extends StatefulWidget {
  @override
  _UserProjectsState createState() => _UserProjectsState();
}

class _UserProjectsState extends State<UserProjects> {
  @override
  Widget build(BuildContext context) {
    final String uid = Locator.of<BaseAuth>().currentUserId;
    final Stream<List<ProjectModel>> projectsStream =
        Locator.of<BaseAPIReader>().fetchProjectsByOwnerStream(
      uid,
      order: QueryOrder.newest,
    );
    return SeeAll(
      separator: const SizedBox(height: 16.0),
      stream: projectsStream,
      title: 'My Projects',
      type: ProjectModel,
      emptyBuilder: Center(
        child: const Text('You have no projects yet!'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: CupertinoColors.white,
        ),
        onPressed: () => Navigator.of(context).pushNamed(Router.newProject),
      ),
    );
  }
}
