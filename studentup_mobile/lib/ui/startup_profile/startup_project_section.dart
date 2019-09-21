import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/models/project_model.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/profile_notifier.dart';
import 'package:studentup_mobile/ui/projects/projects_root.dart';

class StartupProjectSection extends StatelessWidget {
  final bool ongoing;

  const StartupProjectSection({Key key, @required this.ongoing})
      : assert(ongoing != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          '${ongoing ? 'Ongoing' : 'Past'} Projects',
          style: Theme.of(context)
              .textTheme
              .title
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0, bottom: 24.0),
          child: Consumer<ProfileNotifier>(
            builder: (context, notifier, child) {
              return StreamBuilder<List<ProjectModel>>(
                stream:
                    ongoing ? notifier.ongoingProjects : notifier.pastProjects,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<List<ProjectModel>> snapshot,
                ) {
                  if (!snapshot.hasData) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Center(
                        child: Text(
                            'No ${ongoing ? 'Ongoing' : 'Past'} Projects...'),
                      );
                    return Center(child: const Text('An Error Occured.'));
                  }
                  if (snapshot.data.isEmpty)
                    return Center(
                      child: Text(
                          'No ${ongoing ? 'Ongoing' : 'Past'} Projects...'),
                    );

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: snapshot.data
                        .map((m) => ProjectPost(model: m))
                        .toList(),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
