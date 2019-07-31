import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:provider/provider.dart';
import 'package:ui_dev/services/competition_creation_service.dart';

class NewCompetitionDeadline extends StatefulWidget {
  @override
  _NewCompetitionDeadlineState createState() => _NewCompetitionDeadlineState();
}

//TODO: Change the number of participants to a slider
class _NewCompetitionDeadlineState extends State<NewCompetitionDeadline> {
  void _setDeadline(DateTime date) {
    CompetitionCreationService _service =
        Provider.of<CompetitionCreationService>(context);
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
                //TODO: reset position of the marker when wrong date is picked.
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
            Consumer<CompetitionCreationService>(
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
            Consumer<CompetitionCreationService>(
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
          ],
        ),
      ),
    );
  }
}
