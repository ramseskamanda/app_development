import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/project_creation_notifier.dart';

class NewProjectDeadline extends StatefulWidget {
  @override
  _NewProjectDeadlineState createState() => _NewProjectDeadlineState();
}

class _NewProjectDeadlineState extends State<NewProjectDeadline> {
  void _setDeadline(DateTime date) {
    ProjectCreationNotifier _service =
        Provider.of<ProjectCreationNotifier>(context);
    if (date.isAfter(_service.minimumDeadline) &&
        date.isBefore(_service.maximumDeadline))
      _service.deadline = date;
    else
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('No time travel!'),
          content: const Text(
              'The date you selected is before our earliest deadline possible. Please select a later date.'),
          actions: <Widget>[
            FlatButton(
              child: const Text(
                'OK',
                style: TextStyle(color: CupertinoColors.activeBlue),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
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
                      color: CupertinoColors.black,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            const SizedBox(height: 32.0),
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
