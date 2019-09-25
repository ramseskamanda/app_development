import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/project_creation_notifier.dart';
import 'package:studentup_mobile/ui/widgets/dialogs/dialogs.dart';

class NewProjectDeadline extends StatefulWidget {
  @override
  _NewProjectDeadlineState createState() => _NewProjectDeadlineState();
}

class _NewProjectDeadlineState extends State<NewProjectDeadline> {
  void _setDeadline(DateTime date) {
    ProjectCreationNotifier _service =
        Provider.of<ProjectCreationNotifier>(context);
    if (date
        .isBefore(_service.minimumDeadline.subtract(const Duration(days: 1)))) {
      Dialogs.showProjectDeadlineErrorDialog(context, timetraveller: true);
    } else if (date.isAfter(_service.maximumDeadline)) {
      Dialogs.showProjectDeadlineErrorDialog(context, timetraveller: false);
    } else {
      _service.deadline = date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 24.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Deadline',
                style: Theme.of(context).textTheme.display1.copyWith(
                      color: Theme.of(context)
                          .textTheme
                          .display1
                          .color
                          .withAlpha(255),
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            const SizedBox(height: 32.0),
            //TODO: change calendars to a more modular one.
            Consumer<ProjectCreationNotifier>(
              builder: (context, service, child) {
                return Container(
                  child: Calendar(
                    initialDate: service.minimumDeadline,
                    events: <dynamic, dynamic>{},
                    onRangeSelected: (range) {},
                    onDateSelected: _setDeadline,
                    isExpandable: false,
                    showTodayIcon: true,
                    isExpanded: true,
                  ),
                );
              },
            ),
            const SizedBox(height: 60.0),
            Text(
              'Maximum number of participants:',
              softWrap: true,
              style: Theme.of(context).textTheme.title,
            ),
            const SizedBox(height: 48.0),
            Consumer<ProjectCreationNotifier>(
              builder: (context, service, child) {
                return Column(
                  children: <Widget>[
                    Text(
                      service.numParticipants.toString(),
                      style: Theme.of(context).textTheme.title,
                    ),
                    const SizedBox(height: 16.0),
                    Slider(
                      value: service.numParticipants.toDouble(),
                      divisions: (service.maximumParticipants -
                              service.minimumParticipants) ~/
                          10,
                      min: service.minimumParticipants,
                      max: service.maximumParticipants,
                      onChanged: (value) =>
                          service.numParticipants = value.toInt(),
                      label: service.numParticipants.toString(),
                      activeColor: Theme.of(context).accentColor,
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          ],
        ),
      ),
    );
  }
}
