import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:flutter_picker/flutter_picker.dart';

class NewCompetitionDeadline extends StatefulWidget {
  @override
  _NewCompetitionDeadlineState createState() => _NewCompetitionDeadlineState();
}

class _NewCompetitionDeadlineState extends State<NewCompetitionDeadline> {
  int _maxParticipants;
  List<String> _pickerData = <String>[
    'Unlimited',
    for (int j = 10; j < 30; j += 5) '$j',
    for (int k = 30; k <= 250; k += 10) '$k',
    '250 +',
  ];

  void _showNumberPicker() {
    Picker(
        height: MediaQuery.of(context).size.height * 0.4,
        adapter: PickerDataAdapter<String>(
          pickerdata: _pickerData,
        ),
        changeToFirst: true,
        textAlign: TextAlign.center,
        columnPadding: const EdgeInsets.all(8.0),
        onConfirm: (Picker picker, List value) {
          setState(() {
            _maxParticipants = value.first;
          });
        })
      ..showModal(context);
  }

  @override
  void initState() {
    super.initState();
    _maxParticipants = 0;
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
            Container(
              child: Calendar(
                events: <dynamic, dynamic>{},
                onRangeSelected: (range) {},
                onDateSelected: (date) => print(date),
                isExpandable: false,
                showTodayIcon: true,
                isExpanded: true,
              ),
            ),
            const SizedBox(height: 60.0),
            Text(
              'Maximum number of participants:',
              softWrap: true,
              style: Theme.of(context).textTheme.title,
            ),
            const SizedBox(height: 16.0),
            Ink(
              child: InkWell(
                onTap: _showNumberPicker,
                child: FittedBox(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 16.0,
                      ),
                      child: Center(
                        child: Text(
                          _pickerData[_maxParticipants],
                          style: Theme.of(context).textTheme.headline,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
