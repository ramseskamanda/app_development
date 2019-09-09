import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/project_creation_notifier.dart';

class ProjectUploader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectCreationNotifier>(
      builder: (context, service, child) {
        return StreamBuilder<double>(
          stream: service.uploadStream,
          builder: (context, snapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (service.isDone) ...[
                  Icon(
                    Icons.check_circle,
                    size: 48.0,
                    color: Theme.of(context).accentColor,
                  ),
                ] else if (snapshot.hasData) ...[
                  CircularPercentIndicator(
                    percent: snapshot.data,
                    radius: 48.0,
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                      'Your Project is being uploaded. Please be patient...'),
                ] else ...[
                  Text(
                    'Is all the information provided correct?',
                    style: Theme.of(context).textTheme.title,
                  ),
                  const SizedBox(height: 16.0),
                ],
              ],
            );
          },
        );
      },
    );
  }
}
